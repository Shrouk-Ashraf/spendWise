import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:spendwise/features/authentication/data/repository/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repository;
  AuthCubit(this._repository) : super(AuthState());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

  Future<void> signIn({required String email, required String password}) async {
    emit(state.copyWith(status: AuthStatus.loading));
      final result = await _repository.signIn(email: email, password: password);
      result.fold(
        (error) => emit(state.copyWith(status: AuthStatus.error, errorMessage: error)),
        (user) => emit(state.copyWith(status: AuthStatus.success, user: user)),
      );
  }

  Future<void> signUp({required String email, required String password}) async {
    emit(state.copyWith(status: AuthStatus.loading));
      final result = await _repository.signUp(email: email, password: password);
      result.fold(
        (error) => emit(state.copyWith(status: AuthStatus.error, errorMessage: error)),
        (user) => emit(state.copyWith(status: AuthStatus.success, user: user)),
      );
  }
}
