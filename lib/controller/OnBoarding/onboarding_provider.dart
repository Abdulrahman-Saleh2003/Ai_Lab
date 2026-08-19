import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'onboarding_controller.dart';
import 'onboarding_state.dart';


final onboardingProvider =
NotifierProvider<OnboardingController, OnboardingState>(
  OnboardingController.new,
);



// final onboardingProvider =
// NotifierProvider<OnboardingController, OnboardingState>(() {
//   return OnboardingController();
// });
