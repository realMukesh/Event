import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:inventery/login/view/loginPage.dart';
import '../../api_repository/api_service.dart';
import '../../common_controller/authentication_manager.dart';
import '../../dashboard/view/dashboard_page.dart';
import '../../theme/strings.dart';
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

  Future<void> logoutUser(BuildContext context) async {
    var result = await UiHelper.showAlertDialog(
        title: MyStrings.crosspoles,
        yes: MyStrings.logout,
        no: MyStrings.cancel,
        message: MyStrings.are_u_sure_want_logout);
    if (result) {
      _authManager.removeToken();
      Get.offNamedUntil(LoginPage.routeName, (route) => false);
    }
    // googleAccount.value = await _googelSignin.signOut() as GoogleSignInAccount?;
  }

  Future<void> loginUser(String mobile, BuildContext context) async {
    var map = Map<String, dynamic>();
    map['mobile'] = mobile;
    map['device_token'] = _authManager.getFcmToken();
    _authManager.isLogged.value;
    isLoading(true);
    LoginResponseModel? loginResponseModel = await apiService.login(userName: mobile);
    isLoading(false);
    if (loginResponseModel!.status!) {
      _authManager.setProfileData(
          email: loginResponseModel.user?.id.toString() ?? "",
          mobile: loginResponseModel.user!.username ?? "",
          profile: loginResponseModel.user!.category ?? "",
          username: "");
      _authManager.isLogged.value;
      Get.offNamedUntil(DashboardPage.routeName, (route) => false);
    } else {
      UiHelper.showSnakbarMsg(context, loginResponseModel.message.toString());
    }
  }
}
