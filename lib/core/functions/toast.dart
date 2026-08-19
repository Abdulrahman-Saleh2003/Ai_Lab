import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

toast({String msg = 'تم نسخ النص', bool isLong = false}) =>
    Fluttertoast.showToast(
      msg: msg,
      toastLength: isLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      textColor: Theme.of(Get.context!).textTheme.headlineLarge!.color,
      fontSize: 16.0,
    );
