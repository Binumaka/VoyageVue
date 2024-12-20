import 'package:flutter/material.dart';

class Bucketlistview extends StatelessWidget {
  const Bucketlistview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text(
        "Bucketlist",
        style: TextStyle(
            fontFamily: 'Junge', fontSize: 24, fontWeight: FontWeight.w600),
      )),
    );
  }
}
