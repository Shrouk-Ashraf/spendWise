import 'package:spendwise/features/transactions/data/models/transaction_model.dart';

enum TransactionDetailStatus { initial, loading, success, deleted, error }

class TransactionDetailState {
  final TransactionDetailStatus status;
  final TransactionModel?       transaction;
  final String?                 errorMessage;

  const TransactionDetailState({
    this.status      = TransactionDetailStatus.initial,
    this.transaction,
    this.errorMessage,
  });

  TransactionDetailState copyWith({
    TransactionDetailStatus? status,
    TransactionModel?        transaction,
    String?                  errorMessage,
  }) {
    return TransactionDetailState(
      status:       status       ?? this.status,
      transaction:  transaction  ?? this.transaction,
      errorMessage: errorMessage,
    );
  }
}