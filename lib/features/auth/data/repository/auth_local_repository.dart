import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:voyagevue/core/error/failure.dart';
import 'package:voyagevue/features/auth/data/data_source/local_data_source/auth_local_datasource.dart';
import 'package:voyagevue/features/auth/domain/entity/auth_entity.dart';
import 'package:voyagevue/features/auth/domain/repository/auth_repository.dart';

class AuthLocalRepository implements IAuthRepository {
  final AuthLocalDatasource _authLocalDataSource;

  AuthLocalRepository(this._authLocalDataSource);

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() async {
    try {
      final currentUser = await _authLocalDataSource.getCurrentUser();
      return Right(currentUser);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> loginUser(
    String email,
    String password,
  ) async {
    try {
      final token = await _authLocalDataSource.loginUser(email, password);
      return Right(token);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerUser(AuthEntity user) async {
    try {
      return Right(_authLocalDataSource.registerUser(user));
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, void>> updateUser(AuthEntity user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
