import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  void signup(String fullName, String email, String phone, String dob, String password) {
    // Simulate API call
    final user = User(
      id: '1',
      fullName: fullName,
      email: email,
      mobileNumber: phone,
      dateOfBirth: dob,
    );
    state = state.copyWith(user: user, isLoading: false);
  }

  void login(String email, String password) {
    // Simulate API call
    final user = User(
      id: '1',
      fullName: 'John Doe',
      email: email,
      mobileNumber: '+1234567890',
      dateOfBirth: '01/01/1990',
    );
    state = state.copyWith(user: user, isLoading: false);
  }

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void setError(String? error) {
    state = state.copyWith(error: error);
  }

  void logout() {
    state = const AuthState();
  }
}

class AuthState {
  final User? user;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.user,
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({
    User? user,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}