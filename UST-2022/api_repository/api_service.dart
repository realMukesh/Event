import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:inventery/theme/ui_helper.dart';
import '../common_controller/authentication_manager.dart';
import '../enventory/model/common_model.dart';
import '../enventory/model/scan_result_model.dart';
import '../login/model/login_response.dart';
import '../login/model/register_response.dart';
import 'app_url.dart';
import 'base_client.dart';
import 'package:http/http.dart' as http;

ApiService apiService = Get.find<ApiService>();

class ApiService extends GetxService {
  late RestClient _restClient;
  Map<String, dynamic>? headers;
  late final AuthenticationManager _authManager;
  var sectionPath = "";
  var client = http.Client();

  Future<ApiService> init() async {
    _authManager = Get.find();
    if (_authManager.getToken() != null) {
      headers = {
        "Accept": "application/json",
        "Authorization": "Bearer " + _authManager.getToken()!,
      };
    } else {
      headers = {
        "Accept": "application/json",
      };
    }
    _restClient = RestClient();
    _restClient.init();
    return this;
  }

  Map<String, dynamic> getHeaders() {
    if (_authManager.getToken() != null) {
      headers = {
        "Accept": "application/json",
        "Authorization": "Bearer " + _authManager.getToken()!,
      };
    } else {
      headers = {
        "Accept": "application/json",
      };
    }
    return headers!;
  }



  Future<LoginResponseModel?> login({userName,context}) async {
   /* try {
      //var url = Uri.https("${AppUrl.login+"/$userName"}");
      var response = await http.get(Uri.parse("${AppUrl.login+"/$userName"}"));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return LoginResponseModel.fromJson(json.decode(response.body));
    } catch (e) {
      UiHelper.showSnakbarMsg(context, "Exception:${e}");
      print("Exception:${e}");
      rethrow;
    }*/

    try {
      var response = await _restClient.getData(url: "${AppUrl.login+"/$userName"}");
      print("response:${response}");
      return LoginResponseModel.fromJson(json.decode(response));
    } catch (e) {
      UiHelper.showSnakbarMsg(context, "Exception:${e}");
      print("Exception:${e}");
      rethrow;
    }
  }

  Future<RegisterResponseModel?> onlineRegistration({body}) async {

    try {
      var response = await _restClient.postData(url: "${AppUrl.save_onsite_user}",payload: body);
      print("response:${response}");
      return RegisterResponseModel.fromJson(json.decode(response));
    } catch (e) {
      rethrow;
    }
  }

  Future<ScanResultModel?> searchUser({userName}) async {
    try {
      var response = await _restClient.getData(url: "${AppUrl.search_user+"/$userName"}");

      return ScanResultModel.fromJson(json.decode(response));
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonModel?> updateUserStatus({status}) async {

    try {
      var response = await _restClient.getData(url: AppUrl.update_status+"/"+status);

      return CommonModel.fromJson(json.decode(response));
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonModel?> entryZapping({code, location}) async {
    try {
      print("${AppUrl.entryZapping+"/$code/$location"}");
      var response = await _restClient.getData(url: "${AppUrl.entryZapping+"/$code/$location"}");

      return CommonModel.fromJson(json.decode(response));
    } catch (e) {
      rethrow;
    }
  }
}
