
import 'package:ai_lab/core/constant/app_name_routes.dart';
import 'package:ai_lab/core/services/services.dart';
// import 'package:ai_lab/core/shared/my_cash_helper.dart';
import 'package:ai_lab/core/shared/my_cash_helper_with_getx.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class MyMiddleWare extends GetMiddleware {
  @override
  int? get priority => 1;
  MyServices 
  myServices = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    if (myServices.mySharedPreferences.get("initialized") != "False") {
      return const RouteSettings(name: AppNameRoutes
      .onBoarding);
      // return const RouteSettings(name: AppNameRoutes
      // .home);
    }
    if (CashHelper.getUserToken() != null && CashHelper.getUserToken()!.isNotEmpty) {

      // if(CashHelper.getUserToken()!.isNotEmpty){
      return  RouteSettings(name: AppNameRoutes.login);

    }

    if(myServices.mySharedPreferences.get("initialized") == "False"){
      return const RouteSettings(name: AppNameRoutes
          .register);

    }
    return null;
  }
}
