import 'package:ai_lab/OnBoarding/View/widget.dart';


class BuildVitalityMetrics extends StatelessWidget {
  const BuildVitalityMetrics({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1C1F),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const Text(
            'VITALITY METRICS',
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'SpaceGrotesk',
                overflow: TextOverflow.ellipsis

            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Comparative analysis of active processing streams',
            style: TextStyle(color: Colors.grey[400], fontSize: 14),
          ),

          const SizedBox(height: 28),
// m
          // Legend
          Row(
            children: [
              BuildLegendItem(color: const Color(0xFF00D2FF), label:'Potassium'),
              const SizedBox(width: 24),
              BuildLegendItem(color:const Color(0xFFEDB1FF), label:'Sodium'),

              const SizedBox(width: 24),
              BuildLegendItem(color:const Color(0xFFD8B1FF), label:'Glucose'),

            ],
          ),

          const SizedBox(height: 32),


          BuildMetricChart(
            title: 'Potassium (K+)',
            value: '4.2',
            unit: 'mEq/L',
            color: const Color(0xFF00D2FF),
            heights: [8, 12, 10, 14, 9, 11],
          ),
          const SizedBox(height: 32),

          BuildMetricChart(
            title: 'Sodium (Na+)',
            value: '138',
            unit: 'mEq/L',
            color: const Color(0xFFEDB1FF),
            heights: [14, 9, 12, 8, 13, 10],
          ),
          const SizedBox(height: 32),

          BuildMetricChart(
            title: 'Glucose',
            value: '94',
            unit: 'mg/dL',
            color: const Color(0xFFD8B1FF),
            heights: [10, 14, 9, 11, 15, 8],
          ),
        ],
      ),
    );
  }
}
