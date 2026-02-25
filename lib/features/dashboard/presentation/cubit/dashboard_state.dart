part of 'dashboard_cubit.dart';

enum DashboardStatus { initial, loading, success, error }

class DashboardState {
  final DashboardStatus status;
  final List<TransactionModel> transactions;
  final String? errorMessage;

  const DashboardState({
    this.status = DashboardStatus.initial,
    this.transactions = const [],
    this.errorMessage,
  });

  List<TransactionModel> get recentTransactions => transactions.take(10).toList();

  double get totalIncome => transactions
      .where((t) => t.isIncome)
      .fold(0.0, (sum, t) => sum + t.amount);

  double get totalExpenses => transactions
      .where((t) => t.isExpense)
      .fold(0.0, (sum, t) => sum + t.amount);

  double get balance => totalIncome - totalExpenses;


  DashboardState copyWith({
    DashboardStatus? status,
    List<TransactionModel>? transactions,
    String? errorMessage,
  }) {
    return DashboardState(
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
      errorMessage: errorMessage,
    );
  }
}
