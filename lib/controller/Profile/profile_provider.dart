import 'package:ai_lab/controller/Profile/profile_controller.dart';
import 'package:ai_lab/controller/Profile/profile_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileProvider = NotifierProvider<ProfileController, ProfileState>(
  ProfileController.new,
);
