import 'package:flutter/material.dart';

class Dashboardview extends StatelessWidget {
  const Dashboardview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 199, 179, 234),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
        ),
      ),
      body: const Center(
        child: Text(
          "Dashboard",
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}