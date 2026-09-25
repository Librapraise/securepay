import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class HeroBrandingPanel extends StatelessWidget {
  final String title;
  final String subtitle;

  const HeroBrandingPanel({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/hero_branding.png',
              fit: BoxFit.cover,
            ),
          ),
          if (subtitle.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 64.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14.5,
                      color: Colors.white.withValues(alpha: 0.95),
                      height: 1.45,
                      fontFamily: 'DM Sans',
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
