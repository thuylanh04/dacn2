// Model: Transaction
// Represents a transaction in the app and JSON mapping.

class TransactionModel {
  final int id;
  final int categoryId;
  final String title;
  final num amount;
  final DateTime createdAt;

  const TransactionModel({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.amount,
    required this.createdAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] is int ? json['id'] as int : int.tryParse('${json['id']}') ?? 0,
      categoryId: json['categoryId'] is int
          ? json['categoryId'] as int
          : int.tryParse('${json['categoryId']}') ?? 0,
      title: json['title'] as String? ?? '',
      amount: json['amount'] as num? ?? 0,
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'categoryId': categoryId,
        'title': title,
        'amount': amount,
      };
}
