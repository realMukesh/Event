import 'package:get_storage/get_storage.dart';

enum CacheManagerKey { TOKEN,FCMTOKEN,TEAMNAME,PASSWORD,PROFILE,NAME,IMAGE,ROLE,IS_REMEMBER,ID }

mixin CacheManager {


  Future<bool> saveToken(String? token) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.TOKEN.toString(), token);
    return true;
  }

  String? getToken() {
    final box = GetStorage();
    return box.read(CacheManagerKey.TOKEN.toString()??"");
  }

  String? getFcmToken() {
    final box = GetStorage();
    return box.read(CacheManagerKey.FCMTOKEN.toString());
  }


  Future<void> removeToken() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.TOKEN.toString());
    print("Token removed");
  }

  Future<bool> setUserProfile({required String role,
    required String userName,required String teamName,required String userId}) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.ROLE.toString(), role);
    await box.write(CacheManagerKey.TEAMNAME.toString(), teamName);
    await box.write(CacheManagerKey.NAME.toString(), userName);
    await box.write(CacheManagerKey.ID.toString(), userId);
    return true;
  }

  Future<bool> setQuestionListIds({required List<String> ids}) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.ID.toString(), ids);
    return true;
  }


  Future<bool> saveRememberMe({required String username,required String password,required bool isChecked}) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.TEAMNAME.toString(), username);
    await box.write(CacheManagerKey.PASSWORD.toString(), password);
    await box.write(CacheManagerKey.IS_REMEMBER.toString(), isChecked);
    return true;
  }

  String? getSchoolName() {
    final box = GetStorage();
    return box.read(CacheManagerKey.NAME.toString());
  }
  String? getUserId() {
    final box = GetStorage();
    return box.read(CacheManagerKey.ID.toString());
  }
  String? getTeamName() {
    final box = GetStorage();
    return box.read(CacheManagerKey.TEAMNAME.toString());
  }

  bool? isRememberLogin() {
    final box = GetStorage();
    return box.read(CacheManagerKey.IS_REMEMBER.toString());
  }

  String? getRole() {
    final box = GetStorage();
    return box.read(CacheManagerKey.ROLE.toString())??"";
  }
}