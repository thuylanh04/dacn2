// Repository: AuthRepository
// Abstracts ApiService for authentication flows, future-proof for real backend.

import '../models/user.dart';
import '../services/api_service.dart';

class AuthRepository {
  final ApiService _api;
  AuthRepository(this._api);

  Future<User> login(String email, String password) async {
    final user = await _api.login(email: email, password: password);
    return user;
  }

  Future<void> signup(String name, String email, String password) async {
    await _api.signup(name: name, email: email, password: password);
  }
}
