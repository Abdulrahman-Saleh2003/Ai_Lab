import 'package:ai_lab/OnBoarding/View/widget.dart';


class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 120), // زيادة padding من الأسفل
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          onboardingText(label: 'Sample and Results',
              style: TextStyle(fontFamily: 'SpaceGrotesk', fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white)
          ),

          const SizedBox(height: 8),
          onboardingText(
maxLines: 3,

            label:
            'Track your samples in real-time and get instant updates on your test results.',
            style: TextStyle(

              fontSize: 16,
              color: Colors.grey[400],
              height: 1.5,
            ),

          ),
          const SizedBox(height: 32),

          // Bento Grid
          GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.94,

            ),
            children: [
               BuildLiveFeedCard(),
               BuildQueueCard(),
            ],
          ),

          const SizedBox(height: 12),

           BuildTotalSamplesCard(),

          const SizedBox(height: 24),

           BuildVitalityMetrics(),

          const SizedBox(height: 24),

           BuildSampleJourney(),



          const SizedBox(height: 40),

          const OnboardingNextButton(),

          const SizedBox(height: 20),

        ],
      ),
    );
  }

}



