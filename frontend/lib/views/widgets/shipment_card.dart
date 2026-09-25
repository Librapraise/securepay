import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class ShipmentCard extends StatefulWidget {
  final String trackingId;
  final String sender;
  final String receiver;
  final String pickUpFrom;
  final String deliveryTo;
  final String amount;
  final String processingTime;
  final String status;
  final bool isPaid;
  final bool initialExpanded;

  const ShipmentCard({
    super.key,
    required this.trackingId,
    required this.sender,
    required this.receiver,
    required this.pickUpFrom,
    required this.deliveryTo,
    required this.amount,
    required this.processingTime,
    required this.status,
    required this.isPaid,
    this.initialExpanded = true,
  });

  @override
  State<ShipmentCard> createState() => _ShipmentCardState();
}

class _ShipmentCardState extends State<ShipmentCard> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initialExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDelayed = widget.status.toLowerCase().contains('delayed');

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF3F4F6), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header / Top Summary Bar
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tracking ID',
                          style: TextStyle(fontSize: 11, color: AppColors.textSubheading),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.trackingId,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4C63B6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sender',
                          style: TextStyle(fontSize: 11, color: AppColors.textSubheading),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.sender,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Receiver',
                          style: TextStyle(fontSize: 11, color: AppColors.textSubheading),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.receiver,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: const Color(0xFF64748B),
                    size: 22,
                  ),
                ],
              ),
            ),
          ),

          // Collapsible Details
          if (_isExpanded) ...[
            const Divider(height: 1, color: Color(0xFFF1F5F9)),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Middle Row: Pick Up, Delivery To, Amount, Status Badge
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Pick Up
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Pick Up From',
                              style: TextStyle(fontSize: 11, color: AppColors.textSubheading),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                _buildNigeriaFlag(),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    widget.pickUpFrom,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF1E293B),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Delivery To
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Delivery To',
                              style: TextStyle(fontSize: 11, color: AppColors.textSubheading),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                _buildNigeriaFlag(),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    widget.deliveryTo,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF1E293B),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Amount
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Amount',
                              style: TextStyle(fontSize: 11, color: AppColors.textSubheading),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              widget.amount,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Status Badge
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Status',
                            style: TextStyle(fontSize: 11, color: AppColors.textSubheading),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: isDelayed ? AppColors.delayedBg : AppColors.inTransitBg,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              widget.status,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: isDelayed ? AppColors.delayedText : AppColors.inTransitText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Processing Time and Action Buttons
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Processing time',
                            style: TextStyle(fontSize: 11, color: AppColors.textSubheading),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.timer_outlined, size: 16, color: Color(0xFF64748B)),
                              const SizedBox(width: 6),
                              Text(
                                widget.processingTime,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      // View More button
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFCBD5E1)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          minimumSize: Size.zero,
                        ),
                        child: const Text(
                          'View More',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF334155),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Paid / Pay Now button
                      ElevatedButton(
                        onPressed: widget.isPaid ? null : () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: widget.isPaid ? const Color(0xFFF1F5F9) : const Color(0xFF262D4A),
                          disabledBackgroundColor: const Color(0xFFF1F5F9),
                          foregroundColor: widget.isPaid ? const Color(0xFF94A3B8) : Colors.white,
                          disabledForegroundColor: const Color(0xFF94A3B8),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                          minimumSize: Size.zero,
                        ),
                        child: Text(
                          widget.isPaid ? 'Paid' : 'Pay Now',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: widget.isPaid ? const Color(0xFF94A3B8) : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNigeriaFlag() {
    return Container(
      width: 16,
      height: 12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 0.5),
      ),
      child: Row(
        children: [
          Expanded(child: Container(color: const Color(0xFF008751))),
          Expanded(child: Container(color: Colors.white)),
          Expanded(child: Container(color: const Color(0xFF008751))),
        ],
      ),
    );
  }
}
