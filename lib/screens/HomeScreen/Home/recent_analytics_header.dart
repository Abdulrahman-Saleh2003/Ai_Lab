import 'package:ai_lab/core/constant/app_size.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RecentAnalyticsHeader extends StatelessWidget {
  final String? title;
  final String? buttonText;
  final VoidCallback? onViewLedgerPressed;

  const RecentAnalyticsHeader({
    super.key,
    this.title,
    this.buttonText,
    this.onViewLedgerPressed,
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
                title ?? "recent_analytics".tr(),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'SpaceGrotesk',
                  fontSize: 20 * scale.clamp(0.9, 1.15),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            TextButton(
              onPressed: onViewLedgerPressed,
              child: Text(
                buttonText ?? "view_ledger".tr(),
                style: TextStyle(
                  color: const Color(0xFF00D2FF),
                  fontSize: 13 * scale.clamp(0.9, 1.1),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12 * scale.clamp(0.9, 1.2)),
      ],
    );
  }
}