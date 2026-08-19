
import 'package:ai_lab/OnBoarding/View/widget.dart';

class OnboardingPage4 extends StatelessWidget {
  const OnboardingPage4({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final scale = size.width / 375;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        16 * scale,
        8 * scale,
        16 * scale,
        100 * scale,
      ),
      child: Column(
        children: [
          SizedBox(height: 30 * scale),

          const BuildHolographicCenter(),

          SizedBox(height: 40 * scale),

          // 🔥 Title
          Text(
            'Welcome to',
            style: TextStyle(
              fontSize: 36 * scale,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),

          Text(
            'LabSync',
            style: TextStyle(
              fontFamily: 'SpaceGrotesk',
              fontSize: 42 * scale,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF00D2FF),
            ),
          ),

          SizedBox(height: 16 * scale),

          Text(
            'Your laboratory results, smarter and faster than ever before.\nExperience diagnostic intelligence at your fingertips.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14 * scale,
              color: Colors.grey,
              height: 1.6,
            ),
          ),

          SizedBox(height: 60 * scale),

          const BuildIntelligenceCards(),

          SizedBox(height: 40 * scale),

          const OnboardingNextButton(),

          SizedBox(height: 20 * scale),
        ],
      ),
    );
  }
}