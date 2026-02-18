import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:spendwise/core/networking/error_handler.dart';

class ResponseHandler{
  static Future<Either<String,T>> handleResponse<T>({required Future<T> Function() onSuccess})async{
    try{
      final f = await onSuccess();
      return Right(f);
    } on SocketException {
      return const Left("Check your internet connection and try again.");
    }on FirebaseException catch (e){
      final f = ErrorHandler.handleError(e);
      return Left(f);
    }on Exception catch (e){
      final f = ErrorHandler.handleError(e);
      return Left(f);
    }catch (e) {
      return const Left("An unexpected error occurred. Please try again.");
    }
  }
}