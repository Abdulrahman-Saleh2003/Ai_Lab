import 'package:ai_lab/OnBoarding/View/widget.dart';


class BuildFeatureCards extends StatelessWidget {
  const BuildFeatureCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BuildFeatureItem(
          icon: Icons.verified_user,
          title: 'End-to-End Encryption',
          desc: 'Military-grade AES-256 encryption protocols ensure your clinical data remains strictly between you and your doctor.',
        ),
        const SizedBox(height: 16),
        BuildFeatureItem(
          icon: Icons.bolt,
          title: 'Instant Feedback',
          desc: 'Real-time annotation system allows for direct commentary on digital clinical records with push notifications.',
        ),
        const SizedBox(height: 16),
        BuildFeatureItem(
          icon: Icons.biotech,
          title: 'Certified Verification',
          desc: 'Every participant in the network undergoes a rigorous credential verification process by LAB_SYS authorities.',
        ),
      ],
    );
  }
}
