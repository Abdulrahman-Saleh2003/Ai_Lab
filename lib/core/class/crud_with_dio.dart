import 'dart:io';


import 'package:ai_lab/core/constant/app_link_api.dart';
// import 'package:ai_lab/core/shared/my_cash_helper.dart';
import 'package:ai_lab/core/shared/my_cash_helper_with_getx.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  // static String token = CashHelper.getUserToken() ??"";
  static String get token => CashHelper.getUserToken() ?? "";


  CashHelper cashHelper = CashHelper();
  static void updateToken(String newToken) async{
    await CashHelper.putUser(userToken: newToken);

    print("Token updated in DioHelper: $newToken");
  }
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppLinkApi.urlServer,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(milliseconds: 45000),
        receiveTimeout: const Duration(milliseconds: 45000),
        // connectTimeout: const Duration(milliseconds: 20000),
        // receiveTimeout: const Duration(milliseconds: 20000),
      ),
    );
  }

  static Future<Response> myPost({
    required String endPont,
    required myData,
  }) async {
    //
    // print("myPost");
    // print('token is: $token');
    //
    // print(AppLinkApi.urlServer +"${endPont}");

    FormData formData = FormData.fromMap(myData);
    dynamic rul=await dio.post(endPont,
        data: formData,
        options: Options(
            headers: {'Authorization': 'Bearer $token',

        'Accept': 'application/json',
              // 'Content-Type': 'application/json',
            },
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }));
    print("rul is: ${rul.toString()}");

    return  rul;
  }



  static Future<Response> register({
    required String endPont,
    required myData,
  }) async {

    print("myPost");
    print('token is: $token');

    print(AppLinkApi.urlServer +"$endPont");

    FormData formData = FormData.fromMap(myData);
    dynamic rul=await dio.post(endPont,
        data: formData,
        options: Options(
            headers: {
              // 'Authorization': 'Bearer $token',

              'Accept': 'application/json',
              // 'Content-Type': 'application/json',
            },
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }));
    print("rul is: ${rul.toString()}");

    return  rul;
  }


  static Future<Response> register1({
    required String endPont,
    required myData,
  }) async {
    return await dio.post(endPont,
        data: myData,
        options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Accept': 'application/json',
              // 'Content-Type': 'application/json',
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

  print("myGet");
  print(' __________myGet _____________-token is:$token');


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



  static Future<Response> postRequestWithImageOne({
    required Map<String, dynamic> data,
    required String linkUrl,
    required File? image,
  }) async {
    print("token is $token and i in postRequestWithImageOne");
    print("i am here in postRequestWithImageOne");

    FormData formData = FormData.fromMap({
      ...data,
      if (image != null)
        "photo": await MultipartFile.fromFile(
          image.path,
          filename: image.path.split("/").last,
        ),
    });

    Response response = await dio.post(
      linkUrl,
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          "Content-Type": "multipart/form-data"
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );

    print("i am here in$response ");

    return response;
  }

}


