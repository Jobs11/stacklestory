import 'dart:math' as math;
import 'package:flutter/material.dart';

/// 가로 화살표 바 (라인 + 화살촉)
class ArrowLine extends StatelessWidget {
  const ArrowLine({
    super.key,
    this.color = const Color(0xFF2F2F2F),
    required this.thickness,
    required this.headLength,
    required this.headWidth,
    required this.horizontalPadding,
  });

  final Color color;
  final double thickness;
  final double headLength; // 화살촉 길이(가로)
  final double headWidth; // 화살촉 높이(세로)
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    final h = math.max(thickness, headWidth) + 8; // 살짝 여유
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: SizedBox(
        height: h,
        width: double.infinity,
        child: CustomPaint(
          painter: _ArrowPainter(
            color: color,
            thickness: thickness,
            headLength: headLength,
            headWidth: headWidth,
          ),
        ),
      ),
    );
  }
}

class _ArrowPainter extends CustomPainter {
  _ArrowPainter({
    required this.color,
    required this.thickness,
    required this.headLength,
    required this.headWidth,
  });

  final Color color;
  final double thickness;
  final double headLength;
  final double headWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final y = size.height / 2;

    // 라인(몸통)
    final linePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round;

    // 화살촉이 들어갈 공간만큼 오른쪽 여백
    final lineRight = size.width - headLength - thickness / 2;
    final lineLeft = thickness / 2;

    canvas.drawLine(Offset(lineLeft, y), Offset(lineRight, y), linePaint);

    // 화살촉
    final baseX = size.width - headLength;
    final halfW = headWidth / 2;

    final headPath = Path()
      ..moveTo(size.width, y) // 끝 점(뾰족)
      ..lineTo(baseX, y - halfW) // 위쪽
      ..lineTo(baseX, y + halfW) // 아래쪽
      ..close();

    final headPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawPath(headPath, headPaint);
  }

  @override
  bool shouldRepaint(_ArrowPainter old) =>
      old.color != color ||
      old.thickness != thickness ||
      old.headLength != headLength ||
      old.headWidth != headWidth;
}
