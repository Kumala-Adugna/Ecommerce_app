import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/presentation/providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),

      appBar: AppBar(title: const Text('Profile'), centerTitle: true),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const CircleAvatar(radius: 45, child: Icon(Icons.person, size: 50)),

            const SizedBox(height: 16),

            const Text(
              'Welcome User',

              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Card(
              elevation: 2,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),

              child: const ListTile(
                leading: Icon(Icons.person_outline),

                title: Text('Username'),

                subtitle: Text('mor_2314'),
              ),
            ),

            const SizedBox(height: 12),

            Card(
              elevation: 2,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),

              child: const ListTile(
                leading: Icon(Icons.email_outlined),

                title: Text('Email'),

                subtitle: Text('User email'),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,

              height: 55,

              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,

                  foregroundColor: Colors.white,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),

                icon: const Icon(Icons.logout),

                label: const Text('Logout'),

                onPressed: () {
                  ref.read(authProvider.notifier).logout();

                  context.go('/login');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
