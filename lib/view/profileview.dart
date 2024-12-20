import 'package:flutter/material.dart';

class Profileview extends StatelessWidget {
  const Profileview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        "Profile",
        style: TextStyle(
            fontFamily: 'Junge', fontSize: 24, fontWeight: FontWeight.w600),
      )),
    );
  }
}
