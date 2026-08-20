import 'package:ai_lab/controller/Authentication/sign_up/sign_up_provider.dart';
import 'package:ai_lab/controller/Authentication/sign_up/signup_state.dart';
import 'package:ai_lab/core/constant/app_size.dart';
import 'package:ai_lab/screens/Authentication/SignUp/blood_type_field.dart';
import 'package:ai_lab/screens/Authentication/SignUp/build_height_slider.dart';
import 'package:ai_lab/screens/Authentication/SignUp/build_header.dart';
import 'package:ai_lab/screens/Authentication/SignUp/build_weight_slider.dart';
import 'package:ai_lab/screens/Authentication/SignUp/custom_input_field.dart';
import 'package:ai_lab/screens/Authentication/SignUp/gender_selection_field.dart';
import 'package:ai_lab/screens/Authentication/SignUp/initialize_button.dart';
import 'package:ai_lab/screens/Authentication/SignUp/sign_up_to_login_link.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PatientRegistrationScreen extends ConsumerWidget {
  const PatientRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scale = AppSize.scale(context);

    final state = ref.watch(patientRegistrationProvider);
    final controller = ref.read(patientRegistrationProvider.notifier);

    // الاستماع للحالة
    ref.listen(patientRegistrationProvider, (prev, next) {
      if (next.status == RegisterStatus.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('account_created_success'.tr()),
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
                    const Color(0xFF00D2FF).withValues(alpha: 0.12),
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
                    const Color(0xFFEDB1FF).withValues(alpha: 0.10),
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
                      "initialize_node_title".tr(),
                      style: TextStyle(
                        fontFamily: 'SpaceGrotesk',
                        fontSize: 32 * scale,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1 * scale,
                      ),
                    ),

                    SizedBox(height: 8 * scale),

                    Text(
                      "sync_bio_profile_desc".tr(),
                      style: TextStyle(
                        fontSize: 14 * scale,
                        color: Colors.grey,
                        height: 1.5,
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
                          color: Colors.white.withValues(alpha: 0.08),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.4),
                            blurRadius: 30 * scale,
                            offset: Offset(0, 10 * scale),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Name
                          CustomInputField(
                            label: "full_name".tr(),
                            hint: "Yamen Almoghrabi",
                            icon: Icons.person_outline,
                            inputType: InputType.text,
                            controller: controller.nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'name_required'.tr();
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 24 * scale),

                          // Phone
                          CustomInputField(
                            label: "patient_phone_number".tr(),
                            hint: "000-000-0000",
                            icon: Icons.phone,
                            inputType: InputType.phone,
                            controller: controller.phoneController,
                            selectedCountryCode: state.countryCode,
                            onCountryChanged: controller.changeCountryCode,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'phone_required'.tr();
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 24 * scale),

                          // Email
                          CustomInputField(
                            label: "patient_email".tr(),
                            hint: "synapse@labsync.io",
                            icon: Icons.email_outlined,
                            inputType: InputType.email,
                            controller: controller.emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'email_required'.tr();
                              }
                              if (!value.contains('@')) {
                                return 'invalid_email'.tr();
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 24 * scale),

                          // National ID
                          CustomInputField(
                            label: "national_id".tr(),
                            hint: "ID-XXXX-XXXX",
                            icon: Icons.badge_outlined,
                            inputType: InputType.nationalId,
                            controller: controller.nationalIdController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'national_id_required'.tr();
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 24 * scale),

                          // Birth Date
                          CustomInputField(
                            label: "birth_date".tr(),
                            hint: "1995-05-15",
                            icon: Icons.calendar_today_outlined,
                            inputType: InputType.text,
                            controller: controller.birthDateController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'birth_date_required'.tr();
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 24 * scale),

                          // Password
                          CustomInputField(
                            label: "access_cipher".tr(),
                            hint: "••••••••••••",
                            icon: Icons.lock_outline,
                            inputType: InputType.password,
                            controller: controller.passwordController,
                            isPasswordVisible: state.isPasswordVisible,
                            onTogglePassword: controller.togglePasswordVisibility,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'password_required'.tr();
                              }
                              if (value.length < 6) {
                                return 'password_too_short'.tr();
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 24 * scale),

                          // Confirm Password
                          CustomInputField(
                            label: "confirm_password".tr(),
                            hint: "••••••••••••",
                            icon: Icons.lock_outline,
                            inputType: InputType.password,
                            controller: controller.confirmPasswordController,
                            isPasswordVisible: state.isPasswordVisible,
                            onTogglePassword: controller.togglePasswordVisibility,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'confirm_password_required'.tr();
                              }
                              if (value != controller.passwordController.text) {
                                return 'passwords_dont_match'.tr();
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

                    GestureDetector(
                      onTap: () => context.go('/login'),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 14 * scale,
                              color: Colors.grey,
                            ),
                            children: [
                              TextSpan(text: "existing_node_detected".tr()),
                              TextSpan(
                                text: "access_terminal".tr(),
                                style: const TextStyle(
                                  color: Color(0xFFEDB1FF),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
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