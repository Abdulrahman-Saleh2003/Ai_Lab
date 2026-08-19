import 'package:ai_lab/OnBoarding/View/widget.dart';

class BuildIntelligenceCards extends StatelessWidget {
  const BuildIntelligenceCards({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        BuildIntelligenceCard(
          icon: Icons.biotech,
          title: 'Automated Synthesis',
          desc: 'Real-time biological data processing using advanced neural lab-networks.',
          color: const Color(0xFF00D2FF),
        ),
        const SizedBox(height: 16),
        BuildIntelligenceCard(
          icon: Icons.analytics,

          title: 'Precision Diagnostics',
          desc: 'Eliminating human error through clinical-grade AI verification systems.',
          color: const Color(0xFFEDB1FF),
        ),
        const SizedBox(height: 16),
        BuildIntelligenceCard(
          icon: Icons.cloud_sync,
          title: 'Instant Sync',
          desc: 'Access your synthetic lab reports across all devices with zero latency.',
          color: const Color(0xFF9D50BB),
        ),
      ],
    );
  }
}
