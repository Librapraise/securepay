import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../widgets/dashboard_sidebar.dart';
import '../widgets/dashboard_top_banner.dart';
import '../widgets/overview_cards.dart';
import '../widgets/company_growth_chart.dart';
import '../widgets/shipment_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedNavIndex = 0;
  final String _selectedOverviewPeriod = 'This Month';
  String _selectedGrowthFilter = 'Year';

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;
    final userName = user != null
        ? '${user.firstName} ${user.lastName}'.trim()
        : 'Firstname Lastname';

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFC),
      body: Row(
        children: [
          // Fixed Left Sidebar Navigation
          DashboardSidebar(
            selectedIndex: _selectedNavIndex,
            onItemSelected: (index) {
              setState(() => _selectedNavIndex = index);
            },
            onLogout: () => context.read<AuthProvider>().logout(),
            userName: userName.isNotEmpty ? userName : 'Firstname Lastname',
          ),

          // Main Scrollable Content Area
          Expanded(
            child: Column(
              children: [
                // Top Header: Title and subtitle
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  color: Colors.white,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Invite & Earn',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Keep track of your addresses, location updates. Edit, Delete, Update and see all your saved addresses',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(height: 1, color: Color(0xFFF1F5F9)),

                // Scrollable Body Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Promo / Action Hero Banner
                        const DashboardTopBanner(),

                        const SizedBox(height: 32),

                        // Overview Header with Filter dropdown
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Overview',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: const Color(0xFFE2E8F0)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    _selectedOverviewPeriod,
                                    style: const TextStyle(fontSize: 12, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(Icons.keyboard_arrow_down, size: 16, color: Color(0xFF64748B)),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Overview Cards Grid (Balance + 3 Statistics)
                        LayoutBuilder(
                          builder: (context, constraints) {
                            if (constraints.maxWidth > 900) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: WalletBalanceCard(
                                      balance: '₦3,000,000.28',
                                      onFundWallet: () {},
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  const Expanded(
                                    flex: 2,
                                    child: StatSummaryCard(
                                      icon: Icons.local_shipping_outlined,
                                      iconColor: AppColors.statShipmentIcon,
                                      iconBgColor: AppColors.statShipmentBg,
                                      title: 'Total Shipment',
                                      count: '34',
                                      changePercentage: '20%',
                                      comparisonText: 'Vs last month: 4',
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  const Expanded(
                                    flex: 2,
                                    child: StatSummaryCard(
                                      icon: Icons.arrow_upward,
                                      iconColor: AppColors.statExportIcon,
                                      iconBgColor: AppColors.statExportBg,
                                      title: 'Total Exports',
                                      count: '34',
                                      changePercentage: '20%',
                                      comparisonText: 'Vs last month: 4',
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  const Expanded(
                                    flex: 2,
                                    child: StatSummaryCard(
                                      icon: Icons.arrow_downward,
                                      iconColor: AppColors.statImportIcon,
                                      iconBgColor: AppColors.statImportBg,
                                      title: 'Total Import',
                                      count: '34',
                                      changePercentage: '20%',
                                      comparisonText: 'Vs last month: 4',
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  WalletBalanceCard(
                                    balance: '₦3,000,000.28',
                                    onFundWallet: () {},
                                  ),
                                  const SizedBox(height: 16),
                                  const Row(
                                    children: [
                                      Expanded(
                                        child: StatSummaryCard(
                                          icon: Icons.local_shipping_outlined,
                                          iconColor: AppColors.statShipmentIcon,
                                          iconBgColor: AppColors.statShipmentBg,
                                          title: 'Total Shipment',
                                          count: '34',
                                          changePercentage: '20%',
                                          comparisonText: 'Vs last month: 4',
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Expanded(
                                        child: StatSummaryCard(
                                          icon: Icons.arrow_upward,
                                          iconColor: AppColors.statExportIcon,
                                          iconBgColor: AppColors.statExportBg,
                                          title: 'Total Exports',
                                          count: '34',
                                          changePercentage: '20%',
                                          comparisonText: 'Vs last month: 4',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }
                          },
                        ),

                        const SizedBox(height: 32),

                        // Recent shipment Section Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Recent shipment',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Color(0xFFE2E8F0)),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                minimumSize: Size.zero,
                              ),
                              child: const Text(
                                'See All',
                                style: TextStyle(fontSize: 12, color: Color(0xFF64748B), fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Company Growth Analytics Card with Custom Catmull-Rom Spline
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: const Color(0xFFF1F3F9), width: 1.2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.02),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Company Growth',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF1E293B),
                                    ),
                                  ),
                                  // Year / Month / Week tab selector
                                  Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF8FAFC),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: const Color(0xFFE2E8F0)),
                                    ),
                                    child: Row(
                                      children: ['Year', 'Month', 'Week'].map((tab) {
                                        final isSelected = _selectedGrowthFilter == tab;
                                        return InkWell(
                                          onTap: () => setState(() => _selectedGrowthFilter = tab),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: isSelected ? Colors.white : Colors.transparent,
                                              borderRadius: BorderRadius.circular(6),
                                              boxShadow: isSelected
                                                  ? [
                                                      BoxShadow(
                                                        color: Colors.black.withValues(alpha: 0.05),
                                                        blurRadius: 4,
                                                        offset: const Offset(0, 1),
                                                      )
                                                    ]
                                                  : null,
                                            ),
                                            child: Text(
                                              tab,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                                color: isSelected ? const Color(0xFF1E293B) : const Color(0xFF94A3B8),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              const CompanyGrowthChart(),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Recent Shipments Accordion Cards
                        const ShipmentCard(
                          trackingId: 'MAF-100-234-291',
                          sender: 'Bunmi Tanny',
                          receiver: 'Mercy',
                          pickUpFrom: 'Lagos, Nigeria',
                          deliveryTo: 'Oyo Nigeria',
                          amount: 'N3000',
                          processingTime: '10 hours',
                          status: 'In-Transit',
                          isPaid: true,
                          initialExpanded: true,
                        ),

                        const ShipmentCard(
                          trackingId: 'MAF-100-234-291',
                          sender: 'Bunmi Tanny',
                          receiver: 'Mercy',
                          pickUpFrom: 'Lagos, Nigeria',
                          deliveryTo: 'Oyo Nigeria',
                          amount: 'N3000',
                          processingTime: '10 hours',
                          status: 'Delayed',
                          isPaid: false,
                          initialExpanded: true,
                        ),

                        const ShipmentCard(
                          trackingId: 'MAF-100-234-291',
                          sender: 'Bunmi Tanny',
                          receiver: 'Mercy',
                          pickUpFrom: 'Lagos, Nigeria',
                          deliveryTo: 'Oyo Nigeria',
                          amount: 'N3000',
                          processingTime: '10 hours',
                          status: 'In-Transit',
                          isPaid: true,
                          initialExpanded: false,
                        ),

                        const SizedBox(height: 40),
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
