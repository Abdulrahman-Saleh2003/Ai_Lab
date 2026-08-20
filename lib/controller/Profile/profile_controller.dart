import 'package:ai_lab/controller/Profile/profile_state.dart';
import 'package:ai_lab/core/providers/app_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileController extends Notifier<ProfileState> {
  @override
  ProfileState build() {
    return const ProfileState();
  }

  void updateProfile(PatientProfile newProfile) {
    state = state.copyWith(
      profile: newProfile,
      status: ProfileStatus.success,
    );
  }

  Future<void> logout() async {
    state = state.copyWith(status: ProfileStatus.loading);
    try {
      await ref.read(authProvider.notifier).logout();
      state = state.copyWith(status: ProfileStatus.success);
    } catch (e) {
      state = state.copyWith(
        status: ProfileStatus.failure,
        errorMessage: e.toString(),
      );
    }
  }
}
