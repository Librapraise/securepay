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

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isMobile = screenWidth < 600;
        final isTablet = screenWidth >= 600 && screenWidth < 960;
        final showSidebar = screenWidth >= 960;
        final horizontalPadding = isMobile ? 16.0 : (isTablet ? 24.0 : 40.0);

        final sidebarWidget = DashboardSidebar(
          selectedIndex: _selectedNavIndex,
          onItemSelected: (index) {
            setState(() => _selectedNavIndex = index);
            if (!showSidebar) {
              Navigator.of(context).maybePop();
            }
          },
          onLogout: () {
            if (!showSidebar) {
              Navigator.of(context).maybePop();
            }
            context.read<AuthProvider>().logout();
          },
          userName: userName.isNotEmpty ? userName : 'Firstname Lastname',
        );

        return Scaffold(
          backgroundColor: const Color(0xFFFAFAFC),
          drawer: showSidebar ? null : Drawer(child: sidebarWidget),
          body: Row(
            children: [
              // Fixed Left Sidebar Navigation (Desktop only)
              if (showSidebar) sidebarWidget,

              // Main Scrollable Content Area
              Expanded(
                child: Column(
                  children: [
                    // Top Header: Title, subtitle, and hamburger icon for mobile/tablet
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: isMobile ? 12 : 20,
                      ),
                      color: Colors.white,
                      child: Row(
                        children: [
                          if (!showSidebar) ...[
                            Builder(
                              builder: (headerContext) {
                                return IconButton(
                                  icon: const Icon(Icons.menu, color: Color(0xFF1E293B)),
                                  tooltip: 'Open Menu',
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                                  onPressed: () {
                                    Scaffold.of(headerContext).openDrawer();
                                  },
                                );
                              },
                            ),
                            const SizedBox(width: 8),
                          ],
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Invite & Earn',
                                  style: TextStyle(
                                    fontSize: isMobile ? 15 : 16,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF1E293B),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Keep track of your addresses, location updates. Edit, Delete, Update and see all your saved addresses',
                                  style: TextStyle(
                                    fontSize: isMobile ? 10 : 11,
                                    color: const Color(0xFF94A3B8),
                                  ),
                                  maxLines: isMobile ? 1 : 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Divider(height: 1, color: Color(0xFFF1F5F9)),

                    // Scrollable Body Content
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: isMobile ? 16 : 24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Promo / Action Hero Banner
                            const DashboardTopBanner(),

                            SizedBox(height: isMobile ? 20 : 32),

                            // Overview Header with Filter dropdown
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Overview',
                                  style: TextStyle(
                                    fontSize: isMobile ? 16 : 18,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF1E293B),
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
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF64748B),
                                          fontWeight: FontWeight.w500,
                                        ),
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
                            _buildOverviewCards(),

                            SizedBox(height: isMobile ? 24 : 32),

                            // Recent shipment Section Header
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Recent shipment',
                                  style: TextStyle(
                                    fontSize: isMobile ? 16 : 18,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF1E293B),
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
                              padding: EdgeInsets.all(isMobile ? 16 : 24),
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
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: isMobile ? 8 : 14,
                                                  vertical: 4,
                                                ),
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
                                                    fontSize: isMobile ? 11 : 12,
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
                                  SizedBox(height: isMobile ? 16 : 24),
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
      },
    );
  }

  Widget _buildOverviewCards() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        if (width >= 900) {
          // Full desktop view: 4 cards side by side
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
        } else if (width >= 600) {
          // Medium / Tablet view: Wallet on top, 3 cards in a row below
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  SizedBox(width: 14),
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
                  SizedBox(width: 14),
                  Expanded(
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
              ),
            ],
          );
        } else {
          // Mobile view (<600px): Wallet card spans full width, followed by Total Shipment full width, and Exports/Imports 2-column row
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              WalletBalanceCard(
                balance: '₦3,000,000.28',
                onFundWallet: () {},
              ),
              const SizedBox(height: 12),
              const StatSummaryCard(
                icon: Icons.local_shipping_outlined,
                iconColor: AppColors.statShipmentIcon,
                iconBgColor: AppColors.statShipmentBg,
                title: 'Total Shipment',
                count: '34',
                changePercentage: '20%',
                comparisonText: 'Vs last month: 4',
              ),
              const SizedBox(height: 12),
              const Row(
                children: [
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
                  SizedBox(width: 12),
                  Expanded(
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
              ),
            ],
          );
        }
      },
    );
  }
}


