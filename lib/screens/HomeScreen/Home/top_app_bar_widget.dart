import 'package:ai_lab/core/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class TopAppBarWidget extends StatelessWidget {
  final String userName;
  final String welcomeText;
  final VoidCallback? onNotificationsPressed;
  final String? avatarImageUrl;

  const TopAppBarWidget({
    super.key,
    this.userName = "Ahmed",
    this.welcomeText = "Operator Welcome",
    this.onNotificationsPressed,
    this.avatarImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final scale = size.width / 375;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left Side - User Info
        Row(
          children: [
            CircleAvatar(
              radius: 20 * scale.clamp(0.9, 1.2),
              // backgroundColor: const Color(0xFF1E2023),
              backgroundColor:  const Color(0xFF0C0E11),
              backgroundImage: avatarImageUrl != null
                  ? NetworkImage(avatarImageUrl!)
                  : null,
              child: avatarImageUrl == null
                  ? Icon(
                Icons.insert_emoticon,
                color: AppMyColor.blueColor,
                size: 28 * scale.clamp(0.9, 1.2),
              )
                  : null,
            ),
            SizedBox(width: 12 * scale),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(welcomeText.tr(),
                  style: TextStyle(
                    fontSize: 14 * scale.clamp(0.9, 1.1),
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
                Text(
                  userName,
                  style: TextStyle(
                    fontSize: 16 * scale.clamp(0.95, 1.15),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),

        // Right Side - Notifications
        GestureDetector(
          onTap: onNotificationsPressed,
          child: Stack(
            children: [
              Icon(
                Icons.notifications,
                color: Colors.white,
                size: 40 * scale.clamp(0.9, 1.2),
              ),
              Positioned(
                right: 6 * scale,
                top: 6 * scale,
                child: Container(
                  width: 9 * scale.clamp(0.9, 1.3),
                  height: 9 * scale.clamp(0.9, 1.3),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00D2FF),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00D2FF).withOpacity(0.7),
                        blurRadius: 6,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}