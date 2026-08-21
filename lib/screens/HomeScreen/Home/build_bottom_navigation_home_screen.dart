import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BuildBottomNavigationHomeScreen extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabChanged;

  const BuildBottomNavigationHomeScreen({
    super.key,
    required this.currentIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1810),
          border: Border(
            top: BorderSide(color: Colors.grey.withValues(alpha: 0.9)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavItemHomeScreen(
              icon: Icons.grid_view,
              label: 'nav_dashboard'.tr(),
              active: currentIndex == 0,
              onTap: () => onTabChanged(0),
            ),
            NavItemHomeScreen(
              icon: Icons.biotech,
              label: 'nav_tests'.tr(),
              active: currentIndex == 1,
              onTap: () => onTabChanged(1),
            ),
            NavItemHomeScreen(
              icon: Icons.event_note,
              label: 'nav_appointments'.tr(),
              active: currentIndex == 2,
              onTap: () => onTabChanged(2),
            ),
            // NavItemHomeScreen(
            //   icon: Icons.description,
            //   label: 'nav_reports'.tr(),
            //   active: currentIndex == 3,
            //   onTap: () => onTabChanged(3),
            // ),
            NavItemHomeScreen(
              icon: Icons.settings,
              label: 'nav_settings'.tr(),
              active: currentIndex == 3,
              onTap: () => onTabChanged(3),
            ),
            NavItemHomeScreen(
              icon: Icons.chat_bubble,
              label: 'nav_chat'.tr(),
              active: currentIndex == 4,
              onTap: () => onTabChanged(4),
            ),
          ],
        ),
      ),
    );
  }
}

class NavItemHomeScreen extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback? onTap;

  const NavItemHomeScreen({
    super.key,
    required this.icon,
    required this.label,
    this.active = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = active ? const Color(0xFF00D2FF) : Colors.white;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: 28,
            fill: active ? 1.0 : 0.0,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 8,
              color: color,
              fontWeight: active ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}