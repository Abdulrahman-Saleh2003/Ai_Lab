import 'package:ai_lab/controller/Profile/profile_state.dart';
import 'package:ai_lab/core/providers/app_providers.dart';
import 'package:ai_lab/core/shared/cache_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileController extends Notifier<ProfileState> {
  @override
  ProfileState build() {
    final name = CacheHelper.getUserName() ?? 'Ahmed Mohammed';
    final email = CacheHelper.getUserEmail() ?? 'ahmed.m@email.com';
    final id = CacheHelper.getUserId() ?? '8829';
    final age = CacheHelper.getUserAge() ?? '28';
    final gender = CacheHelper.getUserGender() ?? 'Male';
    final image = CacheHelper.getUserImage() ?? '';

    return ProfileState(
      profile: PatientProfile(
        name: name,
        patientId: id.startsWith('#') ? id : '#LS-$id',
        age: age.contains('Year') || age.contains('سنة') ? age : '$age Years',
        gender: gender,
        email: email,
        avatarUrl: image.isNotEmpty
            ? image
            : 'https://images.unsplash.com/photo-1622253692010-333f2da6031d?q=80&w=300&auto=format&fit=crop',
      ),
    );
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
