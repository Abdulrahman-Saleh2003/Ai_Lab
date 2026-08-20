import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_lab/core/constant/app_color.dart';
import 'package:ai_lab/core/constant/app_size.dart';
import 'package:ai_lab/screens/Authentication/LogIn/type_selection_button.dart';
import 'custom_input_field.dart';
import 'custom_phone_field.dart';

class LoginCard extends StatelessWidget {
  final String selectedType;
  final Function(String) onTypeChanged;

  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;

  final String selectedCountryCode;
  final Function(String) onCountryChanged;

  final bool isPasswordVisible;
  final VoidCallback onTogglePassword;

  final VoidCallback onLoginPressed;
  final bool isLoading;

  const LoginCard({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.selectedCountryCode,
    required this.onCountryChanged,
    required this.isPasswordVisible,
    required this.onTogglePassword,
    required this.onLoginPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final scale = AppSize.scale(context);

    return Container(
      padding: EdgeInsets.all(28 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1C1F),
        borderRadius: BorderRadius.circular(24 * scale),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 30 * scale,
            offset: Offset(0, 10 * scale),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            'access_your_lab'.tr(),
            style: TextStyle(
              fontSize: 24 * scale,
              fontWeight: FontWeight.bold,
              color: AppMyColor.whiteApp,
            ),
          ),

          SizedBox(height: 4 * scale),

          Container(
            width: 48 * scale,
            height: 3 * scale,
            decoration: BoxDecoration(
              color: AppMyColor.blueColor,
              borderRadius: BorderRadius.circular(2 * scale),
            ),
          ),

          SizedBox(height: 32 * scale),

          // Toggle Buttons
          Row(
            children: [
              TypeSelectionButton(
                text: 'email'.tr(),
                icon: Icons.email_outlined,
                isSelected: selectedType == 'email',
                onTap: isLoading ? null : () => onTypeChanged('email'),
              ),
              SizedBox(width: 12 * scale),
              TypeSelectionButton(
                text: 'phone'.tr(),
                icon: Icons.phone_outlined,
                isSelected: selectedType == 'phone',
                onTap: isLoading ? null : () => onTypeChanged('phone'),
              ),
            ],
          ),

          SizedBox(height: 24 * scale),

          // Email / Phone field
          if (selectedType == 'email')
            CustomInputField(
              label: 'email_address'.tr(),
              hint: 'example@labsync.com',
              icon: Icons.email_outlined,
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty) return 'email_required'.tr();
                if (!value.contains('@')) return 'invalid_email'.tr();
                return null;
              },
            )
          else
            CustomPhoneField(
              controller: phoneController,
              selectedCountryCode: selectedCountryCode,
              onCountryChanged: onCountryChanged,
              validator: (value) {
                if (value == null || value.isEmpty) return 'phone_required'.tr();
                if (value.length < 7) return 'invalid_phone'.tr();
                return null;
              },
            ),

          SizedBox(height: 24 * scale),

          // Password
          CustomInputField(
            label: 'access_cipher'.tr(),
            hint: '••••••••••••',
            icon: Icons.lock_outline,
            controller: passwordController,
            isPassword: true,
            isPasswordVisible: isPasswordVisible,
            onTogglePassword: isLoading ? null : onTogglePassword,
            validator: (value) {
              if (value == null || value.isEmpty) return 'password_required'.tr();
              if (value.length < 6) return 'password_too_short'.tr();
              return null;
            },
          ),

          SizedBox(height: 8 * scale),

          // Forgot Password
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: isLoading ? null : () {},
              child: Text(
                'forgot_password'.tr(),
                style: TextStyle(
                  color: AppMyColor.lightLavenderPinkColor,
                  fontSize: 13 * scale,
                ),
              ),
            ),
          ),

          SizedBox(height: 32 * scale),

          // Login Button
          SizedBox(
            width: double.infinity,
            height: 58 * scale,
            child: ElevatedButton(
              onPressed: isLoading ? null : onLoginPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppMyColor.blueColor,
                disabledBackgroundColor: AppMyColor.blueColor.withValues(alpha: 0.6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16 * scale),
                ),
              ),
              child: isLoading
                  ? SizedBox(
                      width: 24 * scale,
                      height: 24 * scale,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      'login'.tr().toUpperCase(),
                      style: TextStyle(
                        color: AppMyColor.whiteApp,
                        fontSize: 16 * scale,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5 * scale,
                      ),
                    ),
            ),
          ),

          SizedBox(height: 24 * scale),

          // Sign up
          GestureDetector(
            onTap: isLoading ? null : () => context.go('/register'),
            child: Center(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 13 * scale,
                    color: AppMyColor.greyApp,
                  ),
                  children: [
                    TextSpan(
                      text: "dont_have_account_prefix".tr(),
                      style: TextStyle(
                        color: AppMyColor.whiteApp,
                        fontWeight: FontWeight.bold,
                        fontSize: 14 * scale,
                      ),
                    ),
                    TextSpan(
                      text: 'signup'.tr(),
                      style: TextStyle(
                        color: AppMyColor.blueColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14 * scale,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}