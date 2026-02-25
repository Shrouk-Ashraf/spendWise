import '../../../data/models/transaction_model.dart';

enum TransactionStatus { initial, loading, success, error }

enum CurrencyStatus { idle, loading, success, error }

class AddTransactionState {
  final TransactionStatus status;
  final List<TransactionModel> transactions;
  final String? errorMessage;

  // Currency fields
  final CurrencyStatus currencyStatus;
  final Map<String, String> currencySymbols;
  final String? selectedCurrency;
  final String? currencyErrorMessage;

  const AddTransactionState({
    this.status       = TransactionStatus.initial,
    this.transactions = const [],
    this.errorMessage,
    this.currencyStatus = CurrencyStatus.idle,
    this.currencySymbols = const {},
    this.selectedCurrency,
    this.currencyErrorMessage,
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

  AddTransactionState copyWith({
    TransactionStatus?      status,
    List<TransactionModel>? transactions,
    String?                 errorMessage,
    // currency
    CurrencyStatus?         currencyStatus,
    Map<String, String>?    currencySymbols,
    String?                 selectedCurrency,
    String?                 currencyErrorMessage,
  }) {
    return AddTransactionState(
      status:       status       ?? this.status,
      transactions: transactions ?? this.transactions,
      errorMessage: errorMessage,
      currencyStatus: currencyStatus ?? this.currencyStatus,
      currencySymbols: currencySymbols ?? this.currencySymbols,
      selectedCurrency: selectedCurrency ?? this.selectedCurrency,
      currencyErrorMessage: currencyErrorMessage,
    );
  }
}