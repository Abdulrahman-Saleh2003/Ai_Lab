

import 'package:ai_lab/core/class/crud.dart';
import 'package:ai_lab/core/constant/app_link_api.dart';












import 'package:ai_lab/core/class/crud.dart';
import 'package:ai_lab/core/constant/app_link_api.dart';

class SignUpData {
  final Crud crud;

  SignUpData({required this.crud});

  Future postData({
    required String email,
    required String password,
    required String password2,
    required String name,
    required String gender,
    required String birthDate,
    required String phone,
    required String nationalId,
    required String bloodType,
    required double height,
    required double weight,
  }) async {
    final data = {
      'email': email,
      'password': password,
      'password2': password2,
      'name': name,
      'gender': gender,
      'birth_date': birthDate,
      'phone': phone,
      'national_id': nationalId,
      'blood_type': bloodType,
      'height': height,
      'weight': weight,
    };

    // رجّع الـ Either كما هو (ما تعمل fold هنا)
    return await crud.registerData(
      linkUrl: AppLinkApi.register,
      data: data,
    );
  }
}
