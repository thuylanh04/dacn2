// Core providers for repositories and ApiService

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_service.dart';
import '../repositories/auth_repository.dart';
import '../repositories/category_repository.dart';
import '../repositories/transaction_repository.dart';
import '../repositories/transport_repository.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  // In the future, inject baseUrl/mock via env/config
  return ApiService(mock: true);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final api = ref.read(apiServiceProvider);
  return AuthRepository(api);
});

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  final api = ref.read(apiServiceProvider);
  return CategoryRepository(api);
});


final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  final api = ref.read(apiServiceProvider);
  return TransactionRepository(api);
});

final transportRepositoryProvider = Provider<TransportRepository>((ref) {
  // Replace with api when backend ready
  return TransportRepository(mock: true);
});
