import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../common_controller/authentication_manager.dart';
import '../../login/view/mainPage.dart';
import '../../theme/strings.dart';
import '../../theme/ui_helper.dart';

class DashboardController extends GetxController  {
  late final AuthenticationManager _authManager;


  AuthenticationManager get authManager => _authManager;


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

    _authManager = Get.find();
  }

  Future<void> logoutUser(
      BuildContext context) async {
    var result=await UiHelper.showAlertDialog(title: "Aditya Birla Quiz",yes:MyStrings.logout,no:MyStrings.cancel,message: MyStrings.are_u_sure_want_logout);
    if(result){
      _authManager.removeToken();
      Get.offNamedUntil(MainPage.routeName, (route) => false);
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