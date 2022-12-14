import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:inventery/dashboard/controller/dashboard_controller.dart';
import 'package:inventery/theme/app_colors.dart';
import 'package:inventery/zappingDashboard/controller/zapping_controller.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:get/get.dart';

import '../common_controller/authentication_manager.dart';
import '../customerWidget/boldTextView.dart';
import '../customerWidget/input_form_field.dart';
import '../customerWidget/regularTextView.dart';
import '../customerWidget/rounded_button.dart';
import '../zappingDashboard/view/confim_dialog_page.dart';
import '../zappingDashboard/view/zapping_user_list_page.dart';



class ZappingQRPage extends StatefulWidget {
  const ZappingQRPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ZappingQRPageState();
}

class _ZappingQRPageState extends State<ZappingQRPage> {
  final AuthenticationManager _authManager = Get.find();
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final editController=TextEditingController();
  late final ZappingController _zappingController=Get.find();
  BuildContext? buildContext;
  var errorMsg="".obs;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    /*if (Platform.isAndroid) {
      controller!.resumeCamera();
    }*/
    controller!.resumeCamera();
  }

  @override
  void initState() {
    super.initState();
    //
  }

  @override
  Widget build(BuildContext context) {
    buildContext=context;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Stack(
          children: <Widget>[
            _buildQrView(context),
            Positioned(
                top: 50,
                right: 20,
                left: 20,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            InkWell(
                                onTap: (){
                                  Get.back();
                                },
                                child: const ImageIcon(AssetImage("assets/icons/cross.png"),color: Colors.white,size: 30,)),
                            const SizedBox(width: 6,),
                            const RegularTextView(text: "QR Scan",color: white,)

                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(8),
                              child: InkWell(
                                  onTap: () async {
                                    await controller?.toggleFlash();
                                    setState(() {});
                                  },
                                  child: FutureBuilder(
                                    future: controller?.getFlashStatus(),
                                    builder: (context, snapshot) {
                                      //return Text('Flash: ${snapshot.data}');
                                      return  ImageIcon(const AssetImage("assets/icons/flash.png"),color: snapshot.data==true?Colors.white:grayColorLight,size: 30,);
                                    },
                                  )),
                            ),
                            InkWell(
                              onTap: (){
                                _EnterQueryDialog(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                                decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                                    border: Border.all(color: Colors.white,width: 1)
                                ),
                                child: const RegularTextView(text: "Search Manually",color: button_color,textSize: 12,),
                              ),
                            )
                          ],
                        )

                      ],
                    ),
                    const SizedBox(height: 100,),
                    //const Text("Scan QR",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold)),
                    //const Text("Scan the QR code for \n Event Devices",style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
                    const SizedBox(height: 10,),
                   ],
                )),

          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: const Color(0xfff1877F2),
          borderRadius: 0,
          borderLength: 30,
          borderWidth: 20,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    if (Platform.isAndroid) {
      controller!.resumeCamera();
    }
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) async {
      if (scanData.code != null && scanData.code!.isNotEmpty) {
        controller!.pauseCamera();
        callApi(scanResult: scanData.code);
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  _EnterQueryDialog(BuildContext context)async  {
    errorMsg("");
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
                  text: 'Search by unique code',
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
                  hintText: 'Enter unique code',
                  maxLength: 50,
                  validator: (String? value) {
                    if (value!.trim().isEmpty || value.trim() == null) {
                      errorMsg("Please Enter code");
                      return 'Please Enter code';
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
      callApi(scanResult: data);
    }
  }

  Future callApi({scanResult}) async {
    List<String> patternList = <String>[];
    patternList = scanResult.split(",");

    print(patternList[0].replaceAll('"', '\\"'));
    String code=patternList[0].replaceAll("[", "");
    String codepattern=code.replaceAll('"', "");
    print("code--------------$codepattern");

    if (scanResult.isNotEmpty) {
      var result=await _zappingController.entryZapping(context, code: codepattern,location: _authManager.getLocation());
      print(result['status']);
      if(result['status']){
        await Get.to(ConfirmDialogPage(isSuccess: true,message: result['message']));
        controller!.resumeCamera();
      }else{
        await Get.to(ConfirmDialogPage(isSuccess: false,message: result['message']));
        controller!.resumeCamera();
      }
      _zappingController.userFound=true;
    }
  }



  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

