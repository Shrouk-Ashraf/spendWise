import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/transaction_model.dart';
import '../../../data/repository/transactions_repository.dart';
import 'add_transaction_state.dart';

class AddTransactionCubit extends Cubit<AddTransactionState> {
  final TransactionRepository _repository;

  AddTransactionCubit(this._repository) : super(const AddTransactionState());

  static AddTransactionCubit get(BuildContext context) =>
      context.read<AddTransactionCubit>();

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

  // ── Currency helpers (use TransactionRepository to fetch symbols) ─────────
  Future<void> loadCurrencySymbols(
      {required String accessKey, String baseUrl = 'https://api.exchangeratesapi.io/v1'}) async {
    emit(state.copyWith(currencyStatus: CurrencyStatus.loading));

    final result = await _repository.fetchCurrencySymbols(
        accessKey: accessKey, baseUrl: baseUrl);
    result.fold(
      (error) => emit(state.copyWith(
          currencyStatus: CurrencyStatus.error,
          currencyErrorMessage: error)),
      (symbols) {
        // pick a sensible default currency if available
        final defaultCurrency = symbols.containsKey('USD')
            ? 'USD'
            : (symbols.keys.isNotEmpty ? symbols.keys.first : null);
        emit(state.copyWith(
            currencyStatus: CurrencyStatus.success,
            //get first 15 symbols to avoid overwhelming the user with USD for sure as it is needed
            currencySymbols: Map.fromEntries(symbols.entries.take(10)),
            ));
      },
    );
  }

  void setSelectedCurrency(String currencyCode) {
    emit(state.copyWith(selectedCurrency: currencyCode));
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
