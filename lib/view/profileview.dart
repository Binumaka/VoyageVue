import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voyagevue/core/common/snackbar/my_snackbar.dart';
import 'package:voyagevue/features/home/presentation/view_model/home_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Picture
            const SizedBox(height: 20),
            const Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/blankprofile.png'),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Binu',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'binu@gmail.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),

            // Profile Options
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.blueAccent),
              title: const Text('Edit Profile'),
              onTap: () {
                // Navigate to Edit Profile Screen
              },
            ),
            const Divider(),

            ListTile(
              leading: const Icon(Icons.settings, color: Colors.blueAccent),
              title: const Text('Settings'),
              onTap: () {
                // Navigate to Settings Screen
              },
            ),
            const Divider(),

            ListTile(
              leading: const Icon(Icons.help, color: Colors.blueAccent),
              title: const Text('Help & Support'),
              onTap: () {
                // Navigate to Help & Support Screen
              },
            ),
            const Divider(),

            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                // Logout code
                showMySnackBar(
                  context: context,
                  message: 'Logging out...',
                  color: Colors.red,
                );

                context.read<HomeCubit>().logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
