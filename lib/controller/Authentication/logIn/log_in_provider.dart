import 'package:ai_lab/controller/app_providers.dart';
import 'package:ai_lab/data/remote/auth/login_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'log_in_controller.dart';
import 'log_in_state.dart';



final loginProvider =
NotifierProvider<LoginController, LoginState>(
  LoginController.new,
);
final loginDataProvider = Provider<LoginData>((ref) {
  return LoginData(crud: ref.watch(crudProvider));
});





