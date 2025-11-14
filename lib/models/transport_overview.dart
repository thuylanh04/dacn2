import 'package:flutter/material.dart';

class TransportOverview {
  final double totalBalance;
  final double totalExpense;
  final double goalAmount;

  const TransportOverview({
    required this.totalBalance,
    required this.totalExpense,
    required this.goalAmount,
  });

  double get progressPercent {
    if (goalAmount <= 0) return 0;
    final spent = totalExpense.abs();
    return (spent / goalAmount).clamp(0, 1);
  }

  String get percentLabel => "${(progressPercent * 100).round()}%";

  Color get expenseColor => const Color(0xFFB85DFF);
}
