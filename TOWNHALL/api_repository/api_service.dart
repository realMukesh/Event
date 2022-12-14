import 'dart:convert';

import 'package:get/get.dart';
import '../common_controller/authentication_manager.dart';
import '../enventory/model/common_model.dart';
import '../enventory/model/scan_result_model.dart';
import '../login/model/login_response.dart';
import '../login/model/register_response.dart';
import 'app_url.dart';
import 'base_client.dart';

ApiService apiService = Get.find<ApiService>();

class ApiService extends GetxService {
  late RestClient _restClient;
  Map<String, dynamic>? headers;
  late final AuthenticationManager _authManager;
  var sectionPath = "";

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

  Future<LoginResponseModel?> login({userName}) async {
    try {
      var response = await _restClient.getData(url: "${AppUrl.login+"/$userName"}");

      print("response:${response}");
      return LoginResponseModel.fromJson(json.decode(response));
    } catch (e) {
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
      var response = await _restClient.getData(url: "${AppUrl.entryZapping+"/$code/$location"}");

      return CommonModel.fromJson(json.decode(response));
    } catch (e) {
      rethrow;
    }
  }
}
