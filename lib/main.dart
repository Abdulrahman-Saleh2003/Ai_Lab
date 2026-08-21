import 'package:ai_lab/core/class/crud_with_dio.dart';
import 'package:ai_lab/core/providers/app_providers.dart';
import 'package:ai_lab/core/router/app_router.dart';
import 'package:ai_lab/core/services/fcm_service.dart';
import 'package:ai_lab/core/services/services.dart';
import 'package:ai_lab/core/shared/cache_helper.dart';
import 'package:ai_lab/core/theme/app_theme.dart';
import 'package:ai_lab/firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  await initializedServices();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FCMService.initialize();
  } catch (e) {
    debugPrint("Firebase initialization error: $e");
  }

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
      child: const ProviderScope(
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