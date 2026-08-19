//
// import 'package:ai_lab/controller/Authentication/sign_up/signup_state.dart';
// import 'package:ai_lab/core/providers/app_providers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
//
// class PatientRegistrationController extends Notifier<PatientRegistrationState> {
//   final formKey = GlobalKey<FormState>();
//
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController nationalIdController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   String countryCode = '+966';
//   bool isPasswordVisible = false;
//
//   @override
//   PatientRegistrationState build() {
//     ref.onDispose(() {
//       phoneController.dispose();
//       emailController.dispose();
//       nationalIdController.dispose();
//       passwordController.dispose();
//     });
//
//     return const PatientRegistrationState();
//   }
//
//   void changeGender(String gender) {
//     state = state.copyWith(selectedGender: gender);
//   }
//
//   void changeWeight(double newWeight) {
//     state = state.copyWith(weight: newWeight);
//   }
//
//   void togglePasswordVisibility() {
//     isPasswordVisible = !isPasswordVisible;
//     ref.notifyListeners();
//   }
//
//   void changeCountryCode(String code) {
//     countryCode = code;
//     ref.notifyListeners();
//   }
//
//   // void goToHome(BuildContext context){
//   //   context.go('/home');
//   //   // context.go('/HomeScreen');
//   //
//   //
//   // }
//
//   // ✅ الحل الصح
//   Future<void> goToHome(BuildContext context) async {
//     // 1. احفظ التوكن في Riverpod أولاً
//     await ref.read(authProvider.notifier).saveToken('user_token_here');
//
//     // 2. بعدين GoRouter بيحول تلقائياً للـ /home
//     // مش محتاج context.go لأن الـ redirect بيشتغل لحاله!
//   }
//   Future<void> register(BuildContext context) async {
//     if (!formKey.currentState!.validate()) return;
//
//     state = state.copyWith(isLoading: true);
//
//     // محاكاة API
//     await Future.delayed(const Duration(seconds: 2));
//
//     state = state.copyWith(
//       isLoading: false,
//       registrationSuccess: true,
//     );
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Node Initialized Successfully')),
//     );
//
//     // يمكنك التنقل هنا
//     // context.go('/home');
//   }
// }


import 'package:ai_lab/controller/Authentication/sign_up/sign_up_provider.dart';
import 'package:ai_lab/controller/Authentication/sign_up/signup_state.dart';
import 'package:ai_lab/core/providers/app_providers.dart';
import 'package:ai_lab/core/shared/my_cash_helper_with_getx.dart';
import 'package:ai_lab/data/remote/auth/sign_up_data.dart'; // تأكد من المسار
import 'package:ai_lab/models/auth/patient_model.dart'; // نفس موديل اللوجين
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
    // state = state.copyWith(selectedGender: gender.toLowerCase());
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
          print("Register failed: $statusRequest");
        },
            (responseData) {
          print("======= REGISTER SUCCESS =======");
          print(responseData);
          print("================================");

          // الباك برجع رسالة فقط، مش tokens
          state = state.copyWith(
            status: RegisterStatus.success,
            errorMessage: null,
          );
        },
      );
    } catch (e) {
      print("Register Exception: $e");

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
  Future<void> register1() async {
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

        birthDate: birthDateController.text.trim(), // مثال: 1995-05-15
        phone: phoneController.text.trim(),
        nationalId: nationalIdController.text.trim(),
        bloodType: state.bloodType,
        height: state.height,
        weight: state.weight,
      );

      print("======= REGISTER RESPONSE =======");
      print(response.data);
      print("Status Code: ${response.statusCode}");
      print("=================================");

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          // إذا الباك برجع نفس شكل اللوجين (patient + tokens)
          final loginResponse = LoginResponse.fromJson(response.data);

          // حفظ التوكنات
          await CashHelper.putString(
            key: 'access_token',
            value: loginResponse.access,
          );
          await CashHelper.putString(
            key: 'refresh_token',
            value: loginResponse.refresh,
          );

          await CashHelper.putUserEmail(email: loginResponse.patient.user.email);
          await CashHelper.putUserName(name: loginResponse.patient.user.name);
          await CashHelper.putUserPhone(mobile: loginResponse.patient.user.phone);

          // تحديث حالة الـ Auth
          await ref.read(authProvider.notifier).saveToken(loginResponse.access);

          state = state.copyWith(
            status: RegisterStatus.success,
            errorMessage: null,
          );

          print("Register Success → Tokens saved + Auth updated");
        } catch (e) {
          // لو الباك ما برجع tokens (بس رسالة نجاح)
          state = state.copyWith(
            status: RegisterStatus.success,
            errorMessage: null,
          );
          print("Register Success (no tokens): $e");
        }
      } else {
        state = state.copyWith(
          status: RegisterStatus.failure,
          errorMessage: "فشل التسجيل (${response.statusCode})",
        );
      }
    } catch (e) {
      print("Register Exception: $e");

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