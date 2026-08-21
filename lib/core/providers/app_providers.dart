import 'package:ai_lab/core/class/crud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_lab/core/shared/cache_helper.dart';

final crudProvider = Provider<Crud>((ref) {
  return Crud();
});

// ════════════════════════════════════════════
//  THEME PROVIDER
// ════════════════════════════════════════════
class ThemeNotifier extends Notifier<ThemeMode> {
  static const _key = 'themeMode';

  @override
  ThemeMode build() {
    final saved = CacheHelper.getString(key: _key);
    return saved == 'dark' ? ThemeMode.dark : ThemeMode.light;
  }

  void setDark() => _set(ThemeMode.dark, 'dark');
  void setLight() => _set(ThemeMode.light, 'light');
  void toggle() => state == ThemeMode.dark ? setLight() : setDark();

  void _set(ThemeMode mode, String value) {
    CacheHelper.putString(key: _key, value: value);
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
    final saved = CacheHelper.getString(key: _key) ?? 'en';
    return Locale(saved);
  }

  void setEnglish() => _set('en');
  void setArabic() => _set('ar');

  bool get isEnglish => state.languageCode == 'en';

  void _set(String code) {
    CacheHelper.putString(key: _key, value: code);
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
    final token = CacheHelper.getString(key: _tokenKey);
    return (token != null && token.isNotEmpty)
        ? AuthStatus.authenticated
        : AuthStatus.unauthenticated;
  }

  Future<void> saveToken(String token) async {
    await CacheHelper.putString(key: _tokenKey, value: token);
    state = AuthStatus.authenticated;
  }

  Future<void> logout() async {
    await CacheHelper.logoutUser();
    state = AuthStatus.unauthenticated;
  }

  String? get token => CacheHelper.getString(key: _tokenKey);
}

final authProvider = NotifierProvider<AuthNotifier, AuthStatus>(
  AuthNotifier.new,
);