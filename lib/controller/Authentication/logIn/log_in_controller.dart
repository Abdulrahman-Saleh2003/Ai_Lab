import 'package:ai_lab/controller/Authentication/logIn/log_in_provider.dart';
import 'package:ai_lab/core/class/crud.dart';
import 'package:ai_lab/core/providers/app_providers.dart';
import 'package:ai_lab/core/shared/cache_helper.dart';
import 'package:ai_lab/data/remote/auth/login_auth.dart';
import 'package:ai_lab/models/auth/patient_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'log_in_state.dart';

class LoginController extends Notifier<LoginState> {
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController passwordController;

  final formKey = GlobalKey<FormState>();
  final loginData = LoginData(crud: Crud());

  @override
  LoginState build() {
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();

    ref.onDispose(() {
      emailController.dispose();
      phoneController.dispose();
      passwordController.dispose();
    });

    return const LoginState();
  }

  void changeType(String type) {
    state = state.copyWith(selectedType: type);
  }

  void changeCountry(String code) {
    state = state.copyWith(countryCode: code);
  }

  void togglePassword() {
    state = state.copyWith(
      isPasswordVisible: !state.isPasswordVisible,
    );
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    state = state.copyWith(
      status: LoginStatus.loading,
      errorMessage: null,
    );

    try {
      final loginData = ref.read(loginDataProvider);

      final response = await loginData.postData(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          final loginResponse = LoginResponse.fromJson(response.data);

          // 1. حفظ التوكنات
          await CacheHelper.putString(
            key: 'access_token',
            value: loginResponse.access,
          );
          await CacheHelper.putString(
            key: 'refresh_token',
            value: loginResponse.refresh,
          );

          // 2. حفظ بيانات المستخدم
          await CacheHelper.putUserEmail(email: loginResponse.patient.user.email);
          await CacheHelper.putUserName(name: loginResponse.patient.user.name);
          await CacheHelper.putUserPhone(phone: loginResponse.patient.user.phone);

          // 3. تحديث حالة الـ Auth
          await ref.read(authProvider.notifier).saveToken(loginResponse.access);

          // 4. تحديث حالة تسجيل الدخول
          state = state.copyWith(
            status: LoginStatus.success,
            errorMessage: null,
          );
        } catch (e) {
          state = state.copyWith(
            status: LoginStatus.failure,
            errorMessage: "خطأ في معالجة البيانات",
          );
        }
      } else {
        state = state.copyWith(
          status: LoginStatus.failure,
          errorMessage: "فشل تسجيل الدخول (${response.statusCode})",
        );
      }
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
        status: LoginStatus.failure,
        errorMessage: message,
      );
    }
  }
}
