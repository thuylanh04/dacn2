// Repository: TransactionRepository
// Abstracts ApiService for transactions.

import '../models/transaction.dart';
import '../services/api_service.dart';

class TransactionRepository {
  final ApiService _api;
  TransactionRepository(this._api);

  Future<List<TransactionModel>> getTransactions() => _api.getTransactions();
  Future<void> createTransaction(TransactionModel tx) => _api.createTransaction(tx);
}
