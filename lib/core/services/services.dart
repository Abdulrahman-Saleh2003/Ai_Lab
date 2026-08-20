import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyServices extends GetxService {
  late SharedPreferences mySharedPreferences;

  Future<MyServices> init() async {
    mySharedPreferences = await SharedPreferences.getInstance();
    return this;
  }
}

Future<void> initializedServices() async {
  await Get.putAsync(() => MyServices().init());
}
