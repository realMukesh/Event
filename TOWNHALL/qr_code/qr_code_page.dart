
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:inventery/dashboard/controller/dashboard_controller.dart';
import 'package:inventery/theme/app_colors.dart';
import 'package:get/get.dart';
import 'package:inventery/theme/ui_helper.dart';

import '../customerWidget/boldTextView.dart';
import '../customerWidget/input_form_field.dart';
import '../customerWidget/rounded_button.dart';
import '../customerWidget/toolbarTitle.dart';
import '../enventory/controller/onlineRedemtionController.dart';
import '../enventory/view/user_list_page.dart';

class QRViewPage extends StatefulWidget {
  const QRViewPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewPageState();
}

class _QRViewPageState extends State<QRViewPage> {
  final editController=TextEditingController();
  late final DashboardController dashboardController=Get.find();
  late final OnlineRedemtionController onlineRedemtionController=Get.find();
//  late final OnlineRedemtionController onlineRedemtionController;
  BuildContext? buildContext;
  var errorMsg="".obs;
  bool isFound=false;
  final GlobalKey<FormState> formKey = GlobalKey();

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();

  }

  @override
  void initState() {
  //  onlineRedemtionController=Get.put(OnlineRedemtionController());
    super.initState();
    //
  }

  @override
  Widget build(BuildContext context) {
    buildContext=context;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: black),
        title: const ToolbarTitle(title: 'Search List'),
        shape:
        const Border(bottom: BorderSide(color: grayColorLight, width: 1)),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Container(
          color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: formKey,
              child: Column(
                children: [
                 /* const BoldTextView(
                    text: 'Search by unique code, name, email',
                    textSize: 16,
                  ),*/
                  const SizedBox(
                    height: 6,
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
                //  Align(alignment: Alignment.centerLeft,child: Obx(()=>Text(errorMsg.value,style: const TextStyle(color: Colors.red),textAlign: TextAlign.start,)),),
                  const SizedBox(
                    height: 6,
                  ),
                  SizedBox(
                    width: 100,
                    child: RoundedButton(
                        text: 'Search',
                        press: () async {
                          if(formKey.currentState!.validate()){
                            var result = await dashboardController.scanDetailResponse(context,editController.text.toString().trim());
                            if (result['status']) {
                              Get.toNamed(UserListPage.routeName);
                            }else{
                              UiHelper.showSnakbarMsg(context, result['message']);
                            }
                          }


                        }),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            )),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

