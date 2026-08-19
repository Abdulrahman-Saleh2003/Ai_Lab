
import 'package:ai_lab/OnBoarding/View/widget.dart';
class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingProvider);
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







// Positioned(
//   bottom: 30,
//   left: 16,
//   right: 16,
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       if (state.currentPage > 0)
//         TextButton.icon(
//           onPressed: controller.previousPage,
//           icon: const Icon(Icons.arrow_back, color: Colors.grey),
//           label: const Text('BACK',
//               style: TextStyle(color: Colors.grey)),
//         )
//       else
//         const SizedBox(width: 80),
//
//       GestureDetector(
//         onTap: controller.nextPage,
//         child: Container(
//           padding: const EdgeInsets.symmetric(
//               horizontal: 32, vertical: 16),
//           decoration: BoxDecoration(
//             gradient: const LinearGradient(
//               colors: [Color(0xFF00D2FF), Color(0xFF9D50BB)],
//             ),
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 state.currentPage == 3
//                     ? 'GET STARTED'
//                     : 'NEXT',
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(width: 10),
//               const Icon(Icons.arrow_forward,
//                   color: Colors.white),
//             ],
//           ),
//         ),
//       ),
//     ],
//   ),
// ),
