import 'package:ai_lab/OnBoarding/View/onboarding1/build_journey_step.dart';
import 'package:flutter/material.dart';

class BuildSampleJourney extends StatelessWidget {
  const BuildSampleJourney({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1C1F),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            'SAMPLE JOURNEY',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BuildJourneyStep(icon: Icons.check, title:'Received', time:  '10:42 AM', isCompleted: true),
              BuildJourneyStep(icon: Icons.autorenew, title: 'Analysis', time:  'IN PROGRESS', isCompleted: true,isActive: true,),
              BuildJourneyStep(icon: Icons.description, title:'Result',  time: 'EST. 15 MINS', isCompleted: false),

            ],
          ),
        ],
      ),
    );
  }
}
