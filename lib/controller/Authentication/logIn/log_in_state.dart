

enum LoginStatus {
  initial,
  loading,
  success,
  failure,
}

class LoginState {
  final String selectedType;
  final String countryCode;
  final bool isPasswordVisible;
  final LoginStatus status;
  final String? errorMessage; // رسالة الخطأ في حال الفشل

  const LoginState({
    this.selectedType = 'email',
    this.countryCode = '+966',
    this.isPasswordVisible = true,
    this.status = LoginStatus.initial,
    this.errorMessage,
  });

  LoginState copyWith({
    String? selectedType,
    String? countryCode,
    bool? isPasswordVisible,
    LoginStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      selectedType: selectedType ?? this.selectedType,
      countryCode: countryCode ?? this.countryCode,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}