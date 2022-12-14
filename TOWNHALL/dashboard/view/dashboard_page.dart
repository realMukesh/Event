//import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inventery/customerWidget/boldTextView.dart';
import 'package:inventery/customerWidget/loading.dart';
import 'package:inventery/dashboard/model/dashboard_model.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../common_controller/authentication_manager.dart';
import '../../customerWidget/input_form_field.dart';
import '../../customerWidget/rounded_button.dart';
import '../../enventory/controller/onlineRedemtionController.dart';
import '../../enventory/view/user_list_page.dart';
import '../../login/view/online-registration.dart';
import '../../qr_code/qr_code_page.dart';
import '../../theme/app_colors.dart';
import '../controller/dashboard_controller.dart';


class DashboardPage extends GetView<DashboardController> {
  DashboardPage({Key? key}) : super(key: key);
  static const routeName = "/home_screen";
  final editController=TextEditingController();
  var errorMsg="".obs;

  final AuthenticationManager _authManager = Get.find();
  final  onlineRedemtionController=Get.put(OnlineRedemtionController());


  @override
  Widget build(BuildContext context) {

    Future<bool> _onWillPop() async {
      return (await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Are you sure?'),
          content: new Text('Do you want to exit an App'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: new Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: new Text('Yes'),
            ),
          ],
        ),
      )) ?? false;
    }
    
    return WillPopScope(child: GetBuilder<DashboardController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 0,
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
          ),
          body: Container(
            padding: EdgeInsets.all(15),
            child: Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 15,),
                    Image.asset('assets/logo.png',height: 50,),
                    const SizedBox(height: 30,),
                    _buildLoadDashboard()
                  ],
                ),
                controller.isLoading.value?const Loading():const SizedBox()
              ],
            ),
          ),
        );
      },
    ), onWillPop: _onWillPop);
  }

  _buildLoadDashboard(){
    return Expanded(
      child: GridView.builder(
        shrinkWrap: false,
        itemCount: controller.dashboardList.length,
        itemBuilder: (context, index) =>
            _buildButton(index, context),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16),
      ),
    );

  }
  _buildButton(int index, BuildContext context){
    DashboardModel model=controller.dashboardList[index];
    return MaterialButton(
        animationDuration: const Duration(seconds: 1),
        color: model.isEnable?tab_selected_color:grayColorLight,
        hoverColor: button_color,
        splashColor: button_color,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: () {
          switch(index){
            case 0:
              _scanQR(context);
              break;
            case 1:
              Get.toNamed(OnineRegistrationPage.routeName);
              break;
          }
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(model.icon,height: 71,fit: BoxFit.contain,),
              const SizedBox(height: 6,),
              Text(model.name,style: const TextStyle(color: title_color,fontSize: 16,fontFamily: "Poppins"),textAlign: TextAlign.center,),
              //RegularTextView(text: model.name,color: title_color,textAlign: TextAlign.center,)
            ],
          ),
        ));
  }

  _searchUserDialog(BuildContext context)async  {
    var data=await Get.bottomSheet(
      Container(
          decoration: const BoxDecoration(
              color: bgcolor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35), topRight: Radius.circular(35))),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: (){
                          Get.back();
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: const [
                            Icon(Icons.circle,color: grayColorLight,size: 40,),
                            Icon(Icons.close),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 46,height: 5,
                        decoration: const BoxDecoration(
                            color: borderColor1,
                            borderRadius: BorderRadius.all(Radius.circular(50))
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                const BoldTextView(
                  text: 'Search by unique code, name, email',
                  textSize: 22,
                ),
                const SizedBox(
                  height: 6,
                ),
                const SizedBox(
                  height: 50,
                ),
                InputFormFieldCode(
                  controller: editController,
                  inputAction: TextInputAction.done,
                  inputType: TextInputType.emailAddress,
                  hintText: 'Enter unique code, name, email',
                  maxLength: 50,
                  validator: (String? value) {
                    if (value!.trim().isEmpty || value.trim() == null) {
                      errorMsg("Please Enter");
                      return 'Please Enter';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 6,
                ),
                Align(alignment: Alignment.centerLeft,child: Obx(()=>Text(errorMsg.value,style: const TextStyle(color: Colors.red),textAlign: TextAlign.start,)),),
                const SizedBox(
                  height: 6,
                ),
                SizedBox(
                  width: 100,
                  child: RoundedButton(
                      text: 'Send',
                      press: () async {
                        Get.back(result:editController.text);
                      }),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          )),
      barrierColor: Colors.black.withOpacity(0.80),
      isDismissible: false,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
          side: const BorderSide(width: 5, color: Colors.white)),
      enableDrag: true,
    );
    if(data!=null && data.isNotEmpty){
      var result = await controller.scanDetailResponse(context,data);
      if (result['status']) {
        Get.offNamed(UserListPage.routeName);
      }else{
        errorMsg(result['message']);
      }
    }
  }



  Future _scanQR(BuildContext context) async {
    await Permission.storage.request();
    Get.to(const QRViewPage());
  }

}
