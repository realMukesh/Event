import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:inventery/api_repository/app_url.dart';
import 'package:inventery/dashboard/model/dashboard_model.dart';
import 'package:inventery/theme/strings.dart';
import 'package:inventery/zappingDashboard/controller/userZappingController.dart';
import '../../api_repository/api_service.dart';
import '../../common_controller/authentication_manager.dart';
import '../../enventory/controller/onlineRedemtionController.dart';
import '../../enventory/model/common_model.dart';
import '../../enventory/model/scan_result_model.dart';
import '../../enventory/view/confim_dialog_page.dart';
import '../../login/view/loginPage.dart';
import '../../theme/ui_helper.dart';

class ZappingController extends GetxController  {
  late final AuthenticationManager _authManager;
  var isLoading=false.obs;
  var tabIndex=0;
  var dashboardList =<DashboardModel>[].obs;
  late final ZappingUserController _zappingUserController;
  var _selectedLocation="";
  var userFound=false;

  get selectedLocation => _selectedLocation;

  set selectedLocation(value) {
    _selectedLocation = value;
  }

  @override
  void onInit() {
    super.onInit();
    _authManager = Get.find();
    _zappingUserController=Get.put(ZappingUserController());
    createDashboardList();
  }
  createDashboardList(){
    dashboardList.add(DashboardModel(name: "Entry",icon: "assets/entry.png",isEnable: true));
    dashboardList.add(DashboardModel(name: "Gift",icon: "assets/gift.png",isEnable: true));
    dashboardList.add(DashboardModel(name: "Lunch",icon: "assets/dinner.png",isEnable: true));
    dashboardList.add(DashboardModel(name: "Dinner",icon: "assets/lunch.png",isEnable: true));
  }


  Future<Map<String, dynamic>> scanDetailResponse(BuildContext context, id) async {
    var result = Map<String, dynamic>();
    isLoading(true);
    ScanResultModel? inventoryDetailModel =
    await apiService.searchUser(userName: id);
    isLoading(false);
    if (inventoryDetailModel!.status!) {
      _zappingUserController.userList.addAll(inventoryDetailModel.data??[]);
      print("length${_zappingUserController.userList.length}");
      result = {"status": true, "message": inventoryDetailModel.message};
    } else {
      result = {"status": false, "message": inventoryDetailModel.message};
      UiHelper.showSnakbarMsg(context, inventoryDetailModel.message.toString());
    }
    isLoading(false);
    return result;
  }


  Future<Map<String, dynamic>> entryZapping(BuildContext context, {code,location}) async {
    var result = Map<String, dynamic>();
    isLoading(true);
    CommonModel? inventoryDetailModel =
    await apiService.entryZapping(code: code,location: _authManager.getLocation());
    isLoading(false);
    if(inventoryDetailModel!.status!){
      result = {"status": true, "message": inventoryDetailModel.message};
    }else{
      result = {"status": false, "message": inventoryDetailModel.message};
    }
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