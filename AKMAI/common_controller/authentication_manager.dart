import 'package:get/get.dart';
import 'package:inventery/api_repository/app_url.dart';

import '../fcm/push_notification_service.dart';
import '../routes/my_constant.dart';
import '../storage/cache_manager.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';

class AuthenticationManager extends GetxController with CacheManager {
  final isLogged = false.obs;
  var isForTransferIn=false.obs;
  //late FirebaseMessaging _firebaseMessaging;
  var notificationCount=0.obs;

  @override
  void onInit() {
    super.onInit();
    //_firebaseMessaging=FirebaseMessaging.instance;
   /* final pushNotificationService = PushNotificationService(_firebaseMessaging);
    pushNotificationService.initialise();*/
    getFcmTokenFrom();
  }

  /*get device token from firebase service*/
  void getFcmTokenFrom() async {
   /* _firebaseMessaging.getToken().then((token) {
      saveFcmToken(token);
      print('token: $token');
    }).catchError((err) {
      print("This is bug from FCM${err.message.toString()}");

    });

    FirebaseMessaging.onMessage.listen((event) {
      notificationCount=notificationCount+1;
      print('Notification is come');
    },);*/

  }


  void logOut() {
    isLogged.value = false;
    //profile.name="";
    //removeToken();
  }

  void login(String? token) async {
    isLogged.value = true;
    //Token is cached
    await saveToken(token);
  }

  void setFcmToken(String? token) async {
    //Token is cached
    await saveFcmToken(token);
  }
  String? getFcm()  {
    final token = getFcmToken();
    return token;
  }

  bool isLogin(){
    final token = getToken();
    if (token != null) {
      isLogged.value = true;
    }else{
      isLogged.value = false;
    }
    return isLogged.value;
  }
  void checkLoginStatus() {
    final token = getToken();
    if (token != null) {
      isLogged.value = true;
    }
  }
}