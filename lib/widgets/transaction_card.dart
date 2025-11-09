import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/transaction_model.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  const TransactionCard({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  String _getCategoryLabel(TransactionCategory category) {
    switch (category) {
      case TransactionCategory.salary:
        return 'Salary';
      case TransactionCategory.groceries:
        return 'Groceries';
      case TransactionCategory.rent:
        return 'Rent';
      case TransactionCategory.entertainment:
        return 'Entertainment';
      case TransactionCategory.utilities:
        return 'Utilities';
      default:
        return 'Other';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              transaction.icon,
              style: const TextStyle(fontSize: 24),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      _getCategoryLabel(transaction.category),
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 1,
                      height: 12,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      DateFormat('MMM d').format(transaction.date),
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            '${transaction.isIncome ? '+' : ''}\$${transaction.amount.abs().toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: transaction.isIncome
                  ? AppColors.success
                  : AppColors.expense,
            ),
          ),
        ],
      ),
    );
  }
}