import 'package:flutter/material.dart';

import 'widgets/profile_header_widget.dart';
import 'widgets/profile_menu_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ProfileHeaderWidget(),
            // const SizedBox(height: 16),
            // const ProfileStatsWidget(),
            const SizedBox(height: 16),
            const ProfileMenuWidget(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
