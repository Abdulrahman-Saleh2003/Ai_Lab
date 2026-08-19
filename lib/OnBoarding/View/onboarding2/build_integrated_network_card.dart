import 'package:flutter/material.dart';

class BuildIntegratedNetworkCard extends StatelessWidget {
  const BuildIntegratedNetworkCard({super.key});

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
          const Icon(Icons.hub, size: 48, color: Color(0xFFEDB1FF)),
          const SizedBox(height: 16),
          const Text(
            'Integrated Diagnostic Network',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold ,color: Colors.white),
          ),
          const SizedBox(height: 8),
          const Text(
            'Connect directly with a curated global community of specialized clinicians and lab experts.',
            style: TextStyle(color: Colors.grey, height: 1.5),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Active Nodes', style: TextStyle(fontSize: 13, letterSpacing: 1,color: Color(0xFFEDB1FF))),
              Text('1.2k+', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold,color: Colors.green)),
            ],
          ),
        ],
      ),
    );
  }
}
