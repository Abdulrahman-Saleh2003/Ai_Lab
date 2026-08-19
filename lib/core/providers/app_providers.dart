//
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
// //   throw UnimplementedError('Must be overridden in main()');
// // });
//
// // ════════════════════════════════════════════
// //  THEME PROVIDER
// // ════════════════════════════════════════════
// class ThemeNotifier extends Notifier<ThemeMode> {
//   static const _key = 'themeMode';
//
//   @override
//   ThemeMode build() {
//     final prefs = ref.read(sharedPreferencesProvider);
//     final saved = prefs.getString(_key);
//     return saved == 'dark' ? ThemeMode.dark : ThemeMode.light;
//   }
//
//   void setDark()  => _set(ThemeMode.dark,  'dark');
//   void setLight() => _set(ThemeMode.light, 'light');
//   void toggle()   => state == ThemeMode.dark ? setLight() : setDark();
//
//   void _set(ThemeMode mode, String value) {
//     ref.read(sharedPreferencesProvider).setString(_key, value);
//     state = mode;
//   }
//
//
//
// }
//
// final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
//   ThemeNotifier.new,
// );
//
// // ════════════════════════════════════════════
// //  LOCALE PROVIDER
// // ════════════════════════════════════════════
// class LocaleNotifier extends Notifier<Locale> {
//   static const _key = 'language';
//
//   @override
//   Locale build() {
//     final prefs = ref.read(sharedPreferencesProvider);
//     final saved = prefs.getString(_key) ?? 'en';
//     return Locale(saved);
//   }
//
//   void setEnglish() => _set('en');
//
//   void setArabic() => _set('ar');
//
//   bool get isEnglish => state.languageCode == 'en';
//
//   void _set(String code) {
//     ref.read(sharedPreferencesProvider).setString(_key, code);
//     state = Locale(code);
//   }
// }
//
//
// final localeProvider = NotifierProvider<LocaleNotifier, Locale>(
//   LocaleNotifier.new,
// );
//
//
// enum AuthStatus { loading, authenticated, unauthenticated }
//
// class AuthNotifier extends Notifier<AuthStatus> {
//   static const _tokenKey = 'token';
//
//   @override
//   AuthStatus build() {
//     final prefs = ref.read(sharedPreferencesProvider);
//     final token = prefs.getString(_tokenKey);
//     return (token != null && token.isNotEmpty)
//         ? AuthStatus.authenticated
//         : AuthStatus.unauthenticated;
//   }
//
//   Future<void> saveToken(String token) async {
//     await ref.read(sharedPreferencesProvider).setString(_tokenKey, token);
//     state = AuthStatus.authenticated;
//   }
//
//   Future<void> logout() async {
//     await ref.read(sharedPreferencesProvider).remove(_tokenKey);
//     state = AuthStatus.unauthenticated;
//   }
//
//   String? get token =>
//       ref.read(sharedPreferencesProvider).getString(_tokenKey);
// }
//
// final authProvider = NotifierProvider<AuthNotifier, AuthStatus>(
//   AuthNotifier.new,
// );


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_lab/core/shared/my_cash_helper_with_getx.dart'; // ← تأكد من المسار الصحيح لـ CashHelper

// ════════════════════════════════════════════
//  THEME PROVIDER
// ════════════════════════════════════════════
class ThemeNotifier extends Notifier<ThemeMode> {
  static const _key = 'themeMode';

  @override
  ThemeMode build() {
    final saved = CashHelper.getString(key: _key);
    return saved == 'dark' ? ThemeMode.dark : ThemeMode.light;
  }

  void setDark() => _set(ThemeMode.dark, 'dark');
  void setLight() => _set(ThemeMode.light, 'light');
  void toggle() => state == ThemeMode.dark ? setLight() : setDark();

  void _set(ThemeMode mode, String value) {
    CashHelper.putString(key: _key, value: value);
    state = mode;
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  ThemeNotifier.new,
);

// ════════════════════════════════════════════
//  LOCALE PROVIDER
// ════════════════════════════════════════════
class LocaleNotifier extends Notifier<Locale> {
  static const _key = 'language';

  @override
  Locale build() {
    final saved = CashHelper.getString(key: _key) ?? 'en';
    return Locale(saved);
  }

  void setEnglish() => _set('en');
  void setArabic() => _set('ar');

  bool get isEnglish => state.languageCode == 'en';

  void _set(String code) {
    CashHelper.putString(key: _key, value: code);
    state = Locale(code);
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, Locale>(
  LocaleNotifier.new,
);

// ════════════════════════════════════════════
//  AUTH PROVIDER
// ════════════════════════════════════════════
enum AuthStatus { loading, authenticated, unauthenticated }

class AuthNotifier extends Notifier<AuthStatus> {
  static const _tokenKey = 'token';

  @override
  AuthStatus build() {
    final token = CashHelper.getString(key: _tokenKey);
    // أو: final token = CashHelper.getUserToken();

    return (token != null && token.isNotEmpty)
        ? AuthStatus.authenticated
        : AuthStatus.unauthenticated;
  }

  Future<void> saveToken(String token) async {
    await CashHelper.putString(key: _tokenKey, value: token);
    // أو: await CashHelper.putUser(userToken: token);

    state = AuthStatus.authenticated;
  }

  Future<void> logout() async {
    await CashHelper.logoutUser(); // بيمسح كل البيانات
    state = AuthStatus.unauthenticated;
  }

  String? get token => CashHelper.getString(key: _tokenKey);
// أو: CashHelper.getUserToken();
}

final authProvider = NotifierProvider<AuthNotifier, AuthStatus>(
  AuthNotifier.new,
);