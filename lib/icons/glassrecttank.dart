import 'dart:ui';
import 'package:flutter/material.dart';

/// 네모난 유리(글래스) 컨테이너 - 물 없음
class GlassRectTank extends StatelessWidget {
  const GlassRectTank({
    super.key,
    this.width,
    required this.height,
    this.radius = 18,
    this.blurSigma = 14,
    this.tint = const Color(0xFFFFFFFF),
    this.borderColor = const Color(0x80FFFFFF),
    this.borderWidth = 2,
    this.innerPadding = const EdgeInsets.all(12),
    this.child,
  });

  final double? width; // 미지정 시 가로는 부모에 맞춤
  final double height;
  final double radius;
  final double blurSigma;
  final Color tint; // 유리 기본 색(투명도는 아래서 조절)
  final Color borderColor;
  final double borderWidth;
  final EdgeInsets innerPadding;
  final Widget? child; // 여기에 블록들을 배치

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: Stack(
        children: [
          // 1) 유리(배경 블러 + 반투명 그라데이션)
          ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      tint.withValues(alpha: 0.22),
                      tint.withValues(alpha: 0.10),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // 2) 외곽선 + 바깥 그림자
          IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                border: Border.all(color: borderColor, width: borderWidth),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.10),
                    blurRadius: 16,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ),
          // 3) 유리 하이라이트(좌상단 강/우하단 약)
          IgnorePointer(
            child: CustomPaint(painter: _EdgeHighlightPainter(radius)),
          ),
          // 4) 내부 컨텐츠(블록 아이콘 등)
          ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Padding(padding: innerPadding, child: child),
          ),
        ],
      ),
    );
  }
}

class _EdgeHighlightPainter extends CustomPainter {
  _EdgeHighlightPainter(this.radius);
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );
    final glow1 = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.9, -0.9),
        radius: 0.9,
        colors: [Colors.white..withValues(alpha: 0.42), Colors.transparent],
      ).createShader(Offset.zero & size);
    final glow2 = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.95, 0.95),
        radius: 0.8,
        colors: [Colors.white..withValues(alpha: 0.16), Colors.transparent],
      ).createShader(Offset.zero & size);

    canvas.save();
    canvas.clipRRect(rrect);
    canvas.drawRect(Offset.zero & size, glow1);
    canvas.drawRect(Offset.zero & size, glow2);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_EdgeHighlightPainter old) => old.radius != radius;
}
