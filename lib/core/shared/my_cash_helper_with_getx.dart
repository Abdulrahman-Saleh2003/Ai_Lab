import 'package:get_storage/get_storage.dart';

class CashHelper {
  static final GetStorage _box = GetStorage();

  static Future<void> init() async {
    await GetStorage.init();
  }

  static Future<void> putString({
    required String key,
    required String value,
  }) async {
    await _box.write(key, value);
  }

  static String? getString({
    required String key,
  }) {
    return _box.read<String>(key);
  }

  static Future<void> saveRememberPreference({
    required String rememberMe,
  }) async {
    await _box.write('rememberMe', rememberMe);
  }

  static String? getRemember() {
    return _box.read<String>('rememberMe');
  }

  static Future<void> putUser({
    required String userToken,
  }) async {
    await _box.write('token', userToken);
  }

  static Future<void> putUserFCMToken({
    required String userToken,
  }) async {
    await _box.write('fCMToken', userToken);
  }

  static Future<void> putUserEmail({
    required String email,
  }) async {
    await _box.write('email', email);
  }

  static Future<void> putUserLanguage({
    required String language,
  }) async {
    await _box.write('Language', language);
  }

  static Future<void> putUserImage({
    required String image,
  }) async {
    await _box.write('Image', image);
  }

  static Future<void> putUserPassword({
    required String password,
  }) async {
    await _box.write('password', password);
  }

  static Future<void> putUserName({
    required String name,
  }) async {
    await _box.write('name', name);
  }

  static Future<void> putUserAge({
    required String age,
  }) async {
    await _box.write('age', age);
  }

  static Future<void> putUserPhone({
    required String mobile,
  }) async {
    await _box.write('mobile', mobile);
  }

  static Future<void> putUserTheme({
    required String theme,
  }) async {
    await _box.write('theme', theme);
  }

  static String? getUserToken() {
    return _box.read<String>('token');
  }

  static String? getUserFCMToken() {
    return _box.read<String>('fCMToken');
  }

  static String? getUserImage() {
    return _box.read<String>('Image');
  }

  static String? getUserLanguage() {
    return _box.read<String>('Language');
  }

  static String? getUserPassword() {
    return _box.read<String>('password');
  }

  static String? getUserName() {
    return _box.read<String>('name');
  }

  static String? getUserAge() {
    return _box.read<String>('age');
  }

  static String? getUserTheme() {
    return _box.read<String>('theme');
  }

  static String? getUserPhone() {
    return _box.read<String>('mobile');
  }

  static String? getUserEmail() {
    return _box.read<String>('email');
  }

  static bool isAdmin() {
    return getUserPhone() == '0991996920';
  }

  static Future<void> putUserId({
    required int id,
  }) async {
    await _box.write('id', id);
  }

  static int? getUserId() {
    return _box.read<int>('id');
  }

  static Future<void> logoutUser() async {
    await _box.erase();
  }
}