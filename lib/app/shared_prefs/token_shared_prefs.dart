import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyagevue/core/error/failure.dart';

class TokenSharedPrefs {
  final SharedPreferences _sharedPreferences;

  TokenSharedPrefs(this._sharedPreferences);

  Future<Either<Failure, void>> saveToken(String token) async{
    try{
      await _sharedPreferences.setString('token', token);
      return Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message:e.toString()));
    }
  }

  Future<Either<Failure,String>> getToken() async {
    try{
      final token = _sharedPreferences.getString('token');
      return Right(token ?? '');
    }catch(e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }
  
  // Remove token
  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  // Save user ID
  Future<void> saveUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
  }

  // Get user ID
  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  // Remove user ID
  Future<void> removeUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
  }

  // Remove both user ID and token
  Future<void> clearUserData() async {
    await _sharedPreferences.remove('token');
    await _sharedPreferences.remove('userId');
    await _sharedPreferences.remove('username');
  }
}