/*
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_usb_printer/flutter_usb_printer.dart';

class PrintingPage extends StatefulWidget {
  PrintingPage({Key? key}) : super(key: key);



  @override
  State<PrintingPage> createState() => _PrintingPageState();
}

class _PrintingPageState extends State<PrintingPage> {


  List<Map<String, dynamic>> devices = [];
  FlutterUsbPrinter flutterUsbPrinter = FlutterUsbPrinter();
  bool connected = false;

  @override
  initState() {
    super.initState();
    _getDevicelist();
  }

  _getDevicelist() async {
    List<Map<String, dynamic>> results = [];
    results = await FlutterUsbPrinter.getUSBDeviceList();

    print(" length: ${results.length}");
    setState(() {
      devices = results;
    });
  }

  _connect(int vendorId, int productId) async {
    bool? returned = false;
    try {
      returned = await flutterUsbPrinter.connect(vendorId, productId);
    } on PlatformException {
      //response = 'Failed to get platform version.';
    }
    if (returned!) {
      setState(() {
        connected = true;
      });
    }
  }

  _print() async {
    try {
      var data = Uint8List.fromList(
          utf8.encode(" Hello world Testing ESC POS printer..."));
      await flutterUsbPrinter.write(data);
      // await FlutterUsbPrinter.printRawData("text");
      // await FlutterUsbPrinter.printText("Testing ESC POS printer...");
    } on PlatformException {
      //response = 'Failed to get platform version.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('USB PRINTER'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () => _getDevicelist()),
            connected == true
                ? IconButton(
                icon: Icon(Icons.print),
                onPressed: () {
                  _print();
                })
                : Container(),
          ],
        ),
        body: devices.length > 0
            ? ListView(
          scrollDirection: Axis.vertical,
          children: _buildList(devices),
        )
            : null,
      ),
    );
  }

  List<Widget> _buildList(List<Map<String, dynamic>> devices) {
    return devices
        .map((device) => ListTile(
      onTap: () {
        _connect(int.parse(device['vendorId']),
            int.parse(device['productId']));
      },
      leading: const Icon(Icons.usb),
      title: Text(
          device['manufacturer'] + " " + device['productName']),
      subtitle:
      Text(device['vendorId'] + " " + device['productId']),
    ))
        .toList();
  }
}
*/
