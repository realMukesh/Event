import 'package:another_brother/label_info.dart';
import 'package:another_brother/printer_info.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import '../../common_controller/authentication_manager.dart';
import '../../customerWidget/boldTextView.dart';
import '../../theme/ui_helper.dart';
import 'package:flutter/material.dart';

class PrintingController extends GetxController {
  late final AuthenticationManager _authManager;

  AuthenticationManager get authManager => _authManager;
  var isLoading = false.obs;
  String scanStatus = "No Printer Found";
  bool isSetInfo = false;
  var printer = Printer();

  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void onInit() {
    super.onInit();
    _authManager = Get.find();
    initializePrinter();
  }
  //code of brother printer
  void initializePrinter() async {
    var printInfo = PrinterInfo();
    printInfo.printerModel = Model.QL_720NW;
    printInfo.printMode = PrintMode.FIT_TO_PAGE;
    printInfo.isAutoCut = true;
    printInfo.port = Port.USB;
    //printInfo.orientation = Orientation.;
    printInfo.rotate180 = false;
    // Set the label type.
    printInfo.labelNameIndex = QL700.ordinalFromID(QL700.W62.getId());
    // Set the printer info so we can use the SDK to get the printers.
    isSetInfo = await printer.setPrinterInfo(printInfo);

    if (!isSetInfo) {
      scanStatus = "No Printer Found";
    } else {
      scanStatus = "Printer Found";
      //printInfo.macAddress = printers.single.macAddress;
      printer.setPrinterInfo(printInfo);
    }
  }

  /*captureImagefromWidget({qrImage, name, designation,code}) {
    Widget body = _buildToken(qrImage, name, designation,code);
    screenshotController.captureFromWidget(body).then((capturedImage) async {
      PrinterStatus status=await printer.printImage(await UiHelper.bytesToImage(capturedImage));
      if(status!=null){
        isLoading(false);
        UiHelper.showAnimatedAlert(
            buttonText: "Ok", message: "Token created!");
      }
      //isLoading(false);

    });

  }*/

  Future<PrinterStatus> captureImagefromWidget({firstName,lastName, designation, company,tableNumber}) {
    Widget body = _buildToken(firstName,lastName, designation, company,tableNumber);
    var result =screenshotController.captureFromWidget(body).then((capturedImage) async {
      PrinterStatus status=await printer.printImage(await UiHelper.bytesToImage(capturedImage));
      return status;
    });
    return result;

  }

  _buildToken(firstName,lastName, designation, company,tableNumber) {
    print("tableNumber:---------------$tableNumber");
    List<String> patternList = <String>[];
    patternList = firstName.split(" ");

    print(patternList);
    if(patternList.length==1){
    firstName=patternList[0];
    lastName="";
    }
    else if(patternList.length>2){
      firstName=patternList[0]+" "+patternList[1];
      lastName=patternList[2];
    }
    else if(patternList.length>1){
      firstName=patternList[0];
      lastName=patternList[1];
    }



    print(firstName);
    print(lastName);

    return Container(
      height: 700,
      color: Colors.white,
      padding: const EdgeInsets.only(right: 25),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60,),
            Text(
              firstName.toString().toUpperCase(),
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Roboto-Black",fontWeight: FontWeight.bold,
                  fontSize: firstName.toString().length > 18 ? 30 : 80),
              textAlign: TextAlign.center,
            ),
            lastName.toString().isNotEmpty?Text(
              lastName.toString().toUpperCase(),
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Roboto-Bold",fontWeight: FontWeight.bold,
                  fontSize: firstName.toString().length > 18 || firstName.toString().length > 18 ? 30 : 80),
              textAlign: TextAlign.center,
            ):const SizedBox(),
            const SizedBox(height: 30,),
            Text(
              designation.toString().toUpperCase(),
              style: TextStyle(
                  fontFamily: "Roboto-Bold",color: Colors.black,fontWeight: FontWeight.bold,
                  fontSize: designation.toString().length > 18 ? 45 : 70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              company.toString().toUpperCase(),
              style: TextStyle(
                  fontFamily: "Roboto-Medium",color: Colors.black,fontWeight: FontWeight.w400,
                  fontSize: company.toString().length > 18 ? 55 : 62),
              textAlign: TextAlign.center,softWrap: true,
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  tableNumber!=null?"TABLE  ":"",
                  style: TextStyle(
                      color: Colors.black,fontFamily: "Roboto-Bold",fontWeight: FontWeight.w600,
                      fontSize: tableNumber.toString().length > 18 ? 32 : 60),
                  textAlign: TextAlign.center,
                ),
                Text(
                  tableNumber!=null?tableNumber.toString().toUpperCase():"",
                  style: TextStyle(
                      color: Colors.black,fontFamily: "Roboto-Bold",fontWeight: FontWeight.bold,
                      fontSize: tableNumber.toString().length > 18 ? 37 : 60),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    ) ;
  }



}
