import 'package:dartz/dartz.dart';

import '../../../../features/transactions/data/models/transaction_model.dart';
import '../data_source/dashboard_data_source.dart';

class DashboardRepository {
  final DashboardDataSource _dataSource;
  DashboardRepository(this._dataSource);

  /// Returns up to [count] most recent transactions wrapped in Either.
  Either<String, List<TransactionModel>> getRecent({int count = 10}) {
    try {
      final list = _dataSource.getRecent(count: count);
      return Right(list);
    } catch (e) {
      return Left('Failed to load recent transactions: ${e.toString()}');
    }
  }

  /// Backwards compatible: get 10 items.
  Either<String, List<TransactionModel>> getRecentTen() => getRecent(count: 10);
}
