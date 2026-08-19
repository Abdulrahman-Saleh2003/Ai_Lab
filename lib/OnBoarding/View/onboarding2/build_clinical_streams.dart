import 'package:ai_lab/OnBoarding/View/widget.dart';


class BuildClinicalStreams extends StatelessWidget {
  const BuildClinicalStreams({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 1,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 0.99,
      children: [

        BuildRecordCard(id: '#882-B', title:  'Cellular Analysis', subtitle: '14m ago', progress: 70, nameImage: AppImageAsset.onboarding2_1)
,

        BuildRecordCard(id:'#119-X' , title: 'Cardiac Vital Link', subtitle: 'Stable', progress: 100, nameImage:AppImageAsset.onboarding2_2  ),
        BuildRecordCard(id: '#402-Q', title:'Enzyme Mapping' , subtitle: 'Technician: R. Miller', progress:45 , nameImage:AppImageAsset.onboarding2_3 ),

        BuildRecordCard(id: '#671-L', title: 'Genetic Sequencing', subtitle:  'Awaiting Review', progress: 15, nameImage:AppImageAsset.onboarding2_4 ),],
    );
  }
}
