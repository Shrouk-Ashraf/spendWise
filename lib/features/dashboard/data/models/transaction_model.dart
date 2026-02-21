
// Transaction model
import 'package:flutter/material.dart';

class Transaction {
  final String id;
  final String category;
  final double amount;
  final DateTime date;
  final String type;
  final IconData icon;

  Transaction({
    required this.id,
    required this.category,
    required this.amount,
    required this.date,
    required this.type,
    required this.icon,
  });
}