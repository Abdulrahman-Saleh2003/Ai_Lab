import 'package:ai_lab/OnBoarding/View/widget.dart';



class BuildNetworkVisualization extends StatelessWidget {
  const BuildNetworkVisualization({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1C1F),
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image:


          AssetImage(
              AppImageAsset.onboarding2
          ),
          fit: BoxFit.cover,
          opacity: 0.6,
        ),
      ),
      child: Stack(
        children: [
          // Live Pulse
          Positioned(
            top: 24,
            left: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha:0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.fiber_manual_record, color: Color(0xFF00D2FF), size: 12),
                  SizedBox(width: 8),
                  Text(
                    'Live Network Pulse',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13,color: Colors.white),
                  ),
                ],
              ),
            ),
          ),

          // Overlay Info
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha:0.75),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF00D2FF).withValues(alpha:0.3)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Diagnostic Stream Active',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Transmission of high-resolution bio-scans to centralized laboratory node Alpha-9.',
                    style: TextStyle(color: Colors.grey, height: 1.4),
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
