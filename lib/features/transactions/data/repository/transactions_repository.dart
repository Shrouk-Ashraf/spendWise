import 'package:dartz/dartz.dart';
import '../data_source/transaction_data_source.dart';
import '../models/transaction_model.dart';

class TransactionRepository {
  final TransactionDataSource _dataSource;
  TransactionRepository(this._dataSource);

  // ── Get all ───────────────────────────────────────────────────────────────
  Either<String, List<TransactionModel>> getAll() {
    try {
      return Right(_dataSource.getAll());
    } catch (e) {
      return Left('Failed to load transactions');
    }
  }

  // ── Save ──────────────────────────────────────────────────────────────────
  Future<Either<String, void>> save(TransactionModel transaction) async {
    try {
      await _dataSource.save(transaction);
      return const Right(null);
    } catch (e) {
      return Left('Failed to save transaction');
    }
  }

  // ── Delete ────────────────────────────────────────────────────────────────
  Future<Either<String, void>> delete(String id) async {
    try {
      await _dataSource.delete(id);
      return const Right(null);
    } catch (e) {
      return Left('Failed to delete transaction');
    }
  }
}