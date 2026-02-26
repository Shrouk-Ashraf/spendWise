import 'package:flutter/material.dart';

class TransactionModel {
  final String id;
  final String type; // 'income' or 'expense'
  final double amount;
  final String category;
  final DateTime date;
  final String notes;
  final IconData categoryIcon;

  const TransactionModel({
    required this.id,
    required this.type,
    required this.amount,
    required this.category,
    required this.date,
    required this.notes,
    required this.categoryIcon,
  });

  bool get isIncome => type == 'income';
  bool get isExpense => type == 'expense';

  // ── Serialization ─────────────────────────────────────────────────────────
  Map<String, dynamic> toMap() {
    return {
      'id':       id,
      'type':     type,
      'amount':   amount,
      'category': category,
      'date':     date.millisecondsSinceEpoch,
      'notes':    notes,
      // serialize IconData as primitives
      'categoryIcon': {
        'codePoint': categoryIcon.codePoint,
        'fontFamily': categoryIcon.fontFamily,
        'fontPackage': categoryIcon.fontPackage,
        'matchTextDirection': categoryIcon.matchTextDirection,
      },
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    final iconMap = Map<String, dynamic>.from(map['categoryIcon'] ?? {});
    final int codePoint = iconMap['codePoint'] ?? 0;
    final String? fontFamily = iconMap['fontFamily'];
    final String? fontPackage = iconMap['fontPackage'];
    final bool matchTextDirection = iconMap['matchTextDirection'] ?? false;
    return TransactionModel(
      id:       map['id'],
      type:     map['type'],
      amount:   map['amount'],
      category: map['category'],
      date:     DateTime.fromMillisecondsSinceEpoch(map['date']),
      notes:    map['notes'] ?? '',
      categoryIcon: IconData(
        codePoint,
        fontFamily: fontFamily,
        fontPackage: fontPackage,
        matchTextDirection: matchTextDirection,
      )?? Icons.category,
    );
  }

  TransactionModel copyWith({
    String?   id,
    String?   type,
    double?   amount,
    String?   category,
    DateTime? date,
    String?   notes,
    IconData?    categoryIcon,
  }) {
    return TransactionModel(
      id:       id       ?? this.id,
      type:     type     ?? this.type,
      amount:   amount   ?? this.amount,
      category: category ?? this.category,
      date:     date     ?? this.date,
      notes:    notes    ?? this.notes,
      categoryIcon: categoryIcon ?? this.categoryIcon,
    );
  }
}