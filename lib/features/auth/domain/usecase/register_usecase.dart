import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:voyagevue/app/usecase/usecase.dart';
import 'package:voyagevue/core/error/failure.dart';
import 'package:voyagevue/features/auth/domain/entity/auth_entity.dart';
import 'package:voyagevue/features/auth/domain/repository/auth_repository.dart';

class RegisterUserParams extends Equatable {
  final String email;
  final String username;
  final String password;
  final String? image;

  const RegisterUserParams({
    required this.email,
    required this.username,
    required this.password,
    this.image,
  });

  //intial constructor
  const RegisterUserParams.initial({
    required this.email,
    required this.username,
    required this.password,
    this.image,
  });

  @override
  List<Object?> get props =>
      [email, username, password];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
      email: params.email,
      username: params.username,
      password: params.password,
      image: params.image,
    );
    return repository.registerUser(authEntity);
  }
}
