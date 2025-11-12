import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../constants/colors.dart';
import '../models/transaction_model.dart';
import '../widgets/transaction_card.dart';
import '../providers/app_state_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = [
      Transaction(
        id: '1',
        title: 'Salary',
        amount: 4000,
        category: TransactionCategory.salary,
        date: DateTime.now().subtract(const Duration(days: 5)),
        icon: '💼',
        isIncome: true,
      ),
      Transaction(
        id: '2',
        title: 'Groceries',
        amount: -100,
        category: TransactionCategory.groceries,
        date: DateTime.now().subtract(const Duration(days: 3)),
        icon: '🛒',
        isIncome: false,
      ),
      Transaction(
        id: '3',
        title: 'Rent',
        amount: -674.40,
        category: TransactionCategory.rent,
        date: DateTime.now().subtract(const Duration(days: 1)),
        icon: '🏠',
        isIncome: false,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: AppColors.primary,
            elevation: 0,
            title: const Text('Hi, Welcome Back'),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_rounded),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.logout_rounded),
                onPressed: () {
                  ref.read(appStateProvider.notifier).logout();
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Good Morning',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _BalanceCard(
                    label: 'Total Balance',
                    amount: '\$7,783.00',
                    sublabel: 'Total Expense',
                    subamount: '-\$1,187.40',
                  ),
                  const SizedBox(height: 20),
                  _ProgressBar(
                    percentage: 0.3,
                    label: '30%',
                    maxAmount: '\$20,000.00',
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '30% Of Your Expenses Looks Good.',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _SavingsCard(),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _TimeFilterButtons(),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Recent Transactions',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 15),
                      ...transactions.map((tx) => TransactionCard(transaction: tx)),
                    ],
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _BottomNavBar(),
    );
  }
}

class _BalanceCard extends StatelessWidget {
  final String label;
  final String amount;
  final String sublabel;
  final String subamount;

  const _BalanceCard({
    required this.label,
    required this.amount,
    required this.sublabel,
    required this.subamount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              amount,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        const VerticalDivider(
          color: AppColors.textMuted,
          thickness: 1,
          width: 30,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sublabel,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              subamount,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.expense,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final double percentage;
  final String label;
  final String maxAmount;

  const _ProgressBar({
    required this.percentage,
    required this.label,
    required this.maxAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: percentage,
                    minHeight: 5,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                maxAmount,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SavingsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white24),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.card_giftcard,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Savings\nOn Goals',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Revenue Last Week\n\$4,000.00',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Food Last Week\n-\$100.00',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeFilterButtons extends StatefulWidget {
  @override
  State<_TimeFilterButtons> createState() => _TimeFilterButtonsState();
}

class _TimeFilterButtonsState extends State<_TimeFilterButtons> {
  String _selectedFilter = 'Monthly';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: ['Daily', 'Weekly', 'Monthly'].map((filter) {
        final isSelected = _selectedFilter == filter;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedFilter = filter),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.surface,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                filter,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : AppColors.textPrimary,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _BottomNavBar extends StatefulWidget {
  @override
  State<_BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<_BottomNavBar> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final currentIndex = _selectedIndex;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/quick-analysis');
              break;
            case 2:
              context.go('/transaction');
              break;
            case 3:
              context.go('/categories');
              break;
            case 4:
              context.go('/profile');
              break;
          }
        },
        backgroundColor: AppColors.surface,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.compare_arrows_rounded), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.layers_rounded), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: ''),
        ],
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textMuted,
      ),
    );
  }
}
