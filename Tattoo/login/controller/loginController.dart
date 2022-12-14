import 'dart:convert';
import 'package:another_brother/label_info.dart';
import 'package:another_brother/printer_info.dart';
import 'package:csv/csv.dart';
import 'package:external_path/external_path.dart';
import 'package:firebase_chat/splash/splash_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import '../../common_controller/authentication_manager.dart';
import '../../customerWidget/boldTextView.dart';
import '../../theme/ui_helper.dart';
import '../model/user_model.dart';
import '../view/loadCsvPage.dart';
import 'database_helper.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';

class LoginController extends GetxController {
  late final AuthenticationManager _authManager;

  AuthenticationManager get authManager => _authManager;
  var isLoading = false.obs;
  Todo? todo = null;
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  String scanStatus = "No Printer Found";
  bool isSetInfo = false;
  var printer = Printer();
  String? csv;

  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void onInit() {
    super.onInit();
    _authManager = Get.find();
    DatabaseHelper.instance.initializeDatabase();
    initializePrinter();
  }

  saveTodo({name, email, context}) async {
    if (await DatabaseHelper.instance.uidExists(email)) {
      UiHelper.showSnakbarMsg(context, "Email ID is already exits");
      return;
      /* await DatabaseHelper.instance
          .updateTodo(Todo(id: todo?.id, email: name, name: email));
      UiHelper.showAnimatedAlert(buttonText: "Ok",message: "User Information have been updated!");*/
    }
    isLoading(true);
    var id = await DatabaseHelper.instance
        .insertTodo(Todo(email: email, name: name));
    captureImagefromWidget(id: id, name: name, email: email);

  }

  /*code of brother printer*/
  void initializePrinter() async {
    print("Scaning the Printers");
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
    // Get a list of printers with my model a vailable in the network.
    //List<BluetoothPrinter> printers =
    //await printer.getBluetoothPrinters([Model.PT_P910BT.getName()]);

    if (!isSetInfo) {
      scanStatus = "No Printer Found";
    } else {
      scanStatus = "Printer Found";
      //printInfo.macAddress = printers.single.macAddress;
      printer.setPrinterInfo(printInfo);
    }
  }

  captureImagefromWidget({id, name, email}) {
    Widget body = _buildToken(id);
    screenshotController.captureFromWidget(body).then((capturedImage) async {
      PrinterStatus status=await printer.printImage(await UiHelper.bytesToImage(capturedImage));
      if(status!=null){
        isLoading(false);
        UiHelper.showAnimatedAlert(
            buttonText: "Ok", message: "Token created!");
      }
      //isLoading(false);

    });

  }

  _buildToken(id) {
    int series=0;
    if(authManager.getSeries()!=null && authManager.getSeries()!.isNotEmpty){
      series=int.parse(id.toString())+int.parse(authManager.getSeries()!);
    }else{
       series=int.parse(id.toString());
    }
    print("series:$series");
    return Container(
        padding: const EdgeInsets.all(0.0),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/empty.png"), fit: BoxFit.contain)),
        child: Center(
          child: RotationTransition(
            turns: AlwaysStoppedAnimation(15 / 60),
            child: Text("Tattoo No:${series.toString()}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.black))),
        ),
        );
  }

  Future createCSVFile() async {
    print("CSV call");
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    if (statuses != PermissionStatus.granted) {
      List<Todo> todoList = await DatabaseHelper.instance.retrieveTodos();
      //return;
      print("Table:-$todoList");
      List<List<dynamic>> rows = [];

      List<dynamic> row = [];
      row.add("id");
      row.add("email");
      row.add("name");
      rows.add(row);
      for (int i = 0; i < todoList.length; i++) {
        List<dynamic> row = [];
        row.add(todoList[i].id);
        row.add(todoList[i].name);
        row.add(todoList[i].email);
        rows.add(row);
      }

      String csvData = const ListToCsvConverter().convert(rows);
      String dir = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);

      print("dir $dir");
      String file = "$dir";
      File f = File(file + "/tattoo_user.csv");
      f.writeAsString(csvData);


      /*final String directory = (await getApplicationDocumentsDirectory()).path;
      final path = "$directory/csv-${DateTime.now()}.csv";
      print(path);
      final File file = File(path);
      await file.writeAsString(csvData);
      Get.to(LoadCsvDataScreen(path: path));*/
    } else {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
    }
  }

}
