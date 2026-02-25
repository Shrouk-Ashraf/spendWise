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
      return Left('Failed to load transactions ${e.toString()}' );
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

  Future<Either<String,TransactionModel>> getById(String id) async {
    try {
      final transaction = await _dataSource.getTransactionById(id);
      return Right(transaction);
    } catch (e) {
      return Left('Failed to get transaction by id');
    }
  }

  Future<Either<String, Map<String, String>>> fetchCurrencySymbols({required String accessKey, String baseUrl = 'https://api.exchangeratesapi.io/v1'}) async {
    try {
      final symbols = await _dataSource.fetchCurrencySymbols(accessKey: accessKey, baseUrl: baseUrl);
      return Right(symbols);
    } catch (e) {
      return Left('Failed to fetch currency symbols: ${e.toString()}');
    }
  }
}