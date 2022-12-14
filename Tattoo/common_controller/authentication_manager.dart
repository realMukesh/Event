import 'package:get/get.dart';
import '../storage/cache_manager.dart';
class AuthenticationManager extends GetxController with CacheManager {
  String _seriesNumber="";

  String get seriesNumber => _seriesNumber;

  set seriesNumber(String value) {
    _seriesNumber = value;
  }

  @override
  void onInit() {
    super.onInit();
  }

  void setSeries(String? token) async {
    //Token is cached
    await saveToken(token);
  }
  String? getSeries()  {
    final token = getToken()??"0";
    return token;
  }
}