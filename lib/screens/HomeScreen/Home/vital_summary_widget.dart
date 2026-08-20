import 'package:ai_lab/core/constant/app_size.dart';
import 'package:ai_lab/screens/HomeScreen/Home/summary_card_widget.dart';
import 'package:easy_localization/easy_localization.dart';
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
    final scale = AppSize.scale(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "VITAL SUMMARY",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'SpaceGrotesk',
                  fontSize: 20 * scale.clamp(0.9, 1.15),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 8),
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
          childAspectRatio: 1.25,
          children: [
            SummaryCardWidget(
              title: "total_tests".tr(),
              value: "24",
              subtitle: "+12%",
              icon: Icons.analytics,
              accentColor: const Color(0xFF00D2FF),
              onTap: onTotalTestsTap,
            ),
            SummaryCardWidget(
              title: "normal_results".tr(),
              value: "20",
              subtitle: "83%",
              icon: Icons.check_circle,
              accentColor: Colors.green,
              onTap: onNormalResultsTap,
            ),
            SummaryCardWidget(
              title: "need_follow_up".tr(),
              value: "04",
              subtitle: "Alert",
              icon: Icons.priority_high,
              accentColor: Colors.red,
              onTap: onNeedFollowUpTap,
            ),
            SummaryCardWidget(
              title: "following_doctors".tr(),
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