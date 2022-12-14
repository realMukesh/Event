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

  Future<PrinterStatus> captureImagefromWidget1(
      {qrImage, firstName, lastName, category, code}) {
    Widget body = _buildToken(qrImage, firstName, lastName, category, code);
    var result = screenshotController
        .captureFromWidget(body)
        .then((capturedImage) async {
      PrinterStatus status =
          await printer.printImage(await UiHelper.bytesToImage(capturedImage));
      return status;
    });
    return result;
  }

  _buildToken(qrImage, firstName, lastName, category, code) {
    return Container(
      height: 400,
      color: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              category.toString().toUpperCase(),
              style: TextStyle(
                  fontFamily: "FortTT",color: Colors.black,fontWeight: FontWeight.bold,
                  fontSize: category.toString().length > 18 ? 16 : 30),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Image.network(
              qrImage,
              height: 200,
            ),
            const SizedBox(
              height: 0,
            ),
            Text(
              code.toString(),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: code.toString().length > 18 ? 16 : 15),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              firstName.toString().toUpperCase(),
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "FortTT",fontWeight: FontWeight.bold,
                  fontSize: firstName.toString().length > 18 ? 16 : 30),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              lastName.toString().toUpperCase(),
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "FortTT",fontWeight: FontWeight.bold,
                  fontSize: firstName.toString().length > 18|| lastName.toString().length > 18 ? 16 : 30),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
