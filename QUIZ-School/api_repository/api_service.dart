import 'package:get/get.dart';
import '../common_controller/authentication_manager.dart';
import '../login/model/login_response.dart';
import '../quiz_master/model/question_list_model.dart';
import 'app_url.dart';
import 'base_client.dart';

ApiService apiService = Get.find<ApiService>();

class ApiService extends GetxService {
  late RestClient _restClient;
  Map<String, dynamic>? headers;
  late final AuthenticationManager _authManager;

  Future<ApiService> init() async {
    _authManager = Get.find();
    if(_authManager.getToken()!=null){
      headers = {
        "Accept": "application/json",
        "Authorization":"Bearer "+_authManager.getToken()!,
      };
    }else{
      headers = {
        "Accept": "application/json",
      };
    }
    _restClient = RestClient();
    _restClient.init();
    return this;
  }

  Map<String, dynamic> getHeaders()  {
    if(_authManager.getToken()!=null){
      headers = {
        "Accept": "application/json",
        "Authorization":"Bearer "+_authManager.getToken()!,
      };
    }else{
      headers = {
        "Accept": "application/json",
      };
    }
    return headers!;
  }


  Future<LoginResponseModel?> login(Map<String, dynamic> map) async {
    print(map);
    try {
      var response = await _restClient.postData(
          url: AppUrl.login, headers: headers, payload: map);
      return LoginResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<QuestionListModel?> getQuestionList() async {
    try {
      var response = await _restClient.getData(
          url: AppUrl.getQuestionList, headers: getHeaders());

      return QuestionListModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

}


