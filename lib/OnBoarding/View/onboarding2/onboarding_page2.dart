import 'package:ai_lab/OnBoarding/View/widget.dart';




class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({super.key});


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Section
          const Text(
            'Expert Collaboration',
            style: TextStyle(
              fontFamily: 'SpaceGrotesk',
              fontSize: 42,
              fontWeight: FontWeight.bold,
              height: 1.1,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Seamlessly share and discuss results with your doctors and laboratory technicians through our encrypted network.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),

          BuildNetworkVisualization(),

          const SizedBox(height: 16),

          BuildIntegratedNetworkCard(),

          const SizedBox(height: 32),

          const Text(
            'Why Choose Our Network?',
            style: TextStyle(
                fontFamily: 'SpaceGrotesk',
                fontSize: 20,
                fontWeight: FontWeight.bold
                ,color: Colors.white
            ),
          ),
          const SizedBox(height: 16),
          BuildFeatureCards(),

          const SizedBox(height: 40),



          Row(
            children: [
              Expanded(
                child: Text(
                  'Active Clinical Streams',
                  style: TextStyle(
                    fontFamily: 'SpaceGrotesk',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward, size: 16),
                label: const Text('View Archive'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // _buildClinicalStreams(),
          BuildClinicalStreams(),

          // const SizedBox(height: 10),

          const SizedBox(height: 40),

          const OnboardingNextButton(),

          const SizedBox(height: 20),
        ],

      ),
    );
  }

}
