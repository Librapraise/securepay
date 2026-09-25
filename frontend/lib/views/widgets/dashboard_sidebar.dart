import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class DashboardSidebar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final VoidCallback onLogout;
  final String userName;

  const DashboardSidebar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.onLogout,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    final navItems = [
      {'icon': Icons.dashboard_outlined, 'activeIcon': Icons.dashboard, 'title': 'Dashboard'},
      {'icon': Icons.local_shipping_outlined, 'activeIcon': Icons.local_shipping, 'title': 'Shipments'},
      {'icon': Icons.public_outlined, 'activeIcon': Icons.public, 'title': 'Our Services'},
      {'icon': Icons.notifications_none_outlined, 'activeIcon': Icons.notifications, 'title': 'Notifications'},
      {'icon': Icons.account_balance_wallet_outlined, 'activeIcon': Icons.account_balance_wallet, 'title': 'Wallet'},
      {'icon': Icons.explore_outlined, 'activeIcon': Icons.explore, 'title': 'My Addresses'},
      {'icon': Icons.card_giftcard_outlined, 'activeIcon': Icons.card_giftcard, 'title': 'Invite & Earn'},
      {'icon': Icons.headset_mic_outlined, 'activeIcon': Icons.headset_mic, 'title': 'Help Center'},
    ];

    return Container(
      width: 220,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(color: Color(0xFFEFF0F6), width: 1.2),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 24),
          // Navigation items list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: navItems.length,
              itemBuilder: (context, index) {
                final item = navItems[index];
                final isSelected = selectedIndex == index;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: InkWell(
                    onTap: () => onItemSelected(index),
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.sidebarActiveNav : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isSelected ? (item['activeIcon'] as IconData) : (item['icon'] as IconData),
                            size: 20,
                            color: isSelected ? Colors.white : AppColors.sidebarTextMuted,
                          ),
                          const SizedBox(width: 14),
                          Text(
                            item['title'] as String,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                              color: isSelected ? Colors.white : const Color(0xFF4A5568),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // User Profile & Logout Section at bottom
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // User info avatar & name
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/user_avatar.png',
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return CircleAvatar(
                            radius: 20,
                            backgroundColor: const Color(0xFFE2E8F0),
                            child: Text(
                              userName.isNotEmpty ? userName[0].toUpperCase() : 'U',
                              style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF4A5568)),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName.isNotEmpty ? userName : 'Firstname Lastname',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1E293B),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Text(
                            'Active',
                            style: TextStyle(fontSize: 11, color: Color(0xFF10B981)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                const SizedBox(height: 12),
                // Logout button
                InkWell(
                  onTap: onLogout,
                  borderRadius: BorderRadius.circular(8),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    child: Row(
                      children: [
                        Icon(Icons.logout, size: 20, color: Color(0xFF64748B)),
                        SizedBox(width: 12),
                        Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF475569),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
