import 'package:flutter/material.dart';

class Bookinglistview extends StatelessWidget {
  const Bookinglistview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text(
        "Bookings",
        style: TextStyle(
            fontFamily: 'Junge', fontSize: 24, fontWeight: FontWeight.w600),
      )),
    );
  }
}
