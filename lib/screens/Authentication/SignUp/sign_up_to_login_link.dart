import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_lab/core/constant/app_color.dart';

class SignUpToLoginLink extends StatelessWidget {
  const SignUpToLoginLink({super.key,      this.onTap, this.label= "Already have an account? ",  this.value= "Log In"});
final VoidCallback? onTap;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => context.go('/login'),

      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              fontSize: 14.5,
              color: AppMyColor.greyApp,
              height: 1.6,
            ),
            children: [
              const TextSpan(
                text: "Already have an account? ",
                style: TextStyle(
                  color: AppMyColor.whiteApp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: "Log In",
                style: TextStyle(
                  color: AppMyColor.blueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  decoration: TextDecoration.underline,
                  decorationColor: AppMyColor.blueColor.withValues(alpha:0.6),
                  decorationThickness: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginRedirectText extends StatelessWidget {
  // final VoidCallback onTap;
  final VoidCallback? onTap;

  const LoginRedirectText({
    super.key,
     this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Already have an account? ",
            style: TextStyle(
              color: Colors.white,
              // color: Colors.grey,
              fontSize: 11,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          /// الجزء القابل للضغط
          InkWell(
            // onTap: onTap,
            onTap: onTap ?? () => context.go('/login'),

            borderRadius: BorderRadius.circular(8),
            splashColor: const Color(0xFF00D2FF).withValues(alpha:0.2),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child:   AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  color: const Color(0xFF00D2FF),
                  fontWeight: FontWeight.bold,
                ),
                child: const Text("Log In",style: TextStyle(
                    color: const Color(0xFF00D2FF),
                fontSize: 11,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),),
              )


            ),
          ),
        ],
      ),
    );
  }
}


