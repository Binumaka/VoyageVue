import 'dart:io';

import 'package:voyagevue/core/network/hive_service.dart';
import 'package:voyagevue/features/auth/data/data_source/auth_data_source.dart';
import 'package:voyagevue/features/auth/data/model/auth_hive_model.dart';
import 'package:voyagevue/features/auth/domain/entity/auth_entity.dart';

class AuthLocalDatasource implements IAuthDataSource{
  final HiveService _hiveService;

  AuthLocalDatasource(this._hiveService);

  @override
  Future<AuthEntity> getCurrentUser() {
    //Return Empty AuthEntity
    return Future.value(AuthEntity(
      userId: "1",
      email: "",
      image: "",
      username: "",
      password: "",
      ));
  }

  @override
  Future<String> loginUser(String email, String password) async {
    try{
      await _hiveService.login(email, password);
      return Future.value("Success");
    }catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> registerUser(AuthEntity user) async {
    try{
      //convert AuthEntity to AuthHiveModel
      final authHiveModel = AuthHiveModel.fromEntity(user);
      await _hiveService.register(authHiveModel);
      return Future.value();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) {
    throw UnimplementedError();
  }
  
  @override
  Future<void> updateUser(AuthEntity user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}