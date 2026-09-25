import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/auth_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Myafrimall Dashboard', style: TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.white,
        elevation: 0.5,
        actions: [
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout, color: AppColors.error),
            onPressed: () => context.read<AuthProvider>().logout(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back, ${user?.firstName ?? "User"}!',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textHeading),
            ),
            const SizedBox(height: 8),
            Text(
              'Account Email: ${user?.email ?? "N/A"} | Phone: ${user?.phoneNumber ?? "N/A"}',
              style: const TextStyle(fontSize: 15, color: AppColors.textSubheading),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.flight_takeoff, color: AppColors.primary, size: 36),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Ready to ship to 300+ countries from Nigeria. Your session is authenticated with JWT.',
                      style: TextStyle(fontSize: 16, color: AppColors.primaryDark, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
