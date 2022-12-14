import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:inventery/dashboard/model/dashboard_model.dart';
import 'package:inventery/enventory/model/scan_result_model.dart';
import 'package:inventery/theme/strings.dart';
import '../../api_repository/api_service.dart';
import '../../common_controller/authentication_manager.dart';
import '../../enventory/controller/onlineRedemtionController.dart';
import '../../login/view/loginPage.dart';
import '../../theme/ui_helper.dart';

class DashboardController extends GetxController  {
  late final AuthenticationManager _authManager;
  var isLoading=false.obs;
  var tabIndex=0;
  var dashboardList =<DashboardModel>[].obs;
  late final OnlineRedemtionController _onlineRedemtionController;



  @override
  void onInit() {
    super.onInit();
    _authManager = Get.find();
    _onlineRedemtionController=Get.put(OnlineRedemtionController());
    createDashboardList();
  }

  createDashboardList(){
    dashboardList.add(DashboardModel(name: "Online \n Redemtion",icon: "assets/online_redemtion.png", isEnable: true));
    dashboardList.add(DashboardModel(name: "Onsite \n Registration",icon: "assets/onsite registration.png",isEnable: false));
    dashboardList.add(DashboardModel(name: "Search for Print",icon: "assets/search_print.png",isEnable: false));
    dashboardList.add(DashboardModel(name: "Entry Zapping",icon: "assets/zapping.png",isEnable: false));
  }

  Future<Map<String, dynamic>> scanDetailResponse(BuildContext context, id) async {
    var result = Map<String, dynamic>();
    isLoading(true);
    ScanResultModel? inventoryDetailModel =
    await apiService.searchUser(userName: id);
    isLoading(false);
    if (inventoryDetailModel!.status!) {
      _onlineRedemtionController.userList.clear();
      _onlineRedemtionController.userList.addAll(inventoryDetailModel.data??[]);
      result = {"status": true, "message": inventoryDetailModel.message};
    } else {
      result = {"status": false, "message": inventoryDetailModel.message};
      UiHelper.showSnakbarMsg(context, inventoryDetailModel.message.toString());
    }
    isLoading(false);
    return result;
  }

  Future<void> logoutUser(
      BuildContext context) async {
    var result=await UiHelper.showAlertDialog(title: MyStrings.crosspoles,yes:MyStrings.logout,no:MyStrings.cancel,message: MyStrings.are_u_sure_want_logout);
    if(result){
      _authManager.removeToken();
      Get.offNamedUntil(LoginPage.routeName, (route) => false);
    }
    // googleAccount.value = await _googelSignin.signOut() as GoogleSignInAccount?;

  }
}