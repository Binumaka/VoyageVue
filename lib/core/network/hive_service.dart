import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:voyagevue/app/constants/hive_table_constant.dart';
import 'package:voyagevue/features/auth/data/model/auth_hive_model.dart';
import 'package:voyagevue/features/destination/data/model/destination_hive_model.dart';

class HiveService {
  static Future<void> init() async {
    //Initialize the database
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}voyagevue.db';

    Hive.init(path);

    //Register Adapters
    Hive.registerAdapter(AuthHiveModelAdapter());
    Hive.registerAdapter(DestinationHiveModelAdapter());
  }

  //=================Destination Queries==================
  Future<void> addDestination(DestinationHiveModel destination) async{
    var box = await Hive.openBox<DestinationHiveModel>(HiveTableConstant.destinationBox);
    await box.put(destination.id, destination);
  }

  Future<void> deleteDestination(String id) async {
    var box = await Hive.openBox<DestinationHiveModel>(HiveTableConstant.destinationBox);
    await box.delete(id);
  }

  Future<List<DestinationHiveModel>> getDestinations() async {
    var box = await Hive.openBox<DestinationHiveModel>(HiveTableConstant.destinationBox);
    return box.values.toList();
  }

  Future<DestinationHiveModel?> getDestinationById(String id) async {
    var box = await Hive.openBox<DestinationHiveModel>(HiveTableConstant.destinationBox);
    return box.get(id);
  }

  Future<void> updateDestination(DestinationHiveModel destination) async {
    var box = await Hive.openBox<DestinationHiveModel>(HiveTableConstant.destinationBox);
    await box.put(destination.id, destination);
  }

  Future<List<DestinationHiveModel>> getDestinationsBySection(String section) async {
    var box = await Hive.openBox<DestinationHiveModel>(HiveTableConstant.destinationBox);
    return box.values.where((element) => element.section == section).toList();
  }

  Future<List<DestinationHiveModel>> getDestinationsByCategory(String category) async {
    var box = await Hive.openBox<DestinationHiveModel>(HiveTableConstant.destinationBox);
    return box.values.where((element) => element.category == category).toList();
  }

  Future<void> clearDestinationBox() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.destinationBox);
  }

  //==================Auth Queries========================
  Future<void> register(AuthHiveModel auth) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.put(auth.userId, auth);
  }

  Future<void> deleteAuth(String id) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.delete(id);
  }

  Future<List<AuthHiveModel>> getAllAuth() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    return box.values.toList();
  }

  // Login using username and password
  Future<AuthHiveModel?> login(String username, String password) async {
    // var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
    // var auth = box.values.firstWhere(
    //     (element) =>
    //         element.username == username && element.password == password,
    //     orElse: () => AuthHiveModel.initial());
    // return auth;

    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var user = box.values.firstWhere((element) =>
        element.username == username && element.password == password);
    box.close();
    return user;
  }

  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
    await Hive.deleteBoxFromDisk(HiveTableConstant.destinationBox);
  }

  // Clear User Box
  Future<void> clearUserBox() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
  }

  Future<void> close() async {
    await Hive.close();
  }
}