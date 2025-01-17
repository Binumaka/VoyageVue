import 'package:flutter/material.dart';
import 'package:voyagevue/app/app.dart';
import 'package:voyagevue/app/di/di.dart';
import 'package:voyagevue/core/network/hive_service.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();

  await initDependencies();
  runApp(
    App()
  );
}