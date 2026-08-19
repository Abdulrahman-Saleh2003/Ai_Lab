import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0C0E11).withOpacity(0.8),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00D2FF).withOpacity(0.08),
            blurRadius: 40,
            offset: const Offset(0, -20),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.biotech, 'Analysis', false),
              _navItem(Icons.hub, 'LabSync', true),
              _navItem(Icons.description, 'Reports', false),
              _navItem(Icons.account_circle, 'Profile', false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: isActive ? const EdgeInsets.symmetric(horizontal: 20, vertical: 8) : EdgeInsets.zero,
          decoration: isActive
              ? BoxDecoration(
                  color: const Color(0xFF00D2FF),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00D2FF).withOpacity(0.4),
                      blurRadius: 15,
                    ),
                  ],
                )
              : null,
          child: Icon(
            icon,
            size: 22,
            color: isActive ? const Color(0xFF00566A) : const Color(0xFFBBC9CF).withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            letterSpacing: 1.2,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? const Color(0xFF00D2FF) : const Color(0xFFBBC9CF).withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}