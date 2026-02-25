import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spendwise/features/transactions/data/repository/transactions_repository.dart';
import 'package:spendwise/features/transactions/presentation/transaction_details/cubit/transaction_details_state.dart';


class TransactionDetailCubit extends Cubit<TransactionDetailState> {
  final TransactionRepository _repository;

  TransactionDetailCubit(this._repository)
      : super(const TransactionDetailState());

  static TransactionDetailCubit get(BuildContext context) =>
      context.read<TransactionDetailCubit>();

  // ── Load single transaction by id ─────────────────────────────────────────
  void loadTransaction(String id) async{
    emit(state.copyWith(status: TransactionDetailStatus.loading));

    final result =await _repository.getById(id);
    result.fold(
          (error) => emit(state.copyWith(
        status:       TransactionDetailStatus.error,
        errorMessage: error,
      )),
          (transaction) {

          emit(state.copyWith(
            status:      TransactionDetailStatus.success,
            transaction: transaction,
          ));
      },
    );
  }

  // ── Delete transaction ────────────────────────────────────────────────────
  Future<void> deleteTransaction(String id) async {
    emit(state.copyWith(status: TransactionDetailStatus.loading));

    final result = await _repository.delete(id);
    result.fold(
          (error) => emit(state.copyWith(
        status:       TransactionDetailStatus.error,
        errorMessage: error,
      )),
          (_) => emit(state.copyWith(
        status: TransactionDetailStatus.deleted, // ✅ triggers navigation
      )),
    );
  }
}