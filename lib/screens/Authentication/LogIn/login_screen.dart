// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
//
// import 'package:ai_lab/controller/Authentication/logIn/log_in_provider.dart';
// import 'package:ai_lab/screens/Authentication/LogIn/bottom_hint.dart';
// import 'package:ai_lab/screens/Authentication/LogIn/build_background.dart';
// import 'package:ai_lab/screens/Authentication/LogIn/build_logo_section.dart';
// import 'package:ai_lab/screens/Authentication/LogIn/login_card.dart';
//
// class LoginScreen extends ConsumerWidget {
//   const LoginScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final size = MediaQuery.sizeOf(context);
//     final scale = size.width / 375;
//
//     final state = ref.watch(loginProvider);
//     final controller = ref.read(loginProvider.notifier);
//
//     ref.listen(loginProvider, (prev, next) {
//       if (next.loginSuccess) {
//         context.go('/home');
//       }
//     });
//
//     return Scaffold(
//       backgroundColor: const Color(0xFF111317),
//
//       body: Stack(
//         children: [
//           const BuildBackground(),
//
//           SafeArea(
//             child: SingleChildScrollView(
//               padding: EdgeInsets.symmetric(
//                 horizontal: 24 * scale,
//                 vertical: 40 * scale,
//               ),
//
//               child: Form(
//                 key: controller.formKey,
//                 autovalidateMode: AutovalidateMode.onUnfocus,
//
//                 child: Column(
//                   children: [
//                     SizedBox(height: 30 * scale),
//
//                     const BuildLogoSection(),
//
//                     SizedBox(height: 50 * scale),
//
//                     LoginCard(
//                       selectedType: state.selectedType,
//                       onTypeChanged: controller.changeType,
//
//                       emailController: controller.emailController,
//                       phoneController: controller.phoneController,
//                       passwordController: controller.passwordController,
//
//                       selectedCountryCode: state.countryCode,
//                       onCountryChanged: controller.changeCountry,
//
//                       isPasswordVisible: state.isPasswordVisible,
//                       onTogglePassword: controller.togglePassword,
//
//                       onLoginPressed: controller.login,
//                     ),
//
//                     SizedBox(height: 40 * scale),
//
//                     const BottomHint(),
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



import 'package:ai_lab/controller/Authentication/logIn/log_in_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ai_lab/controller/Authentication/logIn/log_in_provider.dart';
import 'package:ai_lab/screens/Authentication/LogIn/bottom_hint.dart';
import 'package:ai_lab/screens/Authentication/LogIn/build_background.dart';
import 'package:ai_lab/screens/Authentication/LogIn/build_logo_section.dart';
import 'package:ai_lab/screens/Authentication/LogIn/login_card.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final scale = size.width / 375;

    final state = ref.watch(loginProvider);
    final controller = ref.read(loginProvider.notifier);



    ref.listen(loginProvider, (prev, next) {
      print("====== LISTEN TRIGGERED ======");
      print("Previous status: ${prev?.status}");
      print("Next status: ${next.status}");
      print("==============================");

      if (next.status == LoginStatus.success) {
        print("→ Going to /home");
        context.go('/home');
      }

      if (next.status == LoginStatus.failure && next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFF111317),
      body: Stack(
        children: [
          const BuildBackground(),

          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 24 * scale,
                vertical: 40 * scale,
              ),
              child: Form(
                key: controller.formKey,
                autovalidateMode: AutovalidateMode.onUnfocus,
                child: Column(
                  children: [
                    SizedBox(height: 30 * scale),
                    const BuildLogoSection(),
                    SizedBox(height: 50 * scale),

                    LoginCard(
                      selectedType: state.selectedType,
                      onTypeChanged: controller.changeType,
                      emailController: controller.emailController,
                      phoneController: controller.phoneController,
                      passwordController: controller.passwordController,
                      selectedCountryCode: state.countryCode,
                      onCountryChanged: controller.changeCountry,
                      isPasswordVisible: state.isPasswordVisible,
                      onTogglePassword: controller.togglePassword,
                      onLoginPressed: controller.login,
                      isLoading: state.status == LoginStatus.loading, // ← أضف هذا
                    ),

                    SizedBox(height: 40 * scale),
                    const BottomHint(),
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