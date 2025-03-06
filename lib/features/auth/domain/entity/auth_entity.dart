import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? id;
  final String email;
  final String? image;
  final String role;
  final String username;
  final String? password;

  const AuthEntity({
    this.id,
    required this.email,
    this.image,
    this.role = 'user', //Default role to 'user'
    required this.username,
    this.password,
  });

  @override
  List<Object?> get props =>
      [id, email, image, role, username, password];

  toJson() {}
}
