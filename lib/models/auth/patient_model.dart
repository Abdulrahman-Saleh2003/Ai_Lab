class LoginResponse {
  final Patient patient;
  final String refresh;
  final String access;
  final String message;

  LoginResponse({
    required this.patient,
    required this.refresh,
    required this.access,
    required this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      patient: Patient.fromJson(json['patient'] as Map<String, dynamic>),
      refresh: json['refresh'] as String,
      access: json['access'] as String,
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patient': patient.toJson(),
      'refresh': refresh,
      'access': access,
      'message': message,
    };
  }
}

class Patient {
  final String patientId;
  final User user;
  final String bloodType;
  final double height;
  final double bmi;
  final String createdAt;
  final String updatedAt;

  Patient({
    required this.patientId,
    required this.user,
    required this.bloodType,
    required this.height,
    required this.bmi,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      patientId: json['patient_id'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      bloodType: json['blood_type'] as String,
      height: (json['height'] as num).toDouble(),
      bmi: (json['bmi'] as num).toDouble(),
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patient_id': patientId,
      'user': user.toJson(),
      'blood_type': bloodType,
      'height': height,
      'bmi': bmi,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class User {
  final String id;
  final String email;
  final String name;
  final String role;
  final String gender;
  final String birthDate;
  final String phone;
  final String createdAt;
  final String lastLogin;
  final String randomCode;
  final String nationalId;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.gender,
    required this.birthDate,
    required this.phone,
    required this.createdAt,
    required this.lastLogin,
    required this.randomCode,
    required this.nationalId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
      gender: json['gender'] as String,
      birthDate: json['birth_date'] as String,
      phone: json['phone'] as String,
      createdAt: json['created_at'] as String,
      lastLogin: json['last_login'] as String,
      randomCode: json['random_code'] as String,
      nationalId: json['national_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role,
      'gender': gender,
      'birth_date': birthDate,
      'phone': phone,
      'created_at': createdAt,
      'last_login': lastLogin,
      'random_code': randomCode,
      'national_id': nationalId,
    };
  }
}