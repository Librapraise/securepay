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
      padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 72.0),
      child: Stack(
        children: [
          Center(
            child: Opacity(
              opacity: 0.22,
              child: Icon(
                Icons.public,
                size: 380,
                color: Colors.white,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    height: 1.35,
                    fontFamily: 'DM Sans',
                  ),
                ),
                const SizedBox(height: 14.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white.withOpacity(0.85),
                    height: 1.5,
                    fontFamily: 'DM Sans',
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
