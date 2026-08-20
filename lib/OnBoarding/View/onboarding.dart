import 'package:ai_lab/OnBoarding/View/widget.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(onboardingProvider.notifier);

    ref.listen(onboardingProvider, (previous, next) {
      if (next.goToLogin || next.skipToLogin) {
        context.go('/login');
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFF111317),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: OnboardingAppBar(
          onSkip: controller.skip,
        ),
      ),
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.onPageChanged,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              OnboardingPage1(),
              OnboardingPage2(),
              OnboardingPage3(),
              OnboardingPage4(),
            ],
          ),
        ],
      ),
    );
  }
}
