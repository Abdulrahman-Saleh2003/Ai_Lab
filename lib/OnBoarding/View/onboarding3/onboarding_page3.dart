
import 'package:ai_lab/OnBoarding/View/widget.dart';
import 'package:ai_lab/core/constant/app_color.dart';

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = AppSize.scale(context);

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        16 * scale,
        8 * scale,
        16 * scale,
        100 * scale,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔥 Hero Section
          Text(
            'AI-Powered',
            style: TextStyle(
              fontFamily: 'SpaceGrotesk',
              fontSize: 42 * scale,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          Text(
            'Analysis',
            style: TextStyle(
              fontFamily: 'SpaceGrotesk',
              fontSize: 42 * scale,
              fontWeight: FontWeight.bold,
              color: AppMyColor.blueColor,
            ),
          ),

          SizedBox(height: 12 * scale),

          Text(
            'Our advanced AI analyzes your lab data to provide deep insights and trend alerts with clinical precision.',
            style: TextStyle(
              fontSize: 16 * scale,
              color: AppMyColor.greyApp,
              height: 1.5,
            ),
          ),

          SizedBox(height: 32 * scale),

          const BuildAiBrainVisualization(),


          SizedBox(height: 40 * scale),

          const BuildFeaturesSection(),



          SizedBox(height: 40 * scale),

          Text(
            'Analysis Stream',
            style: TextStyle(
              fontFamily: 'SpaceGrotesk',
              fontSize: 24 * scale,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 16 * scale),

          const BuildAnalysisStream(),

          SizedBox(height: 40 * scale),

          const OnboardingNextButton(),

          SizedBox(height: 20 * scale),
        ],
      ),
    );
  }
}