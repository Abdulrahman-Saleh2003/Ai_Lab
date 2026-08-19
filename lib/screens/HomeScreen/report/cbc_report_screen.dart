

import 'package:flutter/material.dart';
class BloodCountReportPage extends StatefulWidget {
  const BloodCountReportPage({super.key});

  @override
  State<BloodCountReportPage> createState() => _BloodCountReportPageState();
}

class _BloodCountReportPageState extends State<BloodCountReportPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111317),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0C0E11),
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Color(0xFF00D2FF)),
        title: const Text(
          'Complete Blood Count',
          style: TextStyle(color: Color(0xFF00D2FF), fontWeight: FontWeight.bold),
        ),
        actions: const [
          Icon(Icons.more_vert, color: Color(0xFFE2E2E6)),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildLabResultCard("RBC", "Red Blood Cell Count", "4.8", "Ref: 4.2 - 5.4 M/µL", Colors.green, 0.66),
            _buildLabResultCard("HGB", "Hemoglobin", "14.2", "Ref: 12.0 - 16.0 g/dL", Colors.green, 0.75),
            _buildLabResultCard("WBC", "White Blood Cell Count", "11.4", "Ref: 4.5 - 11.0 K/µL", Colors.orange, 0.85, status: "Borderline High"),
            _buildLabResultCard("PLT", "Platelet Count", "245", "Ref: 150 - 450 K/µL", Colors.green, 0.45),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: Text("DIFFERENTIAL COUNT", style: TextStyle(fontSize: 12, letterSpacing: 1.5, color: Colors.grey, fontWeight: FontWeight.bold)),
            ),

            _buildLabResultCard("Lymphocytes", "Immune Memory", "15", "Ref: 20 - 45 %", Colors.red, 0.25, status: "Critical Low"),

            const SizedBox(height: 32),
            _buildAIButton(),
            // const SizedBox(height: 40),
            // _buildFooter(),
            const SizedBox(height: 100), // Space for bottom nav
          ],
        ),
      ),
    );
  }

  // --- UI Components ---

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("LABORATORY PARTNER", style: TextStyle(fontSize: 10, color: Colors.grey, letterSpacing: 1.2)),
            Text("Quest Diagnostics", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            Text("ISSUE DATE", style: TextStyle(fontSize: 10, color: Colors.grey, letterSpacing: 1.2)),
            Text("OCT 12, 2023", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF00D2FF))),
          ],
        ),
      ],
    );
  }

  Widget _buildLabResultCard(String title, String sub, String value, String ref, Color color, double progress, {String status = "Normal"}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1C1F),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white,fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(sub, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
                      const SizedBox(width: 8),
                      Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color == Colors.green ? Colors.white : color)),
                    ],
                  ),
                  Text(ref, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                ],
              )
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: const Color(0xFF333538),
            color: color,
            minHeight: 6,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(status.toUpperCase(), style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold)),
              const Text("MEASURED VALUE", style: TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAIButton() {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(colors: [Color(0xFF00D2FF), Color(0xFF6E208C)]),
        boxShadow: [BoxShadow(color: const Color(0xFF00D2FF).withValues(alpha:0.3), blurRadius: 10)],
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.psychology, color: Colors.white),
            SizedBox(width: 10),
            Text("Generate AI Analysis", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(width: 10),
            Icon(Icons.auto_awesome, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(radius: 16, backgroundColor: Colors.grey, child: Icon(Icons.person, size: 20)),
            const SizedBox(width: 8),
            const Text("Dr. Ahmed Hassan", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
            const SizedBox(width: 4),
            const Icon(Icons.verified, color: Color(0xFF00D2FF), size: 16),
          ],
        ),
        const SizedBox(height: 8),
        const Text("VERIFIED MEDICAL REPORT • 2023", style: TextStyle(fontSize: 10, color: Colors.grey, letterSpacing: 1.2)),
      ],
    );
  }

}