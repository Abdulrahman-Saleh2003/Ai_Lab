import 'dart:io';
import 'package:ai_lab/core/constant/app_link_api.dart';
import 'package:ai_lab/core/shared/cache_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioHelper {
  static late Dio dio;
  static String get token => CacheHelper.getUserToken() ?? "";

  static Future<void> updateToken(String newToken) async {
    await CacheHelper.putUser(userToken: newToken);
    if (kDebugMode) {
      debugPrint("Token updated in DioHelper: $newToken");
    }
  }

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppLinkApi.urlServer,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(minutes: 5, milliseconds: 45000),
        receiveTimeout: const Duration(minutes: 5, milliseconds: 45000),
      ),
    );
  }

  static Future<Response> myPost({
    required String endPont,
    required dynamic myData,
    bool isFormData = false,
  }) async {
    final dynamic dataToSend = (isFormData && myData is Map<String, dynamic>)
        ? FormData.fromMap(myData)
        : myData;

    final response = await dio.post(
      endPont,
      data: dataToSend,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          if (!isFormData) 'Content-Type': 'application/json',
        },
        followRedirects: false,
        validateStatus: (status) => status != null && status < 500,
      ),
    );
    return response;
  }

  static Future<Response> register({
    required String endPont,
    required dynamic myData,
  }) async {
    final formData = myData is Map<String, dynamic>
        ? FormData.fromMap(myData)
        : myData;
    final response = await dio.post(
      endPont,
      data: formData,
      options: Options(
        headers: {
          'Accept': 'application/json',
        },
        followRedirects: false,
        validateStatus: (status) => status != null && status < 500,
      ),
    );
    return response;
  }

  static Future<Response> register1({
    required String endPont,
    required dynamic myData,
  }) async {
    return await dio.post(
      endPont,
      data: myData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        followRedirects: false,
        validateStatus: (status) => status != null && status < 500,
      ),
    );
  }

  static Future<Response> myGet({
    required String endPont,
    dynamic myData,
  }) async {
    return await dio.get(
      endPont,
      data: myData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        followRedirects: false,
        validateStatus: (status) => status != null && status < 500,
      ),
    );
  }

  static Future<Response> myDelete({
    required String endPont,
    required dynamic myData,
  }) async {
    return await dio.delete(
      endPont,
      data: myData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        followRedirects: false,
        validateStatus: (status) => status != null && status < 500,
      ),
    );
  }

  static Future<Response> updateProfile({
    required String firstName,
    required String lastName,
    required File imageFile,
    required String endPont,
  }) async {
    if (!imageFile.existsSync()) {
      throw Exception('Image file does not exist.');
    }

    final formData = FormData.fromMap({
      'first_name': firstName,
      'last_name': lastName,
      'image': await MultipartFile.fromFile(
        imageFile.path,
        filename: imageFile.path.split('/').last,
      ),
    });

    return await dio.post(
      endPont,
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        followRedirects: false,
        validateStatus: (status) => status != null && status < 500,
      ),
    );
  }

  static Future<Response> postRequestWithImageOne({
    required Map<String, dynamic> data,
    required String linkUrl,
    required File? image,
  }) async {
    final formData = FormData.fromMap({
      ...data,
      if (image != null)
        "photo": await MultipartFile.fromFile(
          image.path,
          filename: image.path.split("/").last,
        ),
    });

    final response = await dio.post(
      linkUrl,
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          "Content-Type": "multipart/form-data",
        },
        followRedirects: false,
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    return response;
  }
}
