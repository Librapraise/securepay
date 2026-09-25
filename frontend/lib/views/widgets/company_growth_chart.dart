import 'package:flutter/material.dart';

class CompanyGrowthChart extends StatelessWidget {
  const CompanyGrowthChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: Row(
            children: [
              // Y-axis labels
              const SizedBox(
                width: 36,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('1,000', style: TextStyle(fontSize: 10, color: Color(0xFF9CA3AF))),
                    Text('800', style: TextStyle(fontSize: 10, color: Color(0xFF9CA3AF))),
                    Text('600', style: TextStyle(fontSize: 10, color: Color(0xFF9CA3AF))),
                    Text('400', style: TextStyle(fontSize: 10, color: Color(0xFF9CA3AF))),
                    Text('200', style: TextStyle(fontSize: 10, color: Color(0xFF9CA3AF))),
                    Text('0', style: TextStyle(fontSize: 10, color: Color(0xFF9CA3AF))),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Chart curve with grid lines
              Expanded(
                child: Stack(
                  children: [
                    // Horizontal dashed grid lines
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(6, (index) {
                        return Container(
                          height: 1,
                          color: const Color(0xFFF3F4F6),
                        );
                      }),
                    ),
                    // Custom painted smooth spline & area gradient
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _SplineChartPainter(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // X-axis labels (1 to 12)
        Padding(
          padding: const EdgeInsets.only(left: 44.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(12, (index) {
              return Text(
                '${index + 1}',
                style: const TextStyle(fontSize: 11, color: Color(0xFF9CA3AF)),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _SplineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 12 data points normalized between 0.0 and 1.0 (from 0 to 1000)
    // Matches the visual curve from the Figma screenshot
    final points = <Offset>[
      Offset(0, size.height * (1.0 - 0.28)),
      Offset(size.width * 0.09, size.height * (1.0 - 0.31)),
      Offset(size.width * 0.18, size.height * (1.0 - 0.30)),
      Offset(size.width * 0.27, size.height * (1.0 - 0.34)),
      Offset(size.width * 0.36, size.height * (1.0 - 0.32)),
      Offset(size.width * 0.45, size.height * (1.0 - 0.39)),
      Offset(size.width * 0.55, size.height * (1.0 - 0.33)),
      Offset(size.width * 0.64, size.height * (1.0 - 0.41)),
      Offset(size.width * 0.73, size.height * (1.0 - 0.36)),
      Offset(size.width * 0.82, size.height * (1.0 - 0.52)),
      Offset(size.width * 0.91, size.height * (1.0 - 0.20)),
      Offset(size.width, size.height * (1.0 - 0.94)),
    ];

    final path = Path();
    path.moveTo(points.first.dx, points.first.dy);

    for (int i = 0; i < points.length - 1; i++) {
      final p0 = i > 0 ? points[i - 1] : points[i];
      final p1 = points[i];
      final p2 = points[i + 1];
      final p3 = i < points.length - 2 ? points[i + 2] : p2;

      // Catmull-Rom to Cubic Bezier spline conversion
      final cp1x = p1.dx + (p2.dx - p0.dx) / 6.0;
      final cp1y = p1.dy + (p2.dy - p0.dy) / 6.0;
      final cp2x = p2.dx - (p3.dx - p1.dx) / 6.0;
      final cp2y = p2.dy - (p3.dy - p1.dy) / 6.0;

      path.cubicTo(cp1x, cp1y, cp2x, cp2y, p2.dx, p2.dy);
    }

    // Fill area gradient
    final fillPath = Path.from(path);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF5A67BA).withValues(alpha: 0.18),
          const Color(0xFF5A67BA).withValues(alpha: 0.01),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    canvas.drawPath(fillPath, fillPaint);

    // Stroke line
    final strokePaint = Paint()
      ..color = const Color(0xFF5A67BA)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
