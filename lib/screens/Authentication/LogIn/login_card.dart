// // import 'package:diagnos_ai/core/constant/app_color.dart';
// // import 'package:diagnos_ai/screens/Authentication/LogIn/type_selection_button.dart';
// // import 'package:flutter/material.dart';
// // import 'package:go_router/go_router.dart';
// //
// // import 'custom_input_field.dart';
// // import 'custom_phone_field.dart';
// //
// // class LoginCard extends StatelessWidget {
// //   final String selectedType;
// //   final Function(String) onTypeChanged;
// //
// //   final TextEditingController emailController;
// //   final TextEditingController phoneController;
// //   final TextEditingController passwordController;
// //
// //   final String selectedCountryCode;
// //   final Function(String) onCountryChanged;
// //
// //   final bool isPasswordVisible;
// //   final VoidCallback onTogglePassword;
// //
// //   final VoidCallback onLoginPressed;
// //
// //   const LoginCard({
// //     super.key,
// //     required this.selectedType,
// //     required this.onTypeChanged,
// //     required this.emailController,
// //     required this.phoneController,
// //     required this.passwordController,
// //     required this.selectedCountryCode,
// //     required this.onCountryChanged,
// //     required this.isPasswordVisible,
// //     required this.onTogglePassword,
// //     required this.onLoginPressed,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       padding: const EdgeInsets.all(28),
// //       decoration: BoxDecoration(
// //         color: const Color(0xFF1A1C1F),
// //         borderRadius: BorderRadius.circular(24),
// //         border: Border.all(color: Colors.white.withOpacity(0.08)),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.4),
// //             blurRadius: 30,
// //             offset: const Offset(0, 10),
// //           ),
// //         ],
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           const Text(
// //             'Access Your Lab',
// //             style: TextStyle(
// //               fontSize: 24,
// //               fontWeight: FontWeight.bold,
// //               color: AppMyColor.whiteApp,
// //             ),
// //           ),
// //           const SizedBox(height: 4),
// //           Container(
// //             width: 48,
// //             height: 3,
// //             decoration: BoxDecoration(
// //               color:  AppMyColor.blueColor,
// //               borderRadius: BorderRadius.circular(2),
// //             ),
// //           ),
// //
// //           const SizedBox(height: 32),
// //
// //           // Email / Phone Toggle
// //           Row(
// //             children: [
// //               TypeSelectionButton(
// //                 text: 'Email',
// //                 icon: Icons.email_outlined,
// //                 isSelected: selectedType == 'email',
// //                 onTap: () => onTypeChanged('email'),
// //               ),
// //
// //               const SizedBox(width: 12),
// //
// //               TypeSelectionButton(text:   'Phone' ,
// //                   icon:  Icons.phone_outlined,
// //                   isSelected: selectedType == 'phone',
// //                   onTap: () => onTypeChanged('phone') ),
// //
// //             ],
// //           ),
// //
// //           const SizedBox(height: 24),
// //
// //           if (selectedType == 'email')
// //             CustomInputField(
// //               label: 'Email Address',
// //               hint: 'example@labsync.com',
// //               icon: Icons.email_outlined,
// //               controller: emailController,
// //               validator: (value) {
// //                 if (value == null || value.isEmpty) return 'Email is required';
// //                 if (!value.contains('@')) return 'Invalid email';
// //                 return null;
// //               },
// //             )
// //           else
// //             CustomPhoneField(
// //               controller: phoneController,
// //               selectedCountryCode: selectedCountryCode,
// //               onCountryChanged: onCountryChanged,
// //               validator: (value) {
// //                 if (value == null || value.isEmpty) return 'Phone number required';
// //                 if (value.length < 7) return 'Invalid phone number';
// //                 return null;
// //               },
// //             ),
// //
// //           const SizedBox(height: 24),
// //
// //           // Password Field
// //           CustomInputField(
// //             label: 'Access Cipher',
// //             hint: '••••••••••••',
// //             icon: Icons.lock_outline,
// //             controller: passwordController,
// //             isPassword: true,
// //             isPasswordVisible: isPasswordVisible,
// //             onTogglePassword: onTogglePassword,
// //             validator: (value) {
// //               if (value == null || value.isEmpty) return 'Password required';
// //               if (value.length < 6) return 'Minimum 6 characters';
// //               return null;
// //             },
// //           ),
// //
// //           const SizedBox(height: 8),
// //
// //           Align(
// //             alignment: Alignment.centerRight,
// //             child: TextButton(
// //               onPressed: () {
// //
// //
// //
// //               },
// //               child: const Text(
// //                 'Forgot Password?',
// //                 style: TextStyle(color:   AppMyColor.lightLavenderPinkColor , fontSize: 13),
// //               ),
// //             ),
// //           ),
// //
// //           const SizedBox(height: 32),
// //
// //           // Login Button
// //           SizedBox(
// //             width: double.infinity,
// //             height: 58,
// //             child: ElevatedButton(
// //               onPressed: onLoginPressed,
// //               style: ElevatedButton.styleFrom(
// //                 backgroundColor:             AppMyColor.blueColor,
// //
// //                 shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(16),
// //                 ),
// //               ),
// //               child: const Text(
// //                 'EXECUTE LOGIN',
// //                 style: TextStyle(
// //                   color: AppMyColor.whiteApp,
// //                   fontSize: 16,
// //                   fontWeight: FontWeight.bold,
// //                   letterSpacing: 1.5,
// //                 ),
// //               ),
// //             ),
// //           ),
// //
// //           const SizedBox(height: 24),
// //
// //           // Sign Up
// //           GestureDetector(
// //             onTap: () => context.go('/PatientRegistrationScreen'),
// //             child: Center(
// //               child: RichText(
// //                 text: const TextSpan(
// //                   style: TextStyle(fontSize: 13, color: AppMyColor.greyApp),
// //                   children: [
// //                     TextSpan(
// //                       text: "Don't have an account? ",
// //                       style: TextStyle(
// //                         color: AppMyColor.whiteApp,
// //                         fontWeight: FontWeight.bold,
// //                         fontSize: 14,
// //                       ),
// //                     ),
// //                     TextSpan(
// //                       text: 'Sign Up',
// //                       style: TextStyle(
// //                         color:  AppMyColor.blueColor,
// //                         fontWeight: FontWeight.bold,
// //                         fontSize: 14,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:ai_lab/core/constant/app_color.dart';
// import 'package:ai_lab/screens/Authentication/LogIn/type_selection_button.dart';
//
// import 'custom_input_field.dart';
// import 'custom_phone_field.dart';
//
// class LoginCard extends StatelessWidget {
//   final String selectedType;
//   final Function(String) onTypeChanged;
//
//   final TextEditingController emailController;
//   final TextEditingController phoneController;
//   final TextEditingController passwordController;
//
//   final String selectedCountryCode;
//   final Function(String) onCountryChanged;
//
//   final bool isPasswordVisible;
//   final VoidCallback onTogglePassword;
//
//   final VoidCallback onLoginPressed;
//
//   const LoginCard({
//     super.key,
//     required this.selectedType,
//     required this.onTypeChanged,
//     required this.emailController,
//     required this.phoneController,
//     required this.passwordController,
//     required this.selectedCountryCode,
//     required this.onCountryChanged,
//     required this.isPasswordVisible,
//     required this.onTogglePassword,
//     required this.onLoginPressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.sizeOf(context);
//     final scale = size.width / 375;
//
//     return Container(
//       padding: EdgeInsets.all(28 * scale),
//       decoration: BoxDecoration(
//         color: const Color(0xFF1A1C1F),
//         borderRadius: BorderRadius.circular(24 * scale),
//         border: Border.all(color: Colors.white.withOpacity(0.08)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.4),
//             blurRadius: 30 * scale,
//             offset: Offset(0, 10 * scale),
//           ),
//         ],
//       ),
//
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // 🔥 Title
//           Text(
//             'Access Your Lab',
//             style: TextStyle(
//               fontSize: 24 * scale,
//               fontWeight: FontWeight.bold,
//               color: AppMyColor.whiteApp,
//             ),
//           ),
//
//           SizedBox(height: 4 * scale),
//
//           Container(
//             width: 48 * scale,
//             height: 3 * scale,
//             decoration: BoxDecoration(
//               color: AppMyColor.blueColor,
//               borderRadius: BorderRadius.circular(2 * scale),
//             ),
//           ),
//
//           SizedBox(height: 32 * scale),
//
//           // 🔀 Toggle Buttons
//           Row(
//             children: [
//               TypeSelectionButton(
//                 text: 'Email',
//                 icon: Icons.email_outlined,
//                 isSelected: selectedType == 'email',
//                 onTap: () => onTypeChanged('email'),
//               ),
//
//               SizedBox(width: 12 * scale),
//
//               TypeSelectionButton(
//                 text: 'Phone',
//                 icon: Icons.phone_outlined,
//                 isSelected: selectedType == 'phone',
//                 onTap: () => onTypeChanged('phone'),
//               ),
//             ],
//           ),
//
//           SizedBox(height: 24 * scale),
//
//           // 📧 Email / Phone field
//           if (selectedType == 'email')
//             CustomInputField(
//               label: 'Email Address',
//               hint: 'example@labsync.com',
//               icon: Icons.email_outlined,
//               controller: emailController,
//               validator: (value) {
//                 if (value == null || value.isEmpty) return 'Email is required';
//                 if (!value.contains('@')) return 'Invalid email';
//                 return null;
//               },
//             )
//           else
//             CustomPhoneField(
//               controller: phoneController,
//               selectedCountryCode: selectedCountryCode,
//               onCountryChanged: onCountryChanged,
//               validator: (value) {
//                 if (value == null || value.isEmpty) return 'Phone number required';
//                 if (value.length < 7) return 'Invalid phone number';
//                 return null;
//               },
//             ),
//
//           SizedBox(height: 24 * scale),
//
//           // 🔒 Password
//           CustomInputField(
//             label: 'Access Cipher',
//             hint: '••••••••••••',
//             icon: Icons.lock_outline,
//             controller: passwordController,
//             isPassword: true,
//             isPasswordVisible: isPasswordVisible,
//             onTogglePassword: onTogglePassword,
//             validator: (value) {
//               if (value == null || value.isEmpty) return 'Password required';
//               if (value.length < 6) return 'Minimum 6 characters';
//               return null;
//             },
//           ),
//
//           SizedBox(height: 8 * scale),
//
//           // 🔁 Forgot Password
//           Align(
//             alignment: Alignment.centerRight,
//             child: TextButton(
//               onPressed: () {},
//               child: Text(
//                 'Forgot Password?',
//                 style: TextStyle(
//                   color: AppMyColor.lightLavenderPinkColor,
//                   fontSize: 13 * scale,
//                 ),
//               ),
//             ),
//           ),
//
//           SizedBox(height: 32 * scale),
//
//           // 🚀 Login Button
//           SizedBox(
//             width: double.infinity,
//             height: 58 * scale,
//             child: ElevatedButton(
//               onPressed: onLoginPressed,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppMyColor.blueColor,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16 * scale),
//                 ),
//               ),
//               child: Text(
//                 'EXECUTE LOGIN',
//                 style: TextStyle(
//                   color: AppMyColor.whiteApp,
//                   fontSize: 16 * scale,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 1.5 * scale,
//                 ),
//               ),
//             ),
//           ),
//
//           SizedBox(height: 24 * scale),
//
//           // 🧾 Sign up
//           GestureDetector(
//             onTap: () => context.go('/register'),
//             child: Center(
//               child: RichText(
//                 text: TextSpan(
//                   style: TextStyle(
//                     fontSize: 13 * scale,
//                     color: AppMyColor.greyApp,
//                   ),
//                   children: [
//                     TextSpan(
//                       text: "Don't have an account? ",
//                       style: TextStyle(
//                         color: AppMyColor.whiteApp,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14 * scale,
//                       ),
//                     ),
//                     TextSpan(
//                       text: 'Sign Up',
//                       style: TextStyle(
//                         color: AppMyColor.blueColor,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14 * scale,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_lab/core/constant/app_color.dart';
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
  final bool isLoading; // ← الجديد

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
    this.isLoading = false, // ← الجديد
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final scale = size.width / 375;

    return Container(
      padding: EdgeInsets.all(28 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1C1F),
        borderRadius: BorderRadius.circular(24 * scale),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
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
            'Access Your Lab',
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
                text: 'Email',
                icon: Icons.email_outlined,
                isSelected: selectedType == 'email',
                onTap: isLoading ? null : () => onTypeChanged('email'),
              ),
              SizedBox(width: 12 * scale),
              TypeSelectionButton(
                text: 'Phone',
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
              label: 'Email Address',
              hint: 'example@labsync.com',
              icon: Icons.email_outlined,
              controller: emailController,
              // تقدر تضيف enabled: !isLoading لو الـ CustomInputField يدعم
              validator: (value) {
                if (value == null || value.isEmpty) return 'Email is required';
                if (!value.contains('@')) return 'Invalid email';
                return null;
              },
            )
          else
            CustomPhoneField(
              controller: phoneController,
              selectedCountryCode: selectedCountryCode,
              onCountryChanged: onCountryChanged,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Phone number required';
                if (value.length < 7) return 'Invalid phone number';
                return null;
              },
            ),

          SizedBox(height: 24 * scale),

          // Password
          CustomInputField(
            label: 'Access Cipher',
            hint: '••••••••••••',
            icon: Icons.lock_outline,
            controller: passwordController,
            isPassword: true,
            isPasswordVisible: isPasswordVisible,
            onTogglePassword: isLoading ? null : onTogglePassword,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Password required';
              if (value.length < 6) return 'Minimum 6 characters';
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
                'Forgot Password?',
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
                disabledBackgroundColor: AppMyColor.blueColor.withOpacity(0.6),
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
                'EXECUTE LOGIN',
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
                      text: "Don't have an account? ",
                      style: TextStyle(
                        color: AppMyColor.whiteApp,
                        fontWeight: FontWeight.bold,
                        fontSize: 14 * scale,
                      ),
                    ),
                    TextSpan(
                      text: 'Sign Up',
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