

import 'package:ai_lab/core/class/crud.dart';

class ForgotPasswordData {
  final Crud crud;

  ForgotPasswordData({
    required this.crud,
  });

  postData({

    required   Map<String, dynamic>postData,
    required String linkUrl
  }) async {

    Map<String, dynamic>data=postData;
    var response = await crud.registerData(linkUrl:linkUrl, data: data);
    return response.fold((l) => l, (r) => r);
  }
}
