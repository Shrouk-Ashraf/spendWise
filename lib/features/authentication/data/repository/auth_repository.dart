import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spendwise/core/networking/error_handler.dart';
import 'package:spendwise/core/networking/response_handler.dart';
import 'package:spendwise/features/authentication/data/data_source/auth_data_source.dart';

class AuthRepository{
  final AuthDataSource _authDataSource;
  AuthRepository(this._authDataSource);

  Future<Either<String,UserCredential>> signIn({
    required String email,
    required String password,
  }) async {
    return  ResponseHandler.handleResponse(onSuccess: ()async{
      final result = await _authDataSource.signIn(email: email, password: password);
      return result;
    });
  }

  Future<Either<String,UserCredential>> signUp({
    required String email,
    required String password,
  }) async {
    return  ResponseHandler.handleResponse(onSuccess: ()async{
      final result = await _authDataSource.signUp(email: email, password: password);
      return result;
    });
  }
}