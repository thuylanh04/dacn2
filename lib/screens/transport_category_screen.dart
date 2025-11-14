// Screen: TransportCategoryScreen
// Transport category detail screen with header stats, progress, and expenses list.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/transport_expense.dart';
import '../models/transport_overview.dart';
import '../providers/transport_providers.dart';
import '../widgets/transport_expense_item.dart';
import 'add_expenses_screen.dart';

class TransportCategoryScreen extends ConsumerWidget {
  const TransportCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const primary = Color(0xFF14C996);

    final overviewAsync = ref.watch(transportOverviewProvider);
    final expensesAsync = ref.watch(transportExpensesByMonthProvider);

    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text(
          'Transport',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: overviewAsync.when(
          loading: () => const Center(child: CircularProgressIndicator(color: Colors.white)),
          error: (e, _) => Center(
            child: Text('Failed to load', style: const TextStyle(color: Colors.white)),
          ),
          data: (overview) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Header Stats
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildHeaderStat(
                              label: 'Total Balance',
                              value: _money(overview.totalBalance),
                              iconColor: primary,
                              valueColor: Colors.white,
                            ),
                            Container(
                              height: 60,
                              width: 2,
                              color: Colors.white.withOpacity(0.3),
                            ),
                            _buildHeaderStat(
                              label: 'Total Expense',
                              value: _money(overview.totalExpense),
                              iconColor: const Color(0xFFB85DFF),
                              valueColor: const Color(0xFFB85DFF),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Progress Bar
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  overview.percentLabel,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 8),
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: FractionallySizedBox(
                                    widthFactor: overview.progressPercent,
                                    alignment: Alignment.centerLeft,
                                    child: const DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(3)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                _money(overview.goalAmount),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: const [
                            Icon(Icons.check_circle, color: Color(0xFF14C996), size: 16),
                            SizedBox(width: 6),
                            Text(
                              '30% Of Your Expenses, Looks Good.',
                              style: TextStyle(
                                color: Color(0xFF14C996),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Expenses List
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: expensesAsync.when(
                        loading: () => const Center(child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: CircularProgressIndicator(),
                        )),
                        error: (e, _) => const Text('Failed to load expenses'),
                        data: (byMonth) {
                          final months = byMonth.keys.toList();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var i = 0; i < months.length; i++) ...[
                                _buildMonthSection(months[i], byMonth[months[i]] ?? const []),
                                if (i != months.length - 1) const SizedBox(height: 20),
                              ],
                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const AddExpensesScreen(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primary,
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: const Text(
                                    'Add Expenses',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeaderStat({
    required String label,
    required String value,
    required Color iconColor,
    required Color valueColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.check_circle, color: iconColor, size: 16),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildMonthSection(String month, List<TransportExpense> expenses) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              month,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const Icon(Icons.calendar_today,
                color: Color(0xFF14C996), size: 20),
          ],
        ),
        const SizedBox(height: 12),
        ...expenses.map((e) => TransportExpenseItem(expense: e)),
      ],
    );
  }

  String _money(double value) {
    final neg = value < 0;
    final abs = value.abs();
    return '${neg ? '-\$' : '\$'}${abs.toStringAsFixed(2)}';
  }
}
