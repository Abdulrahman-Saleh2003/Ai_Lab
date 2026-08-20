import 'package:ai_lab/controller/Authentication/sign_up/sign_up_provider.dart';
import 'package:ai_lab/controller/Authentication/sign_up/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientRegistrationController extends Notifier<PatientRegistrationState> {
  final formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  @override
  PatientRegistrationState build() {
    ref.onDispose(() {
      nameController.dispose();
      emailController.dispose();
      phoneController.dispose();
      nationalIdController.dispose();
      passwordController.dispose();
      confirmPasswordController.dispose();
      birthDateController.dispose();
    });

    return const PatientRegistrationState();
  }

  // ─── Helpers ───
  void changeGender(String gender) {
    state = state.copyWith(selectedGender: gender);
  }

  void changeBloodType(String type) {
    state = state.copyWith(bloodType: type);
  }

  void changeHeight(double value) {
    state = state.copyWith(height: value);
  }

  void changeWeight(double value) {
    state = state.copyWith(weight: value);
  }

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  void changeCountryCode(String code) {
    state = state.copyWith(countryCode: code);
  }

  // ─── Register ───
  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;

    state = state.copyWith(
      status: RegisterStatus.loading,
      errorMessage: null,
    );

    try {
      final signUpData = ref.read(registerDataProvider);

      final response = await signUpData.postData(
        email: emailController.text.trim(),
        password: passwordController.text,
        password2: confirmPasswordController.text,
        name: nameController.text.trim(),
        gender: state.selectedGender.toLowerCase(),
        birthDate: birthDateController.text.trim(),
        phone: phoneController.text.trim(),
        nationalId: nationalIdController.text.trim(),
        bloodType: state.bloodType,
        height: state.height,
        weight: state.weight,
      );

      response.fold(
        (statusRequest) {
          state = state.copyWith(
            status: RegisterStatus.failure,
            errorMessage: statusRequest.toString(),
          );
        },
        (responseData) {
          state = state.copyWith(
            status: RegisterStatus.success,
            errorMessage: null,
          );
        },
      );
    } catch (e) {
      String message = "حدث خطأ غير متوقع";
      if (e.toString().contains("connection timeout") ||
          e.toString().contains("connectTimeout")) {
        message = "انتهت مهلة الاتصال بالسيرفر";
      } else if (e.toString().contains("SocketException") ||
          e.toString().contains("Failed host lookup")) {
        message = "لا يوجد اتصال بالإنترنت";
      } else if (e.toString().contains("DioException")) {
        message = "فشل الاتصال بالسيرفر";
      }

      state = state.copyWith(
        status: RegisterStatus.failure,
        errorMessage: message,
      );
    }
  }
}