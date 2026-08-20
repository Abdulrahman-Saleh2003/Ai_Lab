import 'package:ai_lab/OnBoarding/View/widget.dart';
import 'package:ai_lab/core/constant/app_color.dart';

class BuildAiBrainVisualization extends StatelessWidget {
  const BuildAiBrainVisualization({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = AppSize.scale(context);

    return Container(
      height: 380 * scale,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1C1F),
        borderRadius: BorderRadius.circular(20 * scale),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 300 * scale,
            height: 300 * scale,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppMyColor.blueColor.withValues(alpha: 0.25),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20 * scale),
            child: Image.asset(
              AppImageAsset.onboarding3,
              height: 340 * scale,
              fit: BoxFit.cover,
            ),
          ),
          // Accuracy Overlay
          Positioned(
            bottom: 40 * scale,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 32 * scale,
                vertical: 14 * scale,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.75),
                borderRadius: BorderRadius.circular(16 * scale),
                border: Border.all(
                  color: AppMyColor.blueColor.withValues(alpha: 0.4),
                  width: 1.5 * scale,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    '98.4%',
                    style: TextStyle(
                      fontSize: 36 * scale,
                      fontWeight: FontWeight.bold,
                      color: AppMyColor.blueColor,
                    ),
                  ),
                  Text(
                    'Accuracy Index',
                    style: TextStyle(
                      fontSize: 12 * scale,
                      color: Colors.grey,
                      letterSpacing: 1 * scale,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}