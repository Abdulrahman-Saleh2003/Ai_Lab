import 'package:get_storage/get_storage.dart';

class CacheHelper {
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

  static Future<void> putBool({
    required String key,
    required bool value,
  }) async {
    await _box.write(key, value);
  }

  static bool? getBool({
    required String key,
  }) {
    return _box.read<bool>(key);
  }

  static Future<void> removeData({
    required String key,
  }) async {
    await _box.remove(key);
  }

  static Future<void> clearAll() async {
    await _box.erase();
  }

  // ─── دوال المستخدم المباشرة ───
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
    required String fCMToken,
  }) async {
    await _box.write('fCMToken', fCMToken);
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

  static Future<void> putUserId({
    required String id,
  }) async {
    await _box.write('id', id);
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

  static Future<void> putUserGender({
    required String gender,
  }) async {
    await _box.write('gender', gender);
  }

  static Future<void> putUserPhone({
    required String phone,
  }) async {
    await _box.write('phone', phone);
  }

  static String? getUserToken() => _box.read<String>('token');
  static String? getUserFCMToken() => _box.read<String>('fCMToken');
  static String? getUserEmail() => _box.read<String>('email');
  static String? getUserImage() => _box.read<String>('Image');
  static String? getUserId() => _box.read<String>('id');
  static String? getUserName() => _box.read<String>('name');
  static String? getUserAge() => _box.read<String>('age');
  static String? getUserGender() => _box.read<String>('gender');
  static String? getUserPhone() => _box.read<String>('phone');
  static String? getUserLanguage() => _box.read<String>('Language');

  // ─── التخزين المؤقت للتقارير والتحاليل دون اتصال (Offline Caching) ───
  static const _cachedReportsKey = 'cached_lab_reports';
  static const _cachedAnalysisPrefix = 'cached_analysis_';

  static Future<void> cacheReports(List<Map<String, dynamic>> reports) async {
    await _box.write(_cachedReportsKey, reports);
  }

  static List<Map<String, dynamic>>? getCachedReports() {
    final raw = _box.read(_cachedReportsKey);
    if (raw is List) {
      return raw
          .whereType<Map>()
          .map((m) => Map<String, dynamic>.from(m))
          .toList();
    }
    return null;
  }

  static Future<void> cacheReportAnalysis(
      String reportId, Map<String, dynamic> analysis) async {
    await _box.write('$_cachedAnalysisPrefix$reportId', analysis);
  }

  static Map<String, dynamic>? getCachedReportAnalysis(String reportId) {
    final raw = _box.read('$_cachedAnalysisPrefix$reportId');
    if (raw is Map) {
      return Map<String, dynamic>.from(raw);
    }
    return null;
  }

  static Future<void> clearCachedReports() async {
    await _box.remove(_cachedReportsKey);
  }

  static Future<void> logoutUser() async {
    await _box.remove('token');
    await _box.remove('email');
    await _box.remove('id');
    await _box.remove('name');
    await _box.remove('age');
    await _box.remove('gender');
    await _box.remove('phone');
    await _box.remove('Image');
    await _box.remove(_cachedReportsKey);
  }
}

typedef CashHelper = CacheHelper;
