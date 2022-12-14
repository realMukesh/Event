import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inventery/routes/app_pages.dart';
import 'package:inventery/splash/splash_binding.dart';
import 'package:inventery/splash/splash_page.dart';
import 'api_repository/api_service.dart';
import 'common_controller/authentication_manager.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'fcm/firebase_options.dart';



void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white, // navigation bar color
    statusBarColor: Colors.white, // status bar color
  ));
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
 /* await Firebase.initializeApp(
    name: "crosspoles",
      options: DefaultFirebaseOptions.currentPlatform);*/

  initServices();
  runApp(const MyApp());
}

void initServices() {
  Get.put<AuthenticationManager>(AuthenticationManager());
  Get.putAsync<ApiService>(() => ApiService().init());
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
      //theme: ThemeData(fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
    );
  }
}

