part of 'app_pages.dart';

abstract class RouteList {
  static const welcome = '/welcome';
  static const signIn = '/login';
  static const signInWithEmail = '/login/email';
  static const signInWithPhone = '/login/phone';
  static const verifyPhoneNumberScreen = '/login/phone/verify';
  static const signUp = '/sign-up';
  static const hobby = '/hobby';
  static const main = '/main';
  static const search = '/main/feed';
  static const matches = '/main/matches';
  static const message = '/main/message';
  static const profile = '/main/profile';
  static const setting = '/main/profile/setting';
  static const edit = '/main/profile/edit';
  static const userProfile = '/main/feed/userProfile';
  static const detailMessage = '/main/message/:id';
  static const payment = '/payment';
  static const premiumInit = '/premium';
  static const admin = '/admin';
  static const call = '/call';
  static const paymentScreen = '/paymentScreen';
  static const paymentList = '/payment_histories';
  static const paymentDetail = '/$paymentList/:id';
  static const galleryView = '/gallery_view';

  static String paymentDetailRoute({required String id}) => '$paymentList/$id';
  static String chatDetailRoute({required String id}) => '$message/$id';
}
