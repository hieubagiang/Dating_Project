import 'dart:async';
import 'dart:convert';

import 'package:dating_app/app/common/base/base_controller.dart';
import 'package:dating_app/app/common/extension/extensions.dart';
import 'package:dating_app/app/common/helper/geolocator_helpers.dart';
import 'package:dating_app/app/common/helper/local_notification_helper.dart';
import 'package:dating_app/app/common/helper/push_notificaction_helper/push_notification_helper.dart';
import 'package:dating_app/app/common/utils/index.dart';
import 'package:dating_app/app/data/models/notification/notification_payload.dart';
import 'package:dating_app/app/data/models/user_model/position_model/position_model.dart';
import 'package:dating_app/app/data/models/user_model/user_model.dart';
import 'package:dating_app/app/data/repositories/user_repository.dart';
import 'package:dating_app/app/routes/app_pages.dart';
import 'package:dating_app/app/widgets/loader_widget/loader_controller.dart';
import 'package:dating_app/app/widgets/new_dialog/confirm_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../common/helper/ad_helper.dart';
import '../../../data/enums/call_status_enum.dart';
import '../../../data/enums/notification_type.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../widgets/new_dialog/custom_dialog.dart';
import 'main_tab_bar_enum.dart';

class MainController extends BaseController {
  var selectedIndex = 0.obs;
  RxInt chatTotalUnreadCount = 0.obs;
  List<BaseController> controllerList = [];
  RxBool isInitDone = false.obs;
  PersistentTabController tabController =
      PersistentTabController(initialIndex: 0);
  final userRepository = Get.find<UserRepository>();
  Rx<UserModel?> currentUser = Rx(null);
  final commonController = Get.find<CommonController>();
  bool _isOpenSetting = false;
  final PushNotificationHelper _pushHelper = PushNotificationHelper();
  bool isGuestMode = true;
  AdHelper adHelper = AdHelper();
  static final isDemoMode = false;
  List<StreamSubscription> subs = [];
  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }

  int lastTap = DateTime.now().millisecondsSinceEpoch;
  int consecutiveTaps = 1;
  var isFirst = true;

  @override
  Future<void> onInit() async {
    super.onInit();
    _pushHelper.onMessageStream.listen(_onReceiveNotification);

    isGuestMode = userRepository.getFireBaseUser()?.isAnonymous ?? false;
    if (!isGuestMode) {
      currentUser.bindStream(userRepository.listenUser());
      await _initGoogleMobileAds();
    } else {
      currentUser.value = await userRepository.getUser();
    }
    currentUser.stream.first.then((currentUser) {
      if (isFirst) {
        if (!(currentUser?.isPremiumUser ?? false)) {
          _showInterstitialAd();
        }
        if (!isGuestMode) {
          if (currentUser == null) {
            print('null user data');
            commonController.stopLoading();
            commonController.showDialog(
                dialog: CustomDialog(
              title: 'Thông báo',
              description: 'not_registered'.tr,
              acceptText: 'signUp'.tr,
              onAccept: () {
                Get.back();
                Get.offAllNamed(RouteList.signUp);
              },
            ));
            return;
          }
          FunctionUtils.logWhenDebug(this, 'currentUserId= ${currentUser.id}');
          checkLocationPermission();
        }
        isFirst = false;
      }
    });
    LocalNotificationHelper().onTapLocalNotification = ((notification) {
      final payload = NotificationPayload.fromPayload(
          jsonDecode(notification) as Map<String, dynamic>);
      FunctionUtils.logWhenDebug(this, 'payload $payload');
      payload.checkRoute();
    });
    _pushHelper.initialize(handleNotificationTap: _handlerOnTap).whenComplete(
        () async => userRepository.updateFCMToken(
            (await PushNotificationHelper().getPushToken()) ?? ''));

    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();

    commonController.stopLoading();
    isInitDone.value = true;
  }

  Future<void> _showInterstitialAd() async {
    adHelper.createInterstitialAd();
  }

  Future<void> checkLocationPermission() async {
    await Future.delayed(Duration(seconds: 1));
    try {
      Position? position = await LocationHelper.getPosition(
          context: Get.context!,
          onPermissionDeniedForever: () {
            commonController.stopLoading();
          });
      if (position != null) {
        FunctionUtils.logWhenDebug(this, '$position');
        String address = await LocationHelper.locationToAddress(
            lat: position.latitude,
            long: position.longitude,
            isGetDetail: false);
        var positionModel =
            PositionModel.fromPosition(position).copyWith(address: address);
        await userRepository.updateUserLocation(positionModel);
      }
    } on LocationPermissionException catch (e) {
      print('exception $e');
      if (e.message == LocationPermissionError.permissionDenied.error ||
          e.message == LocationPermissionError.serviceDisabled.error) {
        checkLocationPermission();
      } else if (e.message ==
          LocationPermissionError.permissionPermanentlyDenied.error) {
        _isOpenSetting = true;
        await Geolocator.openAppSettings();
        _isOpenSetting = false;
      }
    }
  }

  void handleIndexChanged(int index) {
    selectedIndex.value = index;
  }

  RxBool isSelected(int index) {
    return RxBool(index == tabController.index);
  }

  void onChangeTab(int value) {
    if (value == TabBarType.message.id && MainController.isDemoMode) {
      FunctionUtils.showToast('coming_soon'.tr);
      return;
    }
    if (value == TabBarType.settings.id) {
      multiTapCheck();
    }
    if (value != 0 && isGuestMode) {
      logOutGuest();
    } else {
      selectedIndex.value = value;
      tabController.index = value;
    }
  }

  void logOutGuest() {
    commonController.showDialog(
      dialog: ConfirmDialog(
        context: Get.context!,
        description: 'guest_user_message'.tr,
        onConfirmed: () async {
          await signOut();
        },
      ),
    );
  }

  Future<void> signOut() async {
    await userRepository.updateFCMToken('');

    await Get.find<AuthRepository>().signOut();
    Get.offAndToNamed(RouteList.signIn);
  }

  @override
  Future<void> onResumed() async {
    super.onResumed();
    if (!_isOpenSetting) {
      checkLocationPermission();
    }
  }

  @override
  Future<void> onClose() async {
    commonController.stopLoading();
    for (var sub in subs) {
      sub.cancel();
    }
    super.onClose();
  }

  Future<void> _onReceiveNotification(RemoteMessage remoteMessage) async {
    if (remoteMessage.data.isNotEmpty) {
      final res = NotificationPayload.fromPayload(remoteMessage.data);
      if (res.notificationType == NotificationType.call &&
          res.callModel?.callStatus == CallStatusType.ringing) {
        return;
      }
    }

    if (remoteMessage.notification != null) {
      LocalNotificationHelper().showNotification(
        channelId: highChannelId,
        channelName: highImportance,
        channelDescription: highChannelDescription,
        channelSound: notificationSoundPath,
        title: remoteMessage.notification?.title ?? '',
        body: remoteMessage.notification?.body ?? '',
        payload: jsonEncode(remoteMessage.data),
      );
    }
  }

  void multiTapCheck() {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (consecutiveTaps == 1) {
      print("taps = " + consecutiveTaps.toString());
      lastTap = now;
    }
    if (now - lastTap < 300) {
      print("Consecutive tap");
      consecutiveTaps++;
      print("taps = " + consecutiveTaps.toString());
      if (consecutiveTaps == 3) {
        print("Consecutive tap 3");
        if (kDebugMode) {
          Get.toNamed(RouteList.admin);
        }
      } else if (consecutiveTaps == 2) {
        print("Consecutive tap 2");
      }
    } else {
      consecutiveTaps = 1;
    }
    lastTap = now;
  }

  _handlerOnTap(RemoteMessage message) async {
    final res = NotificationPayload.fromPayload(message.data);
  }

  Future<void> getCurrentUser() async {
    currentUser.value =
        await Get.find<UserRepository>().getUser().withProgressDialog();
  }
}
