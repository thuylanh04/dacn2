import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppStatus {
  splash,
  onboarding,
  loginSignup,
  home,
}

class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier() : super(const AppState());

  void setSplashComplete() {
    state = state.copyWith(appStatus: AppStatus.onboarding);
  }

  void setOnboardingComplete() {
    state = state.copyWith(appStatus: AppStatus.loginSignup);
  }

  void setLoggedIn(bool isLoggedIn) {
    state = state.copyWith(
      isLoggedIn: isLoggedIn,
      appStatus: isLoggedIn ? AppStatus.home : AppStatus.loginSignup,
    );
  }

  void logout() {
    state = state.copyWith(
      isLoggedIn: false,
      appStatus: AppStatus.loginSignup,
    );
  }
}

class AppState {
  final AppStatus appStatus;
  final bool isLoggedIn;

  const AppState({
    this.appStatus = AppStatus.splash,
    this.isLoggedIn = false,
  });

  AppState copyWith({
    AppStatus? appStatus,
    bool? isLoggedIn,
  }) {
    return AppState(
      appStatus: appStatus ?? this.appStatus,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}

final appStateProvider = StateNotifierProvider<AppStateNotifier, AppState>(
  (ref) => AppStateNotifier(),
);