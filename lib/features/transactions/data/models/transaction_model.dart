class TransactionModel {
  final String id;
  final String type; // 'income' or 'expense'
  final double amount;
  final String category;
  final DateTime date;
  final String notes;

  const TransactionModel({
    required this.id,
    required this.type,
    required this.amount,
    required this.category,
    required this.date,
    required this.notes,
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
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id:       map['id'],
      type:     map['type'],
      amount:   map['amount'],
      category: map['category'],
      date:     DateTime.fromMillisecondsSinceEpoch(map['date']),
      notes:    map['notes'] ?? '',
    );
  }

  TransactionModel copyWith({
    String?   id,
    String?   type,
    double?   amount,
    String?   category,
    DateTime? date,
    String?   notes,
  }) {
    return TransactionModel(
      id:       id       ?? this.id,
      type:     type     ?? this.type,
      amount:   amount   ?? this.amount,
      category: category ?? this.category,
      date:     date     ?? this.date,
      notes:    notes    ?? this.notes,
    );
  }
}