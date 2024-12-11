
import 'package:flutter/material.dart';
import 'package:voyagevue/view/loginview.dart';
import 'package:voyagevue/view/registerview.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Registerview(),
    );
  }
}