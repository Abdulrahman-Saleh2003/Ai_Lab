// import 'package:ai_lab/OnBoarding/View/widget.dart';
// import 'package:ai_lab/controller/Authentication/sign_up/sign_up_provider.dart';
// import 'package:ai_lab/screens/Authentication/SignUp/build_header.dart';
// import 'package:ai_lab/screens/Authentication/SignUp/build_weight_slider.dart';
// import 'package:ai_lab/screens/Authentication/SignUp/custom_input_field.dart';
// import 'package:ai_lab/screens/Authentication/SignUp/gender_selection_field.dart';
// import 'package:ai_lab/screens/Authentication/SignUp/initialize_button.dart';
// import 'package:ai_lab/screens/Authentication/SignUp/sign_up_to_login_link.dart';
// import 'package:flutter/material.dart';
//
// class PatientRegistrationScreen extends ConsumerWidget {
//   const PatientRegistrationScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final size = MediaQuery.sizeOf(context);
//
//     final state = ref.watch(patientRegistrationProvider);
//     final controller = ref.read(patientRegistrationProvider.notifier);
//
//     return Scaffold(
//       backgroundColor: const Color(0xFF111317),
//
//       body: Stack(
//         children: [
//           // Background Glows
//           Positioned(
//             top: -150 * (size.width / 375),
//             right: -100 * (size.width / 375),
//             child: Container(
//               width: 500 * (size.width / 375),
//               height: 500 * (size.width / 375),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: RadialGradient(
//                   colors: [
//                     const Color(0xFF00D2FF).withOpacity(0.12),
//                     Colors.transparent
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//           Positioned(
//             bottom: -150 * (size.width / 375),
//             left: -100 * (size.width / 375),
//             child: Container(
//               width: 500 * (size.width / 375),
//               height: 500 * (size.width / 375),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: RadialGradient(
//                   colors: [
//                     const Color(0xFFEDB1FF).withOpacity(0.10),
//                     Colors.transparent
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//           SafeArea(
//             child: SingleChildScrollView(
//               padding: EdgeInsets.fromLTRB(
//                 20 * (size.width / 375),
//                 20 * (size.width / 375),
//                 20 * (size.width / 375),
//                 40 * (size.width / 375),
//               ),
//
//               child: Form(
//                 key: controller.formKey,
//
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const RegistrationHeader(),
//
//                     SizedBox(height: 40 * (size.width / 375)),
//
//                     Text(
//                       "INITIALIZE",
//                       style: TextStyle(
//                         fontFamily: 'SpaceGrotesk',
//                         fontSize: 38 * (size.width / 375),
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         letterSpacing: 1 * (size.width / 375),
//                       ),
//                     ),
//
//                     Text(
//                       "NODE",
//                       style: TextStyle(
//                         fontFamily: 'SpaceGrotesk',
//                         fontSize: 42 * (size.width / 375),
//                         fontWeight: FontWeight.bold,
//                         color: const Color(0xFF00D2FF),
//                         letterSpacing: 2 * (size.width / 375),
//                       ),
//                     ),
//
//                     SizedBox(height: 8 * (size.width / 375)),
//
//                     Text(
//                       "Synchronize your biological profile with our distributed clinical laboratory network.",
//                       style: TextStyle(
//                         fontSize: 15 * (size.width / 375),
//                         color: Colors.grey,
//                         height: 1.5,
//                       ),
//                     ),
//
//                     SizedBox(height: 40 * (size.width / 375)),
//
//                     // Form Card
//                     Container(
//                       padding: EdgeInsets.all(28 * (size.width / 375)),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFF1A1C1F),
//                         borderRadius: BorderRadius.circular(
//                           24 * (size.width / 375),
//                         ),
//                         border: Border.all(
//                           color: Colors.white.withOpacity(0.08),
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.4),
//                             blurRadius: 30 * (size.width / 375),
//                             offset: Offset(
//                               0,
//                               10 * (size.width / 375),
//                             ),
//                           ),
//                         ],
//                       ),
//
//                       child: Column(
//                         children: [
//                           CustomInputField(
//                             label: "Patient Phone Number",
//                             hint: "000-000-0000",
//                             icon: Icons.phone,
//                             inputType: InputType.phone,
//                             controller: controller.phoneController,
//                             selectedCountryCode: controller.countryCode,
//                             onCountryChanged: controller.changeCountryCode,
//                           ),
//
//                           SizedBox(height: 24 * (size.width / 375)),
//
//                           CustomInputField(
//                             label: "Patient Email",
//                             hint: "synapse@labsync.io",
//                             icon: Icons.email_outlined,
//                             inputType: InputType.email,
//                             controller: controller.emailController,
//                             validator: (value) =>
//                             value?.isEmpty == true
//                                 ? 'Email is required'
//                                 : null,
//                           ),
//
//                           SizedBox(height: 24 * (size.width / 375)),
//
//                           CustomInputField(
//                             label: "National ID",
//                             hint: "ID-XXXX-XXXX",
//                             icon: Icons.badge_outlined,
//                             inputType: InputType.nationalId,
//                             controller: controller.nationalIdController,
//                           ),
//
//                           SizedBox(height: 24 * (size.width / 375)),
//
//                           CustomInputField(
//                             label: "Access Cipher",
//                             hint: "••••••••••••",
//                             icon: Icons.lock_outline,
//                             inputType: InputType.password,
//                             controller: controller.passwordController,
//                             isPasswordVisible: controller.isPasswordVisible,
//                             onTogglePassword:
//                             controller.togglePasswordVisibility,
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Password is required';
//                               }
//                               if (value.length < 6) {
//                                 return 'Minimum 6 characters';
//                               }
//                               return null;
//                             },
//                           ),
//
//                           SizedBox(height: 24 * (size.width / 375)),
//
//                           GenderSelectionField(
//                             selectedGender: state.selectedGender,
//                             onChanged: controller.changeGender,
//                           ),
//
//                           SizedBox(height: 32 * (size.width / 375)),
//
//                           WeightSlider(
//                             weight: state.weight,
//                             onChanged: controller.changeWeight,
//                           ),
//
//                           SizedBox(height: 40 * (size.width / 375)),
//
//                           InitializeButton(
//                             onPressed: () =>
//                                 controller.goToHome(context),
//                             isLoading: state.isLoading,
//                           ),
//
//                           SizedBox(height: 20 * (size.width / 375)),
//
//                           LoginRedirectText(),
//                         ],
//                       ),
//                     ),
//
//                     SizedBox(height: 40 * (size.width / 375)),
//
//                     Center(
//                       child: RichText(
//                         text: TextSpan(
//                           style: TextStyle(
//                             fontSize: 14 * (size.width / 375),
//                             color: Colors.grey,
//                           ),
//                           children: const [
//                             TextSpan(text: "Existing node detected? "),
//                             TextSpan(
//                               text: "Access Terminal",
//                               style: TextStyle(
//                                 color: Color(0xFFEDB1FF),
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
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


