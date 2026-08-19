import 'package:get_storage/get_storage.dart';

class CashHelperWithGetX {
  static final _storage = GetStorage();


  static void test(){
    putUser(userToken: "ABD");
    String? a;
    a=getUserToken();
    print(a);

  }
  static Future<void> init() async {
    await GetStorage.init();

    // Initialize GetStorage
  }



  static Future<void> putString({required String key, required String value}) async {
    return await _storage.write(key, value);
  }

  static String? getString({required String key}) {
    return _storage.read(key);
  }

  static Future<void> putUser({required String userToken}) async {
    return await _storage.write('token', userToken);
  }

  static Future<void> putUserFCMToken({required String userToken}) async {
    return await _storage.write('fCMToken', userToken);
  }

  static Future<void> putUserEmail({required String email}) async {
    return await _storage.write('email', email);
  }

  static Future<void> putUserLanguage({required String language}) async {
    return await _storage.write('Language', language);
  }



  static Future<void> putUserPassword({required String password}) async {
    return await _storage.write('password', password);
  }

  static Future<void> putUserName({required String name}) async {
    return await _storage.write('name', name);
  }



  static Future<void> putUserPhone({required String mobile}) async {
    return await _storage.write('mobile', mobile);
  }

  static Future<void> putUserTheme({required String theme}) async {
    return await _storage.write('theme', theme);
  }

  static String? getUserToken() {
    return _storage.read('token');
  }

  static String? getUserFCMToken() {
    return _storage.read('fCMToken');
  }



  static String? getUserLanguage() {
    return _storage.read('Language');
  }

  static String? getUserPassword() {
    return _storage.read('password');
  }

  static String? getUserName() {
    return _storage.read('name');
  }



  static String? getUserTheme() {
    return _storage.read('theme');
  }

  static String? getUserPhone() {
    return _storage.read('mobile');
  }

  static bool isAdmin() {
    return getUserPhone() == '0991996920';
  }

  static Future<void> putUserId({required int id}) async {
    return await _storage.write('id', id);
  }

  static int? getUserId() {
    return _storage.read('id');
  }

  static void logoutUser() {
    _storage.erase();
  }
}