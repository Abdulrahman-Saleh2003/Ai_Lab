

import 'package:ai_lab/core/class/crud.dart';
import 'package:ai_lab/core/constant/app_link_api.dart';

class LoginData {
  final Crud crud;

  LoginData({
    required this.crud,
  });






  postData({
    // required String email,
    required String email,
    required String password,
  }) async {

     Map<String, dynamic>data={
    'password': password,
    'email': email,
    };
    var response = await crud.registerData(linkUrl: AppLinkApi.login, data: data);
    return response.fold((l) => l, (r) => r);
  }
}
