import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyServices extends GetxService {
  late SharedPreferences mySharedPreferences;

  Future<MyServices> init() async {
    mySharedPreferences = await SharedPreferences.getInstance();
    return this;
  }
}

initializedServices() async {
  await Get.putAsync(() => MyServices().init());
}
