import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:spendwise/core/networking/local_storage_service.dart';
import 'package:spendwise/core/networking/network_info.dart';
import 'package:spendwise/features/authentication/data/data_source/auth_data_source.dart';

import '../../features/authentication/data/repository/auth_repository.dart';
import '../../features/authentication/presentation/cubit/auth_cubit.dart';

/// Service locator instance
final sl = GetIt.instance;

Future<void> setupDI() async {
  // Firebase
  sl.registerLazySingleton(() => FirebaseAuth.instance);

  // Data Source
  sl.registerLazySingleton<AuthDataSource>(() => AuthDataSource(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepository(sl()));

  // Cubit
  sl.registerLazySingleton<AuthCubit>(() => AuthCubit(sl()));
}
