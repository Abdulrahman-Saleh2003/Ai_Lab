import 'package:ai_lab/screens/HomeScreen/Home/summary_card_widget.dart';
import 'package:flutter/material.dart';

class VitalSummaryWidget extends StatelessWidget {
  final VoidCallback? onTotalTestsTap;
  final VoidCallback? onNormalResultsTap;
  final VoidCallback? onNeedFollowUpTap;
  final VoidCallback? onFollowingDoctorsTap;

  const VitalSummaryWidget({
    super.key,
    this.onTotalTestsTap,
    this.onNormalResultsTap,
    this.onNeedFollowUpTap,
    this.onFollowingDoctorsTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final scale = size.width / 375;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "VITAL SUMMARY",
              style: TextStyle(
                fontFamily: 'SpaceGrotesk',
                fontSize: 20 * scale.clamp(0.9, 1.15),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "Cycle 24B",
              style: TextStyle(
                fontSize: 11 * scale.clamp(0.9, 1.1),
                color: Colors.grey,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        SizedBox(height: 16 * scale),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12 * scale,
          crossAxisSpacing: 12 * scale,
          childAspectRatio: 1.25, // تعديل طفيف للشكل على الشاشات المختلفة
          children: [
            SummaryCardWidget(
              title: "Total Tests",
              value: "24",
              subtitle: "+12%",
              icon: Icons.analytics,
              accentColor: const Color(0xFF00D2FF),
              onTap: onTotalTestsTap,
            ),
            SummaryCardWidget(
              title: "Normal Results",
              value: "20",
              subtitle: "83%",
              icon: Icons.check_circle,
              accentColor: Colors.green,
              onTap: onNormalResultsTap,
            ),
            SummaryCardWidget(
              title: "Need Follow-up",
              value: "04",
              subtitle: "Alert",
              icon: Icons.priority_high,
              accentColor: Colors.red,
              onTap: onNeedFollowUpTap,
            ),
            SummaryCardWidget(
              title: "Following Doctors",
              value: "03",
              subtitle: "Active",
              icon: Icons.medical_services,
              accentColor: const Color(0xFFEDB1FF),
              onTap: onFollowingDoctorsTap,
            ),
          ],
        ),
      ],
    );
  }
}