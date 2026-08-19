

import 'package:ai_lab/core/providers/app_providers.dart';
import 'package:ai_lab/OnBoarding/View/onboarding.dart';
import 'package:ai_lab/screens/Authentication/LogIn/login_screen.dart';
import 'package:ai_lab/screens/Authentication/SignUp/registration_screen.dart';
import 'package:ai_lab/screens/HomeScreen/Home/home_screen.dart';
import 'package:ai_lab/screens/HomeScreen/Home/home.dart';
import 'package:ai_lab/screens/HomeScreen/chat/chat_screen.dart';
import 'package:ai_lab/screens/HomeScreen/profile/profile.dart';
import 'package:ai_lab/screens/HomeScreen/report/report_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authStatus = ref.watch(authProvider);

  return GoRouter(
    // ✅ البداية من onboarding مباشرة — ما في splash
    initialLocation: '/onboarding',

    redirect: (context, state) {
      final isAuth    = authStatus == AuthStatus.authenticated;
      final isLoading = authStatus == AuthStatus.loading;

      // لسه بيحمل — لا تحول
      if (isLoading) return null;

      final publicRoutes = ['/login', '/register', '/onboarding'];

      // مش مسجل دخول وراح لصفحة محمية → Login
      if (!isAuth && !publicRoutes.contains(state.matchedLocation)) {
        return '/login';
      }

      // مسجل دخول وراح لـ onboarding أو login → Home مباشرة
      if (isAuth && publicRoutes.contains(state.matchedLocation)) {
        return '/home';
      }

      return null;
    },

    routes: [
      // ── Onboarding ──
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),

      // ── Auth ──
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const PatientRegistrationScreen(),
      ),

      // ── Home ──
      GoRoute(
        path: '/home',
        builder: (context, state) => const Home(),
        routes: [
          GoRoute(
            path: 'details',
            builder: (context, state) => const HomeScreen(),
          ),
        ],
      ),

      // ── Reports ──
      GoRoute(
        path: '/cbc-report',
        builder: (context, state) => const CBCReportScreen(),
      ),

      // ── Profile ──
      GoRoute(
        path: '/profile',
        builder: (context, state) => const PatientProfilePage(),
      ),

       GoRoute(
        path: '/ChatScreen',
        builder: (context, state) => const ChatScreen(),
      ),
    ],
  );
});