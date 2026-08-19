
import 'package:ai_lab/OnBoarding/View/widget.dart';
import 'package:ai_lab/core/constant/app_color.dart';

class BuildQueueCard extends StatelessWidget {
  const BuildQueueCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppMyColor.charcoalBlack,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha:0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'PROCESSING QUEUE',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: AppMyColor.whiteApp,

            ),
          ),
          const SizedBox(height: 20),
          BuildQueueItem(
            isActive: true,
              status: 'Active' ,
              test:    '4022-A',
              vialId:  'HEMOGLOBIN A1C',
           ),
          const SizedBox(height: 12),    BuildQueueItem(
            isActive: false,
            status: 'Pending' ,
              test:  'LIPID PANEL',
            vialId:  'HEMOGLOBIN A1C',
           ),
          const SizedBox(height: 12),    BuildQueueItem(
            isActive: false,
              status: 'Pending' ,
              test:    '4024-C',
              vialId: 'VITAMIN D',
           ),


        ],
      ),
    );
  }
}
