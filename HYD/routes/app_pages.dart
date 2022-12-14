import 'package:get/get.dart';
import 'package:inventery/dashboard/view/dashboard_page.dart';
import '../dashboard/controller/dashboard_binding.dart';
import '../enventory/view/user_list_page.dart';
import '../login/view/loginPage.dart';

import '../login/view/online-registration.dart';
import '../splash/splash_binding.dart';
import '../splash/splash_page.dart';
import '../zappingDashboard/view/zapping_page.dart';
import '../zappingDashboard/view/zapping_user_list_page.dart';


class AppPages {
  static final pages = [
    GetPage(name: SplashScreen.routeName, page: () => const SplashScreen(),binding: SplashBinding()),
    GetPage(name: LoginPage.routeName, page: () => LoginPage()),
    GetPage(name: UserListPage.routeName, page: () => UserListPage()),
    GetPage(name: OnineRegistrationPage.routeName, page: () => OnineRegistrationPage()),
    GetPage(name: ZappingUserListPage.routeName, page: () => ZappingUserListPage()),

    GetPage(
        name: ZappingDashboardPage.routeName,
        binding: RootBinding(),
        page: () => ZappingDashboardPage()),


    GetPage(
        name: DashboardPage.routeName,
        binding: RootBinding(),
        page: () => DashboardPage()),

  ];
}
