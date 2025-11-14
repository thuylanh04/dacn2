import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/transport_repository.dart';
import 'repository_providers.dart';
import '../models/transport_overview.dart';
import '../models/transport_expense.dart';

final categoryOverviewProvider = FutureProvider.family<TransportOverview, ({int id, String name})>((ref, args) async {
  final repo = ref.watch(transportRepositoryProvider);
  return repo.fetchOverviewByCategory(categoryId: args.id, name: args.name);
});

final categoryExpensesByMonthProvider = FutureProvider.family<Map<String, List<TransportExpense>>, ({int id, String name})>((ref, args) async {
  final repo = ref.watch(transportRepositoryProvider);
  return repo.fetchExpensesByMonthByCategory(categoryId: args.id, name: args.name);
});