import 'package:ai_lab/controller/Authentication/sign_up/sign_up_provider.dart';
import 'package:ai_lab/controller/Authentication/sign_up/signup_state.dart';
import 'package:ai_lab/screens/Authentication/SignUp/blood%E2%80%8E_type_field.dart';
import 'package:ai_lab/screens/Authentication/SignUp/build%E2%80%8E_height_slider.dart';
import 'package:ai_lab/screens/Authentication/SignUp/build_header.dart';
import 'package:ai_lab/screens/Authentication/SignUp/build_weight_slider.dart';
import 'package:ai_lab/screens/Authentication/SignUp/custom_input_field.dart';
import 'package:ai_lab/screens/Authentication/SignUp/gender_selection_field.dart';
import 'package:ai_lab/screens/Authentication/SignUp/initialize_button.dart';
import 'package:ai_lab/screens/Authentication/SignUp/sign_up_to_login_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PatientRegistrationScreen extends ConsumerWidget {
  const PatientRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final scale = size.width / 375;

    final state = ref.watch(patientRegistrationProvider);
    final controller = ref.read(patientRegistrationProvider.notifier);

    // الاستماع للحالة
    ref.listen(patientRegistrationProvider, (prev, next) {
      if (next.status == RegisterStatus.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم إنشاء الحساب بنجاح، سجّل دخولك الآن'),
            backgroundColor: Colors.green,
          ),
        );
        context.go('/login');
      }

      if (next.status == RegisterStatus.failure && next.errorMessage != null) {
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
          // Background Glows
          Positioned(
            top: -150 * scale,
            right: -100 * scale,
            child: Container(
              width: 500 * scale,
              height: 500 * scale,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF00D2FF).withOpacity(0.12),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -150 * scale,
            left: -100 * scale,
            child: Container(
              width: 500 * scale,
              height: 500 * scale,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFEDB1FF).withOpacity(0.10),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                20 * scale,
                20 * scale,
                20 * scale,
                40 * scale,
              ),
              child: Form(
                key: controller.formKey,
                autovalidateMode: AutovalidateMode.onUnfocus,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const RegistrationHeader(),

                    SizedBox(height: 40 * scale),
                Text(
                      "INITIALIZE",
      style: TextStyle(
                        fontFamily: 'SpaceGrotesk',
                        fontSize: 38 * scale,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1 * scale,
                      ),
                    ),

                    Text(
                      "NODE",
                      style: TextStyle(
                        fontFamily: 'SpaceGrotesk',
                        fontSize: 42 * scale,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF00D2FF),
                        letterSpacing: 2 * scale,
                      ),
                    ),

                    SizedBox(height: 8 * scale),

                    Text(
                      "Synchronize your biological profile with our distributed clinical laboratory network.",
                      style: TextStyle(
                        fontSize: 15 * scale,
                        color: Colors.grey,
                        height: 1.5,
                      ),
                    ),

                Text(
                  "INITIALIZE",

                  style: TextStyle(
                        fontFamily: 'SpaceGrotesk',
                        fontSize: 38 * (size.width / 375),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1 * (size.width / 375),
                      ),
                    ),

                  SizedBox(height: 40 * scale),

                    // Form Card
                    Container(
                      padding: EdgeInsets.all(28 * scale),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1C1F),
                        borderRadius: BorderRadius.circular(24 * scale),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.08),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 30 * scale,
                            offset: Offset(0, 10 * scale),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Name
                          CustomInputField(
                            label: "Full Name",
                            hint: "Yamen Almoghrabi",
                            icon: Icons.person_outline,
                            inputType: InputType.text,
                            controller: controller.nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Name is required';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 24 * scale),

                          // Phone
                          CustomInputField(
                            label: "Patient Phone Number",
                            hint: "000-000-0000",
                            icon: Icons.phone,
                            inputType: InputType.phone,
                            controller: controller.phoneController,
                            selectedCountryCode: state.countryCode,
                            onCountryChanged: controller.changeCountryCode,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Phone is required';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 24 * scale),

                          // Email
                          CustomInputField(
                            label: "Patient Email",
                            hint: "synapse@labsync.io",
                            icon: Icons.email_outlined,
                            inputType: InputType.email,
                            controller: controller.emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              }
                              if (!value.contains('@')) {
                                return 'Invalid email';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 24 * scale),

                          // National ID
                          CustomInputField(
                            label: "National ID",
                            hint: "ID-XXXX-XXXX",
                            icon: Icons.badge_outlined,
                            inputType: InputType.nationalId,
                            controller: controller.nationalIdController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'National ID is required';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 24 * scale),

                          // Birth Date
                          CustomInputField(
                            label: "Birth Date",
                            hint: "1995-05-15",
                            icon: Icons.calendar_today_outlined,
                            inputType: InputType.text,
                            controller: controller.birthDateController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Birth date is required';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 24 * scale),

                          // Password
                          CustomInputField(
                            label: "Access Cipher",
                            hint: "••••••••••••",
                            icon: Icons.lock_outline,
                            inputType: InputType.password,
                            controller: controller.passwordController,
                            isPasswordVisible: state.isPasswordVisible,
                            onTogglePassword: controller.togglePasswordVisibility,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              if (value.length < 6) {
                                return 'Minimum 6 characters';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 24 * scale),

                          // Confirm Password
                          CustomInputField(
                            label: "Confirm Access Cipher",
                            hint: "••••••••••••",
                            icon: Icons.lock_outline,
                            inputType: InputType.password,
                            controller: controller.confirmPasswordController,
                            isPasswordVisible: state.isPasswordVisible,
                            onTogglePassword: controller.togglePasswordVisibility,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Confirm password is required';
                              }
                              if (value != controller.passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 24 * scale),

                          // Gender
                          GenderSelectionField(
                            selectedGender: state.selectedGender,
                            onChanged: controller.changeGender,
                          ),



                          SizedBox(height: 32 * scale),

                          BloodTypeField(
                            selectedBloodType: state.bloodType,
                            onChanged: controller.changeBloodType,
                          ),

                          SizedBox(height: 32 * scale),

// Height
                          HeightSlider(
                            height: state.height,
                            onChanged: controller.changeHeight,
                          ),

                          SizedBox(height: 24 * scale),

                          // Weight
                          WeightSlider(
                            weight: state.weight,
                            onChanged: controller.changeWeight,
                          ),

                          SizedBox(height: 40 * scale),

                          // Register Button
                          InitializeButton(
                            onPressed: state.status == RegisterStatus.loading
                                ? null
                                : () => controller.register(),
                            isLoading: state.status == RegisterStatus.loading,
                          ),

                          SizedBox(height: 20 * scale),

                          const LoginRedirectText(),
                        ],
                      ),
                    ),

                    SizedBox(height: 40 * scale),

                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 14 * scale,
                            color: Colors.grey,
                          ),
                          children: const [
                            TextSpan(text: "Existing node detected? "),
                            TextSpan(
                              text: "Access Terminal",
                              style: TextStyle(
                                color: Color(0xFFEDB1FF),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
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