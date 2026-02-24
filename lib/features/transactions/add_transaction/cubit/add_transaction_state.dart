import '../../data/models/transaction_model.dart';

enum TransactionStatus { initial, loading, success, error }

class TransactionState {
  final TransactionStatus status;
  final List<TransactionModel> transactions;
  final String? errorMessage;

  const TransactionState({
    this.status       = TransactionStatus.initial,
    this.transactions = const [],
    this.errorMessage,
  });

  // ── Computed values (no need to store them, calculate from list) ──────────
  double get totalIncome => transactions
      .where((t) => t.isIncome)
      .fold(0.0, (sum, t) => sum + t.amount);

  double get totalExpenses => transactions
      .where((t) => t.isExpense)
      .fold(0.0, (sum, t) => sum + t.amount);

  double get balance => totalIncome - totalExpenses;

  List<TransactionModel> get recentTransactions =>
      transactions.take(5).toList();

  TransactionState copyWith({
    TransactionStatus?      status,
    List<TransactionModel>? transactions,
    String?                 errorMessage,
  }) {
    return TransactionState(
      status:       status       ?? this.status,
      transactions: transactions ?? this.transactions,
      errorMessage: errorMessage,
    );
  }
}