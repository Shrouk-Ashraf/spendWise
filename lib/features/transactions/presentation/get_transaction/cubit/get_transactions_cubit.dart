import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:spendwise/features/transactions/data/repository/transactions_repository.dart';

import 'get_transactions_state.dart';


class GetTransactionsCubit extends Cubit<TransactionsState> {

  final TransactionRepository _repository;

  GetTransactionsCubit(this._repository) : super(const TransactionsState());

  static GetTransactionsCubit get(BuildContext context) =>
      context.read<GetTransactionsCubit>();

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
}
