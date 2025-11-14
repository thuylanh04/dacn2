import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/transport_repository.dart';
import 'repository_providers.dart';
import '../models/transport_overview.dart';
import '../models/transport_expense.dart';

final transportOverviewProvider = FutureProvider<TransportOverview>((ref) async {
  final repo = ref.watch(transportRepositoryProvider);
  return repo.fetchOverview();
});

final transportExpensesByMonthProvider = FutureProvider<Map<String, List<TransportExpense>>>((ref) async {
  final repo = ref.watch(transportRepositoryProvider);
  return repo.fetchExpensesByMonth();
});
