import 'package:firebase_chat/login/welcome_page.dart';
import 'package:get/get.dart';
import 'package:firebase_chat/dashboard/view/dashboard_page.dart';
import '../dashboard/controller/dashboard_binding.dart';

import '../login/view/loadCsvPage.dart';
import '../login/view/mainPage.dart';
import '../splash/splash_binding.dart';
import '../splash/splash_page.dart';


class AppPages {
  static final pages = [
    GetPage(name: SplashScreen.routeName, page: () => const SplashScreen(),binding: SplashBinding()),
    GetPage(name: MainPage.routeName, page: () => MainPage()),
    GetPage(name: WelcomePage.routeName, page: () => WelcomePage()),
    GetPage(name: LoadCsvDataScreen.routeName, page: () => LoadCsvDataScreen()),

    GetPage(
        name: DashboardPage.routeName,
        binding: RootBinding(),
        page: () => DashboardPage()),

    /*GetPage(name: Routes.LOGIN, page: () => LoginPage(),binding: LoginBinding()),
    GetPage(name: Routes.SIGNUP, page: () => SignupPage(),binding: LoginBinding()),
    GetPage(name: Routes.OTP, page: () => OTPPage(),binding: OTPBinding()),
    GetPage(name: Routes.FORGOT_PASSWORD, page: () => ForgotPasswordPage(),binding: ForgotPasswordBinding()),
    GetPage(name: InitialProfile.routeName, page: () => InitialProfile()),*/
  ];
}
