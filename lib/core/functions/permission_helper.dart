// import 'dart:io';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:get/get.dart';
//
//
// Future<bool> requestStoragePermission() async {
//
//
//   if (!Platform.isAndroid) return true;
//
//   final androidInfo = await DeviceInfoPlugin().androidInfo;
//   final sdkInt = androidInfo.version.sdkInt;
//
//   PermissionStatus status;
//
//   if (sdkInt >= 30) {
//     status = await Permission.manageExternalStorage.request();
//   } else {
//     status = await Permission.storage.request();
//   }
//
//   if (!status.isGranted) {
//     Get.snackbar("تنبيه", "يرجى منح إذن التخزين لحفظ التقرير");
//     openAppSettings();
//     return false;
//   }
//
//   return true;
// }
//
