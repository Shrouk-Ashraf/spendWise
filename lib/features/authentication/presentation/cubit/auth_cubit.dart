import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:spendwise/features/authentication/data/models/user_model.dart';
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
      (error) =>
          emit(state.copyWith(status: AuthStatus.error, errorMessage: error)),
      (user) {
        _repository.saveUser(
          UserModel(
            email: email,
            name: user.user?.displayName ?? '',
            avatarInitial: email.isNotEmpty ? email[0].toUpperCase() : '?',
            createdAt: DateTime.now(),
          ),
        );
        emit(state.copyWith(status: AuthStatus.success, user: user));
      },
    );
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await _repository.signUp(
      email: email,
      password: password,
      name: name,
    );
    result.fold(
      (error) =>
          emit(state.copyWith(status: AuthStatus.error, errorMessage: error)),
      (user) => emit(state.copyWith(status: AuthStatus.success, user: user)),
    );
  }

  Future<void> signOut() async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await _repository.signOut();

    result.fold(
      (error) =>
          emit(state.copyWith(status: AuthStatus.error, errorMessage: error)),
      (_) => emit(state.copyWith(status: AuthStatus.initial)),
    );
  }
}
