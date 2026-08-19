
import 'dart:io';


import 'package:ai_lab/core/constant/app_link_api.dart';
// import 'package:ai_lab/core/shared/my_cash_helper.dart';
import 'package:ai_lab/core/shared/my_cash_helper_with_getx.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static String token =
      CashHelper.getUserToken()! != "" ? CashHelper.getUserToken()! : "";
  CashHelper cashHelper = CashHelper();

  static init() {
    dio = Dio(
      BaseOptions(


        baseUrl: AppLinkApi.urlServer,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(milliseconds: 30000),
        receiveTimeout: const Duration(milliseconds: 30000),
      ),
    );
  }

  static Future<Response> myPost({
    required String endPont,
    required myData,
  }) async {
    return await dio.post(endPont,
        data: myData,
        options: Options(
            headers: {
              'Authorization': 'Bearer  $token',
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }));
  }



  static Future<Response> myGet({
    required String endPont,
    myData,
  }) async {


    return await dio.get(endPont,
        data: myData,
        options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }));
  }


  static Future<Response> myDelete({
    required String endPont,
    required myData,
  }) async {
    return await dio.delete(endPont,
        data: myData,
        options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }));
  }



  static Future<Response> updateProfile(
      {required String firstName,required String lastName, required File imageFile,required endPont}) async {
    if (!imageFile.existsSync()) {
      throw Exception('Image file does not exist.');
    }

    var formData = FormData.fromMap({
      'first_name': firstName,
      'last_name': lastName,
      'image': await MultipartFile.fromFile(imageFile.path,
          filename: imageFile.path.split('/').last), // Use correct file path
    });


    return  await dio.post(endPont,
        data: formData,
        options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Accept': 'application/json',
              'Content-Type': 'application/json',

            },
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }));


  }






}





