// Model: TransportExpense
// Holds basic expense info for the Transport screen.

import 'package:flutter/material.dart';

class TransportExpense {
  final String title;
  final String time;
  final String amount; // Keep as string for now to match UI formatting
  final IconData icon;

  const TransportExpense({
    required this.title,
    required this.time,
    required this.amount,
    required this.icon,
  });
}
