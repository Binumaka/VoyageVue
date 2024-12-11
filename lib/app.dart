
import 'package:flutter/material.dart';
import 'package:voyagevue/view/loginview.dart';
import 'package:voyagevue/view/registerview.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(context) => const Loginview(),
        '/register': (context) => const Registerview(),
      },
  );
  }
}