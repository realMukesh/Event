import 'package:get/get.dart';

import '../dashboard/controller/printing_controller.dart';
import '../fcm/push_notification_service.dart';
import '../storage/cache_manager.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';




class AuthenticationManager extends GetxController with CacheManager {
  final isLogged = false.obs;
  var isForTransferIn=false.obs;
  var locationList = <String>[].obs;
  late final PrintingController _printingController ;



  //late FirebaseMessaging _firebaseMessaging;


  @override
  void onInit() {
    super.onInit();
    //_printingController=Get.put(PrintingController());
    //_firebaseMessaging=FirebaseMessaging.instance;
   /* final pushNotificationService = PushNotificationService(_firebaseMessaging);
    pushNotificationService.initialise();*/
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