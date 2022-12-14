
import 'package:firebase_chat/theme/app_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_chat/routes/app_pages.dart';
import 'package:firebase_chat/splash/splash_binding.dart';
import 'package:firebase_chat/splash/splash_page.dart';
import 'api_repository/api_service.dart';
import 'common_controller/authentication_manager.dart';


void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black, // navigation bar color
    statusBarColor: primaryColor, // status bar color
  ));
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initServices();
  runApp(const MyApp());
}

void initServices() {
  Get.put<AuthenticationManager>(AuthenticationManager());
  Get.putAsync<ApiService>(() => ApiService().init());
  // Get.put<StoreController>(StoreController());
  //Get.lazyPut<StoreController>(() => StoreController());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '',
      initialRoute: SplashScreen.routeName,
      initialBinding:SplashBinding(),
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}

