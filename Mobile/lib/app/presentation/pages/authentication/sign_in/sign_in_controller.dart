import 'dart:async';

import 'package:dating_app/app/common/base/base_controller.dart';
import 'package:dating_app/app/common/exceptions/error_code_enum.dart';
import 'package:dating_app/app/common/utils/functions.dart';
import 'package:dating_app/app/data/enums/auth_method_enum.dart';
import 'package:dating_app/app/data/repositories/auth_repository.dart';
import 'package:dating_app/app/data/repositories/user_repository.dart';
import 'package:dating_app/app/presentation/pages/authentication/sign_in/mixins/phone_authentication_mixin.dart';
import 'package:dating_app/app/routes/app_pages.dart';
import 'package:dating_app/app/widgets/loader_widget/loader_controller.dart';
import 'package:dating_app/app/widgets/new_dialog/custom_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'mixins/email_authentication_mixin.dart';
import 'mixins/validate_mixin.dart';

class SignInController extends BaseController
    with EmailAuthenticationMixin, PhoneAuthenticationMixin, ValidateFormMixin {
  Rx<AuthMethod> authMethod = Rx(AuthMethod.email);
  AuthRepository repository = Get.find<AuthRepository>();
  UserRepository userRepository = Get.find<UserRepository>();
  final commonController = Get.find<CommonController>();
  RxBool isNewAccount = RxBool(false);
  Rx<UserCredential?> user = Rx(null);
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late StreamSubscription streamSubscription;
  RxBool isForgotPassword = false.obs;

  @override
  void onInit() {
    super.onInit();
    streamSubscription = user.stream.listen((UserCredential? authState) async {
      await handlerNavigate(authState?.user);
    });
    // repository.signOut();
  }

  Future<void> handlerNavigate(User? authState) async {
    if (authState != null) {
      if (await repository.isExistUserData(authState.uid)) {
        Get.offAllNamed(RouteList.main);
      } else if (authState.isAnonymous) {
        // create new anonymous account in database by api
        final user = await userRepository.createGuestUser();
        Get.offAllNamed(RouteList.main);
      } else {
        Get.offAndToNamed(RouteList.signUp);
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
    inputListener();
  }

  @override
  void onClose() {
    streamSubscription.cancel();
    super.onClose();
  }

  Future<void> loginWithEmail() async {
    if (validateForm) {
      commonController.startLoading();
      try {
        if (emailTextController.text.contains('@')) {
          user.value = await repository.signInWithEmail(
              email: emailTextController.text,
              password: passwordTextController.text);
        } else {
          try {
            user.value = await repository.signInWithUsername(
                username: emailTextController.text,
                password: passwordTextController.text);
          } on Exception catch (_) {
            commonController.showDialog(
                dialog: CustomDialog(
              title: 'Thông báo',
              description: 'Username/mật khẩu không đúng!',
              onAccept: () {
                Get.back();
              },
            ));
          }
        }
        FunctionUtils.logWhenDebug('onSubmittedEmail', '$user');
      } on FirebaseAuthException catch (e) {
        commonController.showDialog(
            dialog: CustomDialog(
          title: 'Thông báo',
          description: ErrorCodeEnum.getErrorCode(e.code)?.message ?? e.code,
          onAccept: () {
            Get.back();
          },
        ));
      }
      commonController.stopLoading();
    }
  }

  Future<void> signUpWithEmail() async {
    if (validateForm) {
      if (isMatchPassword) {
        commonController.startLoading();
        try {
          commonController.startLoading();
          user.value = await repository.signUpWithEmail(
              email: emailTextController.text,
              password: passwordTextController.text);
          FunctionUtils.logWhenDebug('signUP with: ', '$user');
          FunctionUtils.logWhenDebug(this, 'send verify email');
          await repository.sendEmailVerification();
        } on FirebaseAuthException catch (e) {
          commonController.showDialog(
              dialog: CustomDialog(
            title: 'Thông báo',
            description: ErrorCodeEnum.getErrorCode(e.code)?.message ?? e.code,
            onAccept: () {
              Get.back();
            },
          ));
        }
        commonController.stopLoading();
      } else {
        commonController.showDialog(
            dialog: CustomDialog(
                description: 'Mật khẩu không khớp',
                onAccept: () {
                  Get.back();
                }));
      }
    }
  }

  Future<bool> isFirstTime(UserCredential user) async {
    return await repository.isExistUserData(user.user!.uid);
  }

  @override
  void signInWithPhone() {
    /* Get.to(PhoneInputScreen(
      auth: firebaseAuth,
      action: isSignUpWithEmail.isFalse ? AuthAction.signUp : AuthAction.signIn,
    ));*/
    Get.toNamed(RouteList.signInWithPhone);
  }

  Future<void> continueWithoutSignIn() async {
    user.value = await repository.signInAnonymously();
  }

  Future<void> signInWithGoogle() async {
    user.value = await repository.signInWithGoogle();
  }

  Future<void> signInWithFacebook() async {
    user.value = await repository.signInWithFacebook();
  }

  Future<void> resetPassword() async {
    commonController.startLoading();
    String input = emailTextController.text;
    bool isEmail = input.contains('@');
    try {
      if (!isEmail) {
        input = await repository.getEmailFromUsername(username: input);
      }
      await repository.sendPasswordResetEmail(email: input);
      commonController.stopLoading();
      commonController.showDialog(
          dialog: CustomDialog(
        title: 'Thông báo',
        description:
            'send_password_reset_email_success_full'.trParams({'email': input}),
        onAccept: () {
          Get.back();
          isForgotPassword.value = false;
        },
      ));
    } on Exception catch (_) {
      commonController.showDialog(
          dialog: CustomDialog(
        title: 'Thông báo',
        description: 'account_not_found'.tr + input,
        onAccept: () {
          Get.back();
        },
      ));
    }
  }

  void onTapBack() {
    isForgotPassword.value = false;
    emailTextController.clear();
    passwordTextController.clear();
    rePasswordTextController.clear();
    onTapSignInWithEmailText();
    Get.back();
  }
}
