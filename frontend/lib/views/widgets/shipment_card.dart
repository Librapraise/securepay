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
    final isDelayed = widget.status.toLowerCase() == 'delayed';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < 620;
          final isVeryCompact = constraints.maxWidth < 420;

          return Column(
            children: [
              // Header / Top Summary Bar
              InkWell(
                onTap: () => setState(() => _isExpanded = !_isExpanded),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isCompact ? 16 : 24,
                    vertical: isCompact ? 12 : 16,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: isVeryCompact ? 3 : 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tracking ID',
                              style: TextStyle(fontSize: 10, color: AppColors.textSubheading),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              widget.trackingId,
                              style: TextStyle(
                                fontSize: isVeryCompact ? 11 : 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF4C63B6),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Sender',
                              style: TextStyle(fontSize: 10, color: AppColors.textSubheading),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              widget.sender,
                              style: TextStyle(
                                fontSize: isVeryCompact ? 11 : 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1E293B),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      if (!isVeryCompact) ...[
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Receiver',
                                style: TextStyle(fontSize: 10, color: AppColors.textSubheading),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                widget.receiver,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1E293B),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(width: 4),
                      Icon(
                        _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        color: const Color(0xFF64748B),
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),

              // Collapsible Details
              if (_isExpanded) ...[
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                Padding(
                  padding: EdgeInsets.all(isCompact ? 16 : 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // If very compact, display receiver info here if hidden in header
                      if (isVeryCompact) ...[
                        Column(
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
                        const SizedBox(height: 16),
                      ],

                      // Middle Section: Responsive grid / row for Pick Up, Delivery To, Amount, Status Badge
                      if (!isCompact)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Pick Up
                            Expanded(
                              flex: 3,
                              child: _buildLocationColumn('Pick Up From', widget.pickUpFrom),
                            ),
                            const SizedBox(width: 12),
                            // Delivery To
                            Expanded(
                              flex: 3,
                              child: _buildLocationColumn('Delivery To', widget.deliveryTo),
                            ),
                            const SizedBox(width: 12),
                            // Amount
                            Expanded(
                              flex: 2,
                              child: _buildAmountColumn(widget.amount),
                            ),
                            // Status Badge
                            _buildStatusBadge(widget.status, isDelayed),
                          ],
                        )
                      else ...[
                        // Mobile Layout: 2x2 grid
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildLocationColumn('Pick Up From', widget.pickUpFrom)),
                            const SizedBox(width: 12),
                            Expanded(child: _buildLocationColumn('Delivery To', widget.deliveryTo)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildAmountColumn(widget.amount),
                            _buildStatusBadge(widget.status, isDelayed),
                          ],
                        ),
                      ],

                      const SizedBox(height: 20),

                      // Processing Time and Action Buttons
                      if (!isCompact)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildProcessingTime(widget.processingTime),
                            const Spacer(),
                            _buildActions(widget.isPaid),
                          ],
                        )
                      else
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          alignment: WrapAlignment.spaceBetween,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            _buildProcessingTime(widget.processingTime),
                            _buildActions(widget.isPaid),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildLocationColumn(String label, String location) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: AppColors.textSubheading),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildNigeriaFlag(),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                location,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E293B),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAmountColumn(String amount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Amount',
          style: TextStyle(fontSize: 11, color: AppColors.textSubheading),
        ),
        const SizedBox(height: 6),
        Text(
          amount,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(String status, bool isDelayed) {
    return Column(
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
            status,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isDelayed ? AppColors.delayedText : AppColors.inTransitText,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProcessingTime(String processingTime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Processing time',
          style: TextStyle(fontSize: 11, color: AppColors.textSubheading),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.timer_outlined, size: 16, color: Color(0xFF64748B)),
            const SizedBox(width: 6),
            Text(
              processingTime,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E293B),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActions(bool isPaid) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0xFFCBD5E1)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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
        ElevatedButton(
          onPressed: isPaid ? null : () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: isPaid ? const Color(0xFFF1F5F9) : const Color(0xFF262D4A),
            disabledBackgroundColor: const Color(0xFFF1F5F9),
            foregroundColor: isPaid ? const Color(0xFF94A3B8) : Colors.white,
            disabledForegroundColor: const Color(0xFF94A3B8),
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            minimumSize: Size.zero,
          ),
          child: Text(
            isPaid ? 'Paid' : 'Pay Now',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isPaid ? const Color(0xFF94A3B8) : Colors.white,
            ),
          ),
        ),
      ],
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
