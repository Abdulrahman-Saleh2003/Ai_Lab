import 'dart:convert';
import 'dart:io';

import 'package:ai_lab/core/class/crud_with_dio.dart';
import 'package:ai_lab/core/class/status_request.dart';
import 'package:ai_lab/core/functions/check_internet.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class Crud {
  Future<Either<StatusRequest, dynamic>> registerData({
    required String linkUrl,
    required Map data,
  }) async {
    if (await checkInternet()) {
      try {
        final Response response =
            await DioHelper.register(endPont: linkUrl, myData: data);
        if (response.statusCode != null &&
            response.statusCode! >= 200 &&
            response.statusCode! < 300) {
          final dynamic raw = response.data;
          if (raw is Map) return Right(raw);
          if (raw is String) {
            try {
              return Right(jsonDecode(raw));
            } catch (_) {
              return Right(raw);
            }
          }
          return Right(raw);
        } else {
          return const Left(StatusRequest.serverException);
        }
      } catch (_) {
        return const Left(StatusRequest.serverException);
      }
    }
    return const Left(StatusRequest.serverFailure);
  }

  Future<Either<StatusRequest, dynamic>> postData({
    required String linkUrl,
    required Map data,
    bool isFormData = false,
  }) async {
    if (await checkInternet()) {
      try {
        final Response response = await DioHelper.myPost(
          endPont: linkUrl,
          myData: data,
          isFormData: isFormData,
        );
        if (response.statusCode != null &&
            response.statusCode! >= 200 &&
            response.statusCode! < 300) {
          final dynamic raw = response.data;
          if (raw is Map) return Right(raw);
          if (raw is String) {
            try {
              return Right(jsonDecode(raw));
            } catch (_) {
              return Right(raw);
            }
          }
          return Right(raw);
        } else {
          debugPrint("Server responded with error status ${response.statusCode}: ${response.data}");
          return const Left(StatusRequest.serverException);
        }
      } on DioException catch (e) {
        debugPrint("DioException on $linkUrl: status ${e.response?.statusCode} => ${e.response?.data}");
        return const Left(StatusRequest.serverException);
      } catch (e) {
        debugPrint("General error on $linkUrl: $e");
        return const Left(StatusRequest.serverException);
      }
    }
    return const Left(StatusRequest.serverFailure);
  }

  Future<Either<StatusRequest, Map>> addRequestWithImageOne({
    String? nameRequest,
    required Map data,
    required String linkUrl,
    required File? image,
  }) async {
    nameRequest ??= "files";
    final uri = Uri.parse(linkUrl);
    final request = http.MultipartRequest("POST", uri);

    if (image != null) {
      final length = await image.length();
      final stream = http.ByteStream(image.openRead());
      final multipartFile = http.MultipartFile(
        nameRequest,
        stream,
        length,
        filename: basename(image.path),
      );
      request.files.add(multipartFile);
    }

    data.forEach((key, value) {
      request.fields[key.toString()] = value.toString();
    });

    final myRequest = await request.send();
    final response = await http.Response.fromStream(myRequest);

    if (response.statusCode >= 200 && response.statusCode <= 202) {
      final Map responseBody = jsonDecode(response.body) as Map;
      return Right(responseBody);
    } else {
      return const Left(StatusRequest.serverFailure);
    }
  }

  Future<Either<StatusRequest, dynamic>> getData({
    required String linkUrl,
    Map? data,
  }) async {
    if (await checkInternet()) {
      try {
        final Response response =
            await DioHelper.myGet(endPont: linkUrl, myData: data);
        if (response.statusCode != null &&
            response.statusCode! >= 200 &&
            response.statusCode! < 300) {
          final dynamic raw = response.data;
          if (raw is Map || raw is List) return Right(raw);
          if (raw is String) {
            try {
              return Right(jsonDecode(raw));
            } catch (_) {
              return Right(raw);
            }
          }
          return Right(raw);
        } else {
          return const Left(StatusRequest.serverException);
        }
      } catch (_) {
        return const Left(StatusRequest.serverException);
      }
    }
    return const Left(StatusRequest.serverFailure);
  }

  Future<Either<StatusRequest, dynamic>> postRequestWithImageOneDio({
    String? nameRequest,
    required Map<String, dynamic> data,
    required String linkUrl,
    required File? image,
  }) async {
    if (await checkInternet()) {
      try {
        final Response response = await DioHelper.postRequestWithImageOne(
          image: image,
          data: data,
          linkUrl: linkUrl,
        );
        if (response.statusCode != null &&
            response.statusCode! >= 200 &&
            response.statusCode! < 300) {
          final dynamic raw = response.data;
          if (raw is Map) return Right(raw);
          if (raw is String) {
            try {
              return Right(jsonDecode(raw));
            } catch (_) {
              return Right(raw);
            }
          }
          return Right(raw);
        } else {
          return const Left(StatusRequest.serverException);
        }
      } catch (_) {
        return const Left(StatusRequest.serverException);
      }
    }
    return const Left(StatusRequest.serverFailure);
  }

  Future<Either<StatusRequest, dynamic>> deleteData({
    required String linkUrl,
    required Map data,
  }) async {
    if (await checkInternet()) {
      try {
        final Response response =
            await DioHelper.myDelete(endPont: linkUrl, myData: data);
        if (response.statusCode != null &&
            response.statusCode! >= 200 &&
            response.statusCode! < 300) {
          final dynamic raw = response.data;
          if (raw is Map) return Right(raw);
          if (raw is String) {
            try {
              return Right(jsonDecode(raw));
            } catch (_) {
              return Right(raw);
            }
          }
          return Right(raw);
        } else {
          return const Left(StatusRequest.serverException);
        }
      } catch (_) {
        return const Left(StatusRequest.serverException);
      }
    }
    return const Left(StatusRequest.serverFailure);
  }
}
