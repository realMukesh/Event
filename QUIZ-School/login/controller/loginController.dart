import 'package:firebase_chat/api_repository/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../common_controller/authentication_manager.dart';
import '../../dashboard/view/dashboard_page.dart';
import '../../theme/ui_helper.dart';
import '../model/login_response.dart';

class LoginController extends GetxController {
  late final AuthenticationManager _authManager;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _authManager = Get.find();
  }

  Future<void> loginUser(
      String email, String password, BuildContext context) async {
    var map = Map<String, dynamic>();
    map['email'] = email;
    map['password'] = password;
    map['device_token'] = _authManager.getFcmToken();

    isLoading(true);
    LoginResponseModel? loginResponseModel = await apiService.login(map);
    isLoading(false);
    if (loginResponseModel!.success!) {
      _authManager.setUserProfile(
          role: loginResponseModel.results?.role.toString() ?? "",
          userName: loginResponseModel.results?.name ?? "",
          teamName: loginResponseModel.results?.teamName ?? "",
          userId: loginResponseModel.results?.sId.toString() ?? "");
      _authManager.saveToken(loginResponseModel.results!.token.toString());
      Get.offNamedUntil(DashboardPage.routeName, (route) => false);
    } else {
      UiHelper.showSnakbarMsg(context, loginResponseModel.message.toString());
    }
  }

  googleLogin() {
    /*googleAccount.value = await _googelSignin.signIn() as GoogleSignInAccount?;
    _authManager.login("token");
    _authManager.setProfileData(
        username: googleAccount.value!.displayName ?? "",
        email: googleAccount.value!.email ?? "",
        profile: googleAccount.value!.photoUrl??"");
    checkUserExit(googleAccount.value!.id);*/
  }
}
