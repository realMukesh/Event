import 'package:get_storage/get_storage.dart';

enum CacheManagerKey { TOKEN,LOCATION,USERNAME,PASSWORD,PROFILE,NAME,IMAGE,WALLET,IS_REMEMBER,EMAIL,MOBILE }

mixin CacheManager {
  Future<bool> saveToken(String? token) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.TOKEN.toString(), token);
    return true;
  }

  String? getToken() {
    final box = GetStorage();
    return box.read(CacheManagerKey.TOKEN.toString());
  }


  Future<bool> setLocation(String? location) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.LOCATION.toString(), location);
    return true;
  }

  String? getLocation() {
    final box = GetStorage();
    return box.read(CacheManagerKey.LOCATION.toString());
  }


  Future<void> removeToken() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.TOKEN.toString());
    print("Token removed");
  }


  Future<bool> setProfileData({required String username,required String email,required String profile,required String mobile}) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.USERNAME.toString(), username);
    await box.write(CacheManagerKey.EMAIL.toString(), email);
    await box.write(CacheManagerKey.MOBILE.toString(), mobile);
    await box.write(CacheManagerKey.PROFILE.toString(), profile);
    return true;
  }

  Future<bool> saveRememberMe({required String username,required String password,required bool isChecked}) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.USERNAME.toString(), username);
    await box.write(CacheManagerKey.PASSWORD.toString(), password);
    await box.write(CacheManagerKey.IS_REMEMBER.toString(), isChecked);
    return true;
  }

  String? getUsername() {
    final box = GetStorage();
    return box.read(CacheManagerKey.USERNAME.toString());
  }

  String? getEmail() {
    final box = GetStorage();
    return box.read(CacheManagerKey.EMAIL.toString());
  }
  String? getProfileImage() {
    final box = GetStorage();
    return box.read(CacheManagerKey.PROFILE.toString());
  }
  String? getMobile() {
    final box = GetStorage();
    return box.read(CacheManagerKey.MOBILE.toString());
  }

  bool? isRememberLogin() {
    final box = GetStorage();
    return box.read(CacheManagerKey.IS_REMEMBER.toString());
  }

  String? getName() {
    final box = GetStorage();
    return box.read(CacheManagerKey.NAME.toString())??"";
  }
  String? getImage() {
    final box = GetStorage();
    return box.read(CacheManagerKey.IMAGE.toString())??"";
  }
  String? getBallance() {
    final box = GetStorage();
    return box.read(CacheManagerKey.WALLET.toString())??"";
  }
}