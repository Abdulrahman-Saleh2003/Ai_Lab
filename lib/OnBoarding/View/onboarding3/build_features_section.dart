
import 'package:ai_lab/OnBoarding/View/widget.dart';

class BuildFeaturesSection extends StatelessWidget {
  const BuildFeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = AppSize.scale(context);

    return Column(
      children: [
        // 🔥 Molecular Tracking Card
        Container(
          padding: EdgeInsets.all(24 * scale),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1C1F),
            borderRadius: BorderRadius.circular(20 * scale),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(14 * scale),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00D2FF).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12 * scale),
                    ),
                    child: Icon(
                      Icons.bubble_chart,
                      color: const Color(0xFF00D2FF),
                      size: 36 * scale,
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '0.02μ',
                        style: TextStyle(
                          fontSize: 28 * scale,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF00D2FF),
                        ),
                      ),
                      Text(
                        'Precision Range',
                        style: TextStyle(
                          fontSize: 12 * scale,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 20 * scale),

              Text(
                'Molecular Tracking',
                style: TextStyle(
                  fontSize: 22 * scale,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 8 * scale),

              Text(
                'Deep-level sequence monitoring to detect subtle changes in biological markers over time.',
                style: TextStyle(
                  color: Colors.grey,
                  height: 1.5,
                  fontSize: 14 * scale,
                ),
              ),

              SizedBox(height: 20 * scale),

              // 📊 Mini Bar Chart
              Container(
                height: 80 * scale,
                decoration: BoxDecoration(
                  color: const Color(0xFF111317),
                  borderRadius: BorderRadius.circular(12 * scale),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    MiniBar(height: 35 * scale),
                    MiniBar(height: 55 * scale),
                    MiniBar(height: 80 * scale, isHighlighted: true),
                    MiniBar(height: 50 * scale),
                    MiniBar(height: 40 * scale),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 16 * scale),

        // 🔔 Smart Alerts Card
        Container(
          padding: EdgeInsets.all(24 * scale),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1C1F),
            borderRadius: BorderRadius.circular(20 * scale),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12 * scale),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDB1FF).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12 * scale),
                ),
                child: Icon(
                  Icons.notifications_active,
                  color: const Color(0xFFEDB1FF),
                  size: 32 * scale,
                ),
              ),

              SizedBox(height: 16 * scale),

              Text(
                'Smart Alerts',
                style: TextStyle(
                  fontSize: 22 * scale,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 8 * scale),

              Text(
                'Instant trend alerts triggered by anomalies in your longitudinal data streams.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14 * scale,
                ),
              ),

              SizedBox(height: 20 * scale),

              const BuildAlertItem(
                text: 'Critical Shift Detected',
                isCritical: true,
              ),

              SizedBox(height: 8 * scale),

              const BuildAlertItem(
                text: 'Stability Maintained',
                isCritical: false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}