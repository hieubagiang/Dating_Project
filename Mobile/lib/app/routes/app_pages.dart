import 'package:dating_app/app/presentation/pages/admin/admin_binding.dart';
import 'package:dating_app/app/presentation/pages/authentication/phone_authentication/phone_authentication_screen.dart';
import 'package:dating_app/app/presentation/pages/authentication/phone_authentication/widget/verify_phone_number/verify_phone_number_binding.dart';
import 'package:dating_app/app/presentation/pages/authentication/phone_authentication/widget/verify_phone_number/verify_phone_number_screen.dart';
import 'package:dating_app/app/presentation/pages/authentication/sign_in/sign_in_binding.dart';
import 'package:dating_app/app/presentation/pages/authentication/sign_in/sign_in_screen.dart';
import 'package:dating_app/app/presentation/pages/authentication/sign_in/sign_in_with_email_screen.dart';
import 'package:dating_app/app/presentation/pages/authentication/sign_up/sign_up_binding.dart';
import 'package:dating_app/app/presentation/pages/authentication/sign_up/sign_up_view.dart';
import 'package:dating_app/app/presentation/pages/connection/connection_binding.dart';
import 'package:dating_app/app/presentation/pages/connection/connection_screen.dart';
import 'package:dating_app/app/presentation/pages/connection/widgets/liked_tab/liked_tab_binding.dart';
import 'package:dating_app/app/presentation/pages/connection/widgets/liked_tab/liked_tab_screen.dart';
import 'package:dating_app/app/presentation/pages/edit/edit_binding.dart';
import 'package:dating_app/app/presentation/pages/edit/edit_screen.dart';
import 'package:dating_app/app/presentation/pages/feed/feed_binding.dart';
import 'package:dating_app/app/presentation/pages/feed/feed_screen.dart';
import 'package:dating_app/app/presentation/pages/main/main_binding.dart';
import 'package:dating_app/app/presentation/pages/main/main_screen.dart';
import 'package:dating_app/app/presentation/pages/message/detail_message/detail_message_binding.dart';
import 'package:dating_app/app/presentation/pages/message/detail_message/detail_message_screen.dart';
import 'package:dating_app/app/presentation/pages/message/message_list/message_list_binding.dart';
import 'package:dating_app/app/presentation/pages/message/message_list/message_list_screen.dart';
import 'package:dating_app/app/presentation/pages/premium/payment_screen.dart';
import 'package:dating_app/app/presentation/pages/premium/premium_binding.dart';
import 'package:dating_app/app/presentation/pages/premium/widgets/premium_init.dart';
import 'package:dating_app/app/presentation/pages/profile/profile_binding.dart';
import 'package:dating_app/app/presentation/pages/profile/profile_screen.dart';
import 'package:dating_app/app/presentation/pages/settings/setting_screen.dart';
import 'package:dating_app/app/presentation/pages/settings/settings_binding.dart';
import 'package:dating_app/app/presentation/pages/user_profile/user_profile_binding.dart';
import 'package:dating_app/app/presentation/pages/user_profile/user_profile_screen.dart';
import 'package:dating_app/app/presentation/pages/welcome/welcome_binding.dart';
import 'package:dating_app/app/presentation/pages/welcome/welcome_screen.dart';
import 'package:get/get.dart';

import '../presentation/pages/admin/admin_screen.dart';
import '../presentation/pages/authentication/phone_authentication/phone_authentication_binding.dart';
import '../presentation/pages/call_module/call_binding.dart';
import '../presentation/pages/call_module/call_screen.dart';
import '../presentation/pages/gallery_view_screen/index.dart';
import '../presentation/pages/payment_detail/index.dart';
import '../presentation/pages/payment_history/index.dart';
import '../presentation/pages/vn_pay/vn_pay_binding.dart';
import '../presentation/pages/vn_pay/vn_pay_screen.dart';

part 'app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
        name: RouteList.welcome,
        page: () => WelcomeScreen(),
        binding: WelcomeBinding()),
    GetPage(
        name: RouteList.signIn,
        page: () => SignInScreen(),
        binding: SignInBinding()),
    GetPage(
        name: RouteList.signInWithEmail, page: () => SignInWithEmailScreen()),
    GetPage(
        name: RouteList.signInWithPhone,
        page: () => PhoneAuthenticationScreen(),
        binding: PhoneAuthenticationBinding()),
    GetPage(
        name: RouteList.verifyPhoneNumberScreen,
        page: () => VerifyPhoneNumberScreen(),
        binding: VerifyPhoneNumberBinding()),
    GetPage(
        name: RouteList.signUp,
        page: () => SignUpMain(),
        binding: SignUpBinding()),
    GetPage(
      name: RouteList.main,
      binding: MainBinding(),
      page: () => MainScreen(),
    ),
    GetPage(
        name: RouteList.search,
        page: () => FeedScreen(),
        binding: FeedBinding()),
    GetPage(
        name: RouteList.matches,
        page: () => MatchesScreen(),
        binding: MatchesBinding()),
    GetPage(
        name: RouteList.matches,
        page: () => LikedTabScreen(),
        binding: LikedTabBinding()),
    GetPage(
        name: RouteList.message,
        page: () => MessageListScreen(),
        binding: MessageListBinding()),
    GetPage(
        name: RouteList.setting,
        page: () => SettingsScreen(),
        binding: SettingsBinding()),
    GetPage(
        name: RouteList.userProfile,
        page: () => UserProfileScreen(),
        binding: UserProfileBinding()),
    GetPage(
        name: RouteList.profile,
        page: () => ProfileScreen(),
        binding: ProfileBinding()),
    GetPage(
        name: RouteList.edit, page: () => EditScreen(), binding: EditBinding()),
    GetPage(
        name: RouteList.detailMessage,
        page: () => DetailMessageScreen(),
        binding: DetailMessageBinding()),
    GetPage(
        name: RouteList.payment,
        page: () => PaymentScreen(),
        binding: PremiumBinding()),
    // GetPage(name: RouteList.hobby, page: () => SignUpHobby()),
    GetPage(name: RouteList.premiumInit, page: () => PremiumInit()),
    GetPage(
        name: RouteList.admin,
        page: () => AdminScreen(),
        binding: AdminBinding()),
    GetPage(
        name: RouteList.call, page: () => CallScreen(), binding: CallBinding()),
    GetPage(
        name: RouteList.paymentScreen,
        page: () => const VnPayScreen(),
        binding: VnPayBinding()),
    GetPage(
      name: RouteList.paymentList,
      page: () => const PaymentHistoriesScreen(),
      binding: PaymentHistoriesBinding(),
    ),
    GetPage(
      name: RouteList.paymentDetail,
      page: () => const PaymentDetailScreen(),
      binding: PaymentDetailBinding(),
    ),
    GetPage(
      name: RouteList.galleryView,
      page: () => const GalleryViewScreenScreen(),
      binding: GalleryViewScreenBinding(),
    ),
  ];
}
