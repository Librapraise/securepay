import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class DashboardTopBanner extends StatelessWidget {
  const DashboardTopBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 190,
          decoration: BoxDecoration(
            color: AppColors.bannerBgDark,
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF1B203E),
                Color(0xFF242A50),
                Color(0xFF2C3465),
              ],
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                // Subtle diagonal background lines for depth
                Positioned.fill(
                  child: CustomPaint(
                    painter: _BannerBackgroundPatternPainter(),
                  ),
                ),
                // Foreground content: Headline & 3D Globe + Boxes Illustration
                Row(
                  children: [
                    // Text Column
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 32.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'KEEP UP WITH YOUR\nBUSINESS NEEDS',
                              style: TextStyle(
                                fontSize: 28,
                                height: 1.25,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.5,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    offset: const Offset(0, 2),
                                    blurRadius: 4,
                                    color: Colors.black.withValues(alpha: 0.3),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Illustration on right
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 32.0, top: 12.0, bottom: 8.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            'assets/images/dashboard_banner.png',
                            fit: BoxFit.contain,
                            height: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(Icons.public, size: 100, color: Colors.white24),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Pagination dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDot(isActive: false),
            const SizedBox(width: 6),
            _buildDot(isActive: true),
            const SizedBox(width: 6),
            _buildDot(isActive: false),
          ],
        ),
      ],
    );
  }

  Widget _buildDot({required bool isActive}) {
    return Container(
      width: isActive ? 8 : 6,
      height: isActive ? 8 : 6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? const Color(0xFF262D4A) : const Color(0xFFCBD5E1),
      ),
    );
  }
}

class _BannerBackgroundPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.03)
      ..strokeWidth = 2.0;

    for (double i = -size.height; i < size.width; i += 32) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height * 1.5, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
