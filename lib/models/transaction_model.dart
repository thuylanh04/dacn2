enum TransactionCategory {
  salary,
  groceries,
  rent,
  entertainment,
  utilities,
  other,
}

class Transaction {
  final String id;
  final String title;
  final double amount;
  final TransactionCategory category;
  final DateTime date;
  final String icon;
  final bool isIncome;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.icon,
    this.isIncome = false,
  });
}