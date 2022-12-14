import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:inventery/dashboard/controller/printing_controller.dart';
import 'package:inventery/dashboard/model/dashboard_model.dart';
import 'package:inventery/enventory/model/scan_result_model.dart';
import 'package:inventery/theme/strings.dart';
import '../../api_repository/api_service.dart';
import '../../common_controller/authentication_manager.dart';
import '../../enventory/controller/onlineRedemtionController.dart';
import '../../login/model/register_response.dart';
import '../../login/view/loginPage.dart';
import '../../theme/ui_helper.dart';

class DashboardController extends GetxController  {
  late final AuthenticationManager _authManager;

  AuthenticationManager get authManager => _authManager;
  var isLoading=false.obs;
  var tabIndex=0;
  var dashboardList =<DashboardModel>[].obs;
  late final OnlineRedemtionController _onlineRedemtionController;
  late final PrintingController printingController;



  @override
  void onInit() {
    super.onInit();
    _authManager = Get.find();
    _onlineRedemtionController=Get.put(OnlineRedemtionController());
    printingController=Get.put(PrintingController());
    createDashboardList();
  }

  createDashboardList(){
    dashboardList.add(DashboardModel(name: "Online \n Redemption",icon: "assets/online_redemtion.png", isEnable: true));
    dashboardList.add(DashboardModel(name: "Onsite \n Registration",icon: "assets/onsite registration.png",isEnable: true));
  }

  Future<void> onlineRegistration(
      dynamic body, BuildContext context) async {
    isLoading(true);
    print(body);
    RegisterResponseModel? loginResponseModel =
    await apiService.onlineRegistration(
      body: body,
    );
    isLoading(false);
    if (loginResponseModel!.status!) {
      printingController.captureImagefromWidget(
        firstName: loginResponseModel.data!.name??"",
          lastName: loginResponseModel.data!.name,
          designation: loginResponseModel.data!.designation,
          company: loginResponseModel.data!.company,
          tableNumber: loginResponseModel.data!.tableNumber);
      await UiHelper.showAnimatedAlert(
          message: loginResponseModel.message, buttonText: "OK");
      Get.back();
    } else {
      UiHelper.showSnakbarMsg(context, loginResponseModel.message.toString());
    }
    isLoading(false);
  }

  Future<void> scanUserByQR(BuildContext context, id) async {
    isLoading(true);
    ScanResultModel? inventoryDetailModel =
    await apiService.searchUser(userName: id);
    isLoading(false);
    if (inventoryDetailModel!.status!) {
   /*   if(inventoryDetailModel.data!.isNotEmpty){
        await printingController.captureImagefromWidget1(
            code: inventoryDetailModel.data![0].uniqueCode,
            name: inventoryDetailModel.data![0].name,
            qrImage: inventoryDetailModel.data![0].qrCode,
            designation: inventoryDetailModel.data![0].designation);
       UiHelper.showSnakbarSucess(context, "Thanks!");
        Get.back();
      }else{
        UiHelper.showSnakbarMsg(context, inventoryDetailModel.message.toString());
      }*/
    } else {
      UiHelper.showSnakbarMsg(context, inventoryDetailModel.message.toString());
    }
    isLoading(false);
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
      //UiHelper.showSnakbarMsg(context, inventoryDetailModel.message.toString());
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