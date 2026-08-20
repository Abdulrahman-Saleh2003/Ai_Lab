enum RegisterStatus { initial, loading, success, failure }

class PatientRegistrationState {
  final RegisterStatus status;
  final String? errorMessage;

  final String selectedGender;
  final String bloodType;
  final double height;
  final double weight;
  final bool isPasswordVisible;
  final String countryCode;

  const PatientRegistrationState({
    this.status = RegisterStatus.initial,
    this.errorMessage,
    this.selectedGender = 'Male',
    this.bloodType = 'O+',
    this.height = 170.0,
    this.weight = 70.0,
    this.isPasswordVisible = false,
    this.countryCode = '+966',
  });

  PatientRegistrationState copyWith({
    RegisterStatus? status,
    String? errorMessage,
    String? selectedGender,
    String? bloodType,
    double? height,
    double? weight,
    bool? isPasswordVisible,
    String? countryCode,
  }) {
    return PatientRegistrationState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      selectedGender: selectedGender ?? this.selectedGender,
      bloodType: bloodType ?? this.bloodType,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      countryCode: countryCode ?? this.countryCode,
    );
  }
}
