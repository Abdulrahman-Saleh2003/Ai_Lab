import 'package:ai_lab/controller/Authentication/sign_up/signup_controller.dart';
import 'package:ai_lab/controller/Authentication/sign_up/signup_state.dart';
import 'package:ai_lab/controller/app_providers.dart';
import 'package:ai_lab/data/remote/auth/sign_up_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final patientRegistrationProvider =
NotifierProvider<PatientRegistrationController, PatientRegistrationState>(
  PatientRegistrationController.new,
);

final registerDataProvider = Provider<SignUpData>((ref) {
  return SignUpData(crud: ref.watch(crudProvider));
});

