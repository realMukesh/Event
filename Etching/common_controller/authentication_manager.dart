import 'package:get/get.dart';
import '../storage/cache_manager.dart';
class AuthenticationManager extends GetxController with CacheManager {
  @override
  void onInit() {
    super.onInit();
  }
  void setSeries(String? token) async {
    //Token is cached
    await saveToken(token);
  }
  String? getSeries()  {
    final token = getToken();
    return token;
  }
}