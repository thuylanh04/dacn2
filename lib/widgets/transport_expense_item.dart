// Widget: TransportExpenseItem
// Reusable list row for a transport expense.

import 'package:flutter/material.dart';
import '../models/transport_expense.dart';

class TransportExpenseItem extends StatelessWidget {
  final TransportExpense expense;

  const TransportExpenseItem({Key? key, required this.expense})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF5B9EFF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(expense.icon, color: Colors.white, size: 26),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Text(
                  expense.time,
                  style: const TextStyle(
                    color: Color(0xFF5B9EFF),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            expense.amount,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
