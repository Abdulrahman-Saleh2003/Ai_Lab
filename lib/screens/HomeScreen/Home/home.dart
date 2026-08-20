import 'package:ai_lab/controller/home/home_provider.dart';
import 'package:ai_lab/screens/HomeScreen/Home/build_bottom_navigation_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    final homeState = ref.watch(homeProvider);
    final homeController = ref.read(homeProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFF1A1810),
      extendBody: true,
      body: homeController.pages[homeState.currentIndex],
      bottomNavigationBar: BuildBottomNavigationHomeScreen(
        currentIndex: homeState.currentIndex,
        onTabChanged: (int index) {
          homeController.changePage(index);
        },
      ),
    );
  }
}