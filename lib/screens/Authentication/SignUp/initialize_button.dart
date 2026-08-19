import 'package:flutter/material.dart';

class InitializeButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;

  const InitializeButton({
    super.key,
    required this.onPressed,
    this.text = 'INITIALIZE NODE',
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final scale = size.width / 375;

    return SizedBox(
      width: double.infinity,
      height: 62 * scale,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00D2FF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50 * scale),
          ),
          elevation: 0,
        ),

        child: isLoading
            ? SizedBox(
          height: 24 * scale,
          width: 24 * scale,
          child: CircularProgressIndicator(
            color: Colors.black,
            strokeWidth: 2.5 * scale,
          ),
        )

            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.power_settings_new,
              color: Colors.black,
              size: 22 * scale,
            ),

            SizedBox(width: 10 * scale),

            Text(
              text,
              style: TextStyle(
                fontSize: 14 * scale,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5 * scale,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}