import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/transaction_model.dart';
import '../../data/repository/transactions_repository.dart';
import 'add_transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final TransactionRepository _repository;

  TransactionCubit(this._repository) : super(const TransactionState());

  static TransactionCubit get(BuildContext context) =>
      context.read<TransactionCubit>();

  // ── Load all ──────────────────────────────────────────────────────────────
  void loadTransactions() {
    emit(state.copyWith(status: TransactionStatus.loading));

    final result = _repository.getAll();
    result.fold(
      (error) => emit(
        state.copyWith(status: TransactionStatus.error, errorMessage: error),
      ),
      (transactions) => emit(
        state.copyWith(
          status: TransactionStatus.success,
          transactions: transactions,
        ),
      ),
    );
  }

  // ── Add ───────────────────────────────────────────────────────────────────
  Future<void> addTransaction(TransactionModel transaction) async {
    emit(state.copyWith(status: TransactionStatus.loading));

    final result = await _repository.save(transaction);
    result.fold(
      (error) => emit(
        state.copyWith(status: TransactionStatus.error, errorMessage: error),
      ),
      (_) => loadTransactions(), // reload to refresh the list
    );
  }

  // ── Delete ────────────────────────────────────────────────────────────────
  Future<void> deleteTransaction(String id) async {
    emit(state.copyWith(status: TransactionStatus.loading));

    final result = await _repository.delete(id);
    result.fold(
      (error) => emit(
        state.copyWith(status: TransactionStatus.error, errorMessage: error),
      ),
      (_) => loadTransactions(),
    );
  }
}
