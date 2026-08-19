import 'package:ai_lab/core/constant/app_theme.dart';
import 'package:ai_lab/core/services/services.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocaleController extends GetxController {
  ThemeData appTheme = appThemeEnglish;
  var appThemeMode = ThemeMode.light.obs;

  Locale? language;
  MyServices myServices = Get.find();

  void changeLanguage(String codeLanguage) {
    Locale locale = Locale(codeLanguage);
    myServices.mySharedPreferences.setString("language", codeLanguage);


    appTheme = codeLanguage == "ar" ? appThemeArabic : appThemeEnglish;
    Get.changeTheme(appTheme);
    Get.updateLocale(locale);
  }

  void changeAppThemeMode(String codeThemeMode) {
    myServices.mySharedPreferences.setString("themeMode", codeThemeMode);
    // تغيير هنا: استخدام القيمة التفاعلية
    appThemeMode.value =
    codeThemeMode == "light" ? ThemeMode.light : ThemeMode.dark;
    Get.changeThemeMode(appThemeMode.value);
    // إزالة هذا السطر: غير ضروري
    // Get.appUpdate();
  }

  @override
  void onInit() {
    String? savedTheme = myServices.mySharedPreferences.getString("themeMode");
    appThemeMode.value = (savedTheme == "dark")
        ? ThemeMode.dark
        : ThemeMode.light;

    String? mySharedLocale =
    myServices.mySharedPreferences.getString("language");
    if (mySharedLocale == "ar") {
      language = const Locale("ar");
      appTheme = appThemeArabic;
    } else if (mySharedLocale == "en") {
      language = const Locale("en");
      appTheme = appThemeEnglish;
    } else {
      appTheme = appThemeEnglish;
      myServices.mySharedPreferences.setString("language", "en");
      language = Locale(Get.deviceLocale!.languageCode);
    }

    super.onInit();
  }
}