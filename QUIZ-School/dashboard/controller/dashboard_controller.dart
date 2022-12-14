import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../common_controller/authentication_manager.dart';
import '../../login/view/loginPage.dart';
import '../../theme/strings.dart';
import '../../theme/ui_helper.dart';

class DashboardController extends GetxController  {
  late final AuthenticationManager _authManager;
  late FirebaseDatabase _firebaseDatabase;

  FirebaseDatabase get firebaseDatabase => _firebaseDatabase;

  AuthenticationManager get authManager => _authManager;

  late DatabaseReference _messagesRef;
  DatabaseReference get messagesRef => _messagesRef;

  late DatabaseReference _rankRef;
  DatabaseReference get rankRef => _rankRef;

  var tabIndex = 0;
  final isProfileEdit=false.obs;

  var questionIds=[].obs;

  /*used for timer*/
  late Timer timer;
  var start = 60.obs;
  var isTimerIsRunning = false.obs;


  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    _firebaseDatabase=FirebaseDatabase.instance;
    _messagesRef=FirebaseDatabase.instance.ref().child('quiz');
    _rankRef=FirebaseDatabase.instance.ref().child('rank');

    _authManager = Get.find();
  }

  Future<void> logoutUser(
      BuildContext context) async {
    var result=await UiHelper.showAlertDialog(title: "Aditya Birla Quiz",yes:MyStrings.logout,no:MyStrings.cancel,message: MyStrings.are_u_sure_want_logout);
    if(result){
      _authManager.removeToken();
      Get.offNamedUntil(LoginPage.routeName, (route) => false);
    }
    // googleAccount.value = await _googelSignin.signOut() as GoogleSignInAccount?;

  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (start == 0) {
          timer.cancel();
          isTimerIsRunning(false);
        } else {
          start--;
          isTimerIsRunning(true);
        }
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

}