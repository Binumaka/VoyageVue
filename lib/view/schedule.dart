import 'package:flutter/material.dart';

class Schedule extends StatelessWidget {
  const Schedule({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Schedule",
          style: TextStyle(
              fontFamily: 'Junge', fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
