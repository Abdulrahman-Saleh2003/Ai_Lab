
class OnboardingState {
  final int currentPage;
  final bool showButton;
  final bool goToLogin;
  final bool skipToLogin;


  const OnboardingState({
    this.currentPage = 0,
    this.showButton = false,
    this.goToLogin = false,
    this.skipToLogin = false,

  });

  OnboardingState copyWith({
    int? currentPage,
    bool? showButton,
    bool? goToLogin,
    bool? skipToLogin,

  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      showButton: showButton ?? this.showButton,
      goToLogin: goToLogin ?? this.goToLogin,
      skipToLogin: skipToLogin ?? this.skipToLogin,

    );
  }
}

