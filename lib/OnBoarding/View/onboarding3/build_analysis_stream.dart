import 'package:ai_lab/OnBoarding/View/widget.dart';

class BuildAnalysisStream extends StatelessWidget {
  const BuildAnalysisStream({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        BuildStreamItem(num: '01',  title: 'Glucose Variability Index', nodeId: 'Node ID: 4492-X', status: 'Normal', time: '2m ago', color:  const Color(0xFF00D2FF)),
        const SizedBox(height: 12),

        BuildStreamItem(num: '02',  title: 'Lipid Profile Cluster', nodeId: 'Node ID: 8821-K', status: 'Optimizing', time: 'In Progress...', color:  const Color(0xFFEDB1FF)),

      ],
    );  }
}
