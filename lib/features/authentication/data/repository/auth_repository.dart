import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spendwise/core/networking/error_handler.dart';
import 'package:spendwise/core/networking/response_handler.dart';
import 'package:spendwise/features/authentication/data/data_source/auth_data_source.dart';
import 'package:spendwise/features/authentication/data/models/user_model.dart';

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

  Future<void> saveUser(UserModel user) async {
    await _authDataSource.saveUser(user);
  }

  Future<Either<String,UserCredential>> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    return  ResponseHandler.handleResponse(onSuccess: ()async{
      final result = await _authDataSource.signUp(email: email, password: password);
      final user = UserModel.fromSignUp(email: email, name: name);
      await _authDataSource.saveUser(user);
      return result;
    });
  }

  Future<Either<String, void>> signOut() async {
    return ResponseHandler.handleResponse(onSuccess: () async {
      await _authDataSource.deleteUser();
    });
  }

  UserModel? getUser() => _authDataSource.getUser();
}