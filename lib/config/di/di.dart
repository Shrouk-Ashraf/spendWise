import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spendwise/features/authentication/data/data_source/auth_data_source.dart';

import '../../features/authentication/data/repository/auth_repository.dart';
import '../../features/authentication/presentation/cubit/auth_cubit.dart';
import '../../features/transactions/data/data_source/transaction_data_source.dart';
import '../../features/transactions/data/repository/transactions_repository.dart';
import '../../features/transactions/add_transaction/presentation/cubit/add_transaction_cubit.dart';

/// Service locator instance
final sl = GetIt.instance;

Future<void> setupDI(SharedPreferences prefs) async {
  // SharedPreferences instance
  sl.registerSingleton<SharedPreferences>(prefs);
  // Firebase
  sl.registerLazySingleton(() => FirebaseAuth.instance);

  // Data Source
  sl.registerLazySingleton<AuthDataSource>(() => AuthDataSource(sl(),sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepository(sl()));

  // Cubit
  sl.registerLazySingleton<AuthCubit>(() => AuthCubit(sl()));

  sl.registerLazySingleton(() => TransactionDataSource(sl()));
  sl.registerLazySingleton(() => TransactionRepository(sl()));
  sl.registerFactory(() => TransactionCubit(sl()));
}
