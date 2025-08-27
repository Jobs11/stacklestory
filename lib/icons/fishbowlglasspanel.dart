import 'dart:ui'; // ImageFilter
import 'package:flutter/material.dart';

/// 유리 어항(볼) 모양의 글래스모피즘 카드
class FishbowlGlassPanel extends StatelessWidget {
  const FishbowlGlassPanel({
    super.key,
    required this.width,
    required this.height,
    this.child,
    this.tint = const Color(0xCCFFFFFF), // 유리 색(반투명 흰색)
    this.blurSigma = 12,
    this.borderColor = const Color(0x80FFFFFF),
    this.borderWidth = 2.0,
  });

  final double width;
  final double height;
  final Widget? child;
  final Color tint;
  final double blurSigma;
  final Color borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          // 유리 효과(블러 + 반투명 그라데이션)
          ClipPath(
            clipper: _BowlClipper(),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      tint.withValues(alpha: 0.28),
                      tint.withValues(alpha: 0.14),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 테두리 & 하이라이트
          IgnorePointer(
            child: CustomPaint(
              painter: _BowlBorderPainter(
                color: borderColor,
                width: borderWidth,
              ),
              size: Size(width, height),
            ),
          ),

          // 유리 반짝임(글레어)
          IgnorePointer(
            child: CustomPaint(
              painter: _BowlHighlightPainter(),
              size: Size(width, height),
            ),
          ),

          // 내부 컨텐츠
          ClipPath(
            clipper: _BowlClipper(),
            child: Padding(padding: const EdgeInsets.all(16), child: child),
          ),
        ],
      ),
    );
  }
}

/// 어항 바디 모양
class _BowlClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size s) {
    final w = s.width;
    final h = s.height;
    final rim = h * 0.14; // 윗 입구 높이
    final p = Path()
      ..moveTo(w * 0.18, rim)
      ..quadraticBezierTo(w * 0.10, h * 0.38, w * 0.28, h * 0.70)
      ..quadraticBezierTo(w * 0.50, h * 0.92, w * 0.72, h * 0.70)
      ..quadraticBezierTo(w * 0.90, h * 0.38, w * 0.82, rim)
      // 윗 입구(살짝 안쪽으로 휘어진 느낌)
      ..arcToPoint(
        Offset(w * 0.18, rim),
        radius: Radius.elliptical(w * 0.36, rim * 1.2),
        clockwise: false,
      )
      ..close();
    return p;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/// 외곽선
class _BowlBorderPainter extends CustomPainter {
  _BowlBorderPainter({required this.color, required this.width});
  final Color color;
  final double width;

  @override
  void paint(Canvas canvas, Size size) {
    final path = _BowlClipper().getClip(size);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = width
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _BowlBorderPainter old) =>
      old.color != color || old.width != width;
}

/// 유리 반짝임(왼쪽 위 하이라이트 + 오른쪽 아래 살짝)
class _BowlHighlightPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = _BowlClipper().getClip(size);

    // 왼쪽 위 글레어
    final glow1 = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.7, -0.8),
        radius: 0.8,
        colors: [Color(0x73FFFFFF), Colors.transparent],
      ).createShader(Offset.zero & size);
    canvas.save();
    canvas.clipPath(path);
    canvas.drawRect(Offset.zero & size, glow1);

    // 오른쪽 아래 약한 글레어
    final glow2 = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.9, 0.9),
        radius: 0.6,
        colors: [Color(0x26FFFFFF), Colors.transparent],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, glow2);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
