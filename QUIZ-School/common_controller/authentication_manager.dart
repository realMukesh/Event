import 'package:get/get.dart';
import '../storage/cache_manager.dart';
class AuthenticationManager extends GetxController with CacheManager {
  late final isLogged;

  @override
  void onInit() {
    super.onInit();
    //getFcmTokenFrom();
  }

  /*get device token from firebase service*/
  void getFcmTokenFrom() async {
     /*firebaseMessaging.getToken().then((token) {
      saveFcmToken(token);
      print('token: $token');
    }).catchError((err) {
      print("This is bug from FCM${err.message.toString()}");

    });*/
  }

  void logOut() {
    removeToken();
  }
  void login(String? token) async {
    isLogged.value = true;
    //Token is cached
    await saveToken(token);
  }

  bool isLogin() {
    if(getToken()!=null && getToken()!.isNotEmpty){
      isLogged= true;
    }else{
      isLogged= false;;
    }
    return isLogged;
  }
}