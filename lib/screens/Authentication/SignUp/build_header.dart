import 'package:flutter/material.dart';

class RegistrationHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBackPressed;

  const RegistrationHeader({
    super.key,
    this.title = "   REGISTRATION",
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return

      Text(
        title,
        style: const TextStyle(
          fontFamily: 'SpaceGrotesk',
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          color: Color(0xFF00D2FF),
        ),
    );
  }
}