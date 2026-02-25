import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repository/dashboard_repository.dart';
import '../../../../features/transactions/data/models/transaction_model.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final DashboardRepository _repository;

  DashboardCubit(this._repository) : super(const DashboardState());

  Future<void> loadRecent({int count = 10}) async {
    emit(state.copyWith(status: DashboardStatus.loading));
    final result = _repository.getRecent(count: count);
    result.fold(
      (error) => emit(state.copyWith(status: DashboardStatus.error, errorMessage: error)),
      (transactions) => emit(state.copyWith(status: DashboardStatus.success, transactions: transactions)),
    );
  }
}
