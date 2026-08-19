//
//
// import 'package:ai_lab/core/class/crud_with_dio.dart';
// import 'package:ai_lab/core/providers/app_providers.dart';
// import 'package:ai_lab/core/router/app_router.dart';
// import 'package:ai_lab/core/services/services.dart';
// // import 'package:ai_lab/core/shared/my_cash_helper.dart';
// import 'package:ai_lab/core/shared/my_cash_helper_with_getx.dart';
// import 'package:ai_lab/core/theme/app_theme.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   GoogleFonts.config.allowRuntimeFetching = false;
//
//   await EasyLocalization.ensureInitialized();
//   await CashHelper.init();
//   await DioHelper.init();
//   await initializedServices();
//
//   final prefs = await SharedPreferences.getInstance();
//
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
//
//   runApp(
//     EasyLocalization(
//       supportedLocales: const [Locale('en'), Locale('ar')],
//       path: 'assets/translations',
//       fallbackLocale: const Locale('en'),
//       startLocale: const Locale('en'),
//       useOnlyLangCode: true,
//       child: ProviderScope(
//         overrides: [
//           sharedPreferencesProvider.overrideWithValue(prefs),
//         ],
//         child: const MyApp(),
//       ),
//     ),
//   );
// }
// class MyApp extends ConsumerWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final router = ref.watch(appRouterProvider);
//     final themeMode = ref.watch(themeProvider);
//
//     return MaterialApp.router(
//       debugShowCheckedModeBanner: false,
//       routerConfig: router,
//
//       // Theme
//       themeMode: themeMode,
//       theme: AppTheme.light(context),
//       darkTheme: AppTheme.dark(context),
//
//       // Easy Localization
//       locale: context.locale,
//       supportedLocales: context.supportedLocales,
//       localizationsDelegates: context.localizationDelegates,
//     );
//   }
// }
//
//
//
//
//
//
//
// // import 'package:ai_lab/core/class/crud_with_dio.dart';
// // import 'package:ai_lab/core/providers/app_providers.dart';
// // import 'package:ai_lab/core/router/app_router.dart';
// // import 'package:ai_lab/core/services/services.dart';
// // import 'package:ai_lab/core/shared/my_cash_helper.dart';
// // import 'package:easy_localization/easy_localization.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
//
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
//
// //   // مهم جداً
// //   await EasyLocalization.ensureInitialized();
//
// //   SystemChrome.setPreferredOrientations([
// //     DeviceOrientation.portraitUp,
// //     DeviceOrientation.portraitDown,
// //   ]);
// //   await CashHelper.init();
//
// //   await DioHelper.init();
// //     await initializedServices();
//
// //   final prefs = await SharedPreferences.getInstance();
//
// //   runApp(
// //     EasyLocalization(
// //       supportedLocales: const [Locale('en'), Locale('ar')],
// //       path: 'assets/translations',
// //       fallbackLocale: const Locale('en'),
// //       startLocale: const Locale('en'),
// //       useOnlyLangCode: true,           // اختياري لكن مفيد
// //       child: ProviderScope(
// //         overrides: [
// //           sharedPreferencesProvider.overrideWithValue(prefs),
// //         ],
// //         child: const MyApp(),
// //       ),
// //     ),
// //   );
// // }
//
// // class MyApp extends ConsumerWidget {
// //   const MyApp({super.key});
//
// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     final router = ref.watch(appRouterProvider);
// //     final themeMode = ref.watch(themeProvider);
// //     // final locale = ref.watch(localeProvider);   // ← سنستخدم context.locale بدلاً منه مؤقتاً
//
// //     return MaterialApp.router(
// //       debugShowCheckedModeBanner: false,
// //       routerConfig: router,
//
// //       // Theme
// //       themeMode: themeMode,
// //       theme: _buildLightTheme(context),
// //       darkTheme: _buildDarkTheme(context),
//
// //       // Easy Localization Settings (الصحيح)
// //       locale: context.locale,
// //       supportedLocales: context.supportedLocales,
// //       localizationsDelegates: context.localizationDelegates,
// //     );
// //   }
//
//
//
// //   ThemeData _buildDarkTheme(BuildContext context) {
// //     return ThemeData(
// //       useMaterial3: true,
// //       brightness: Brightness.dark,
// //       scaffoldBackgroundColor: const Color(0xFF111317),
// //       colorScheme: const ColorScheme.dark(
// //         primary: Color(0xFF00D2FF),
// //         secondary: Color(0xFFEDB1FF),
// //         surface: Color(0xFF111317),
// //       ),
// //       textTheme: GoogleFonts.cairoTextTheme(   // ← غير Manrope إلى Cairo مؤقتاً
// //         ThemeData.dark().textTheme,
// //       ).apply(
// //         bodyColor: Colors.white,
// //         displayColor: Colors.white,
// //       ),
// //     );
// //   }
//
// //   ThemeData _buildLightTheme(BuildContext context) {
// //     return ThemeData(
// //       useMaterial3: true,
// //       brightness: Brightness.light,
// //       colorScheme: ColorScheme.fromSeed(
// //         seedColor: const Color(0xFF00D2FF),
// //         brightness: Brightness.light,
// //       ),
// //       textTheme: GoogleFonts.cairoTextTheme(   // ← نفس الشيء هنا
// //         ThemeData.light().textTheme,
// //       ),
// //     );
// //   }
//
// //   ThemeData _buildDarkTheme1(BuildContext context) {
// //     return ThemeData(
// //       useMaterial3: true,
// //       brightness: Brightness.dark,
// //       colorScheme: const ColorScheme.dark(
// //         primary:   Color(0xFF00D2FF),
// //         secondary: Color(0xFFEDB1FF),
// //         surface:   Color(0xFF111317),
// //         error:     Color(0xFFFFB4AB),
// //       ),
// //       scaffoldBackgroundColor: const Color(0xFF111317),
// //       textTheme: GoogleFonts.manropeTextTheme(
// //         ThemeData.dark().textTheme,
// //       ),
// //     );
// //   }
//
// //   ThemeData _buildLightTheme1(BuildContext context) {
// //     return ThemeData(
// //       useMaterial3: true,
// //       brightness: Brightness.light,
// //       colorScheme: ColorScheme.fromSeed(
// //         seedColor: const Color(0xFF00D2FF),
// //         brightness: Brightness.light,
// //       ),
// //       textTheme: GoogleFonts.manropeTextTheme(
// //         ThemeData.light().textTheme,
// //       ),
// //     );
// //   }
// // }




import 'package:ai_lab/core/class/crud_with_dio.dart';
import 'package:ai_lab/core/providers/app_providers.dart';
import 'package:ai_lab/core/router/app_router.dart';
import 'package:ai_lab/core/services/services.dart';
import 'package:ai_lab/core/shared/my_cash_helper_with_getx.dart';
import 'package:ai_lab/core/theme/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GoogleFonts.config.allowRuntimeFetching = false;

  await EasyLocalization.ensureInitialized();
  await CashHelper.init();          // ← GetStorage
  await DioHelper.init();
  await initializedServices();

  // شلنا SharedPreferences بالكامل

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      useOnlyLangCode: true,
      child: const ProviderScope(   // ← شلنا الـ overrides
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,

      // Theme
      themeMode: themeMode,
      theme: AppTheme.light(context),
      darkTheme: AppTheme.dark(context),

      // Easy Localization
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
    );
  }
}