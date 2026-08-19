import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'onboarding_state.dart';
import 'dart:async';

class OnboardingController extends Notifier<OnboardingState> {

  late final PageController pageController;
  Timer? _timer;
  @override
  OnboardingState build() {
    pageController = PageController();

    // startAutoSlide();

    ref.onDispose(() {
      _timer?.cancel();
      pageController.dispose();
    });



    return const OnboardingState();
  }

  void onPageChanged(int index) {
    state = state.copyWith(currentPage: index);
  }

  void nextPage() {
    if (state.currentPage < 3) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        // milliseconds: 400
        curve: Curves.easeInOut,
      );
    } else {

      state = state.copyWith(goToLogin: true);


    }
  }

  void onScroll(ScrollController controller) {
    if (!controller.hasClients) return;

    final isEnd = controller.position.pixels >=
        controller.position.maxScrollExtent - 100;

    if (isEnd != state.showButton) {
      state = state.copyWith(showButton: isEnd);
    }
  }


  void startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (state.currentPage < 3) {
        pageController.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      } else {
        timer.cancel();

        state = state.copyWith(goToLogin: true);
      }
    });
  }


  void skip() {
    _timer?.cancel();
    state = state.copyWith(skipToLogin: true);
  }
  void previousPage() {
    if (state.currentPage > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }
}

