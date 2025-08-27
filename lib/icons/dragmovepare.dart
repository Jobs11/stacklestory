import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DragMovePair extends StatefulWidget {
  const DragMovePair({
    super.key,
    required this.pumpkinAsset,
    required this.overlayAsset, // 예: '달수' (경로 아님)
    required this.iconSize,
    required this.overlaySize,
    required this.overlayDy,
    required this.padding,
    this.onTap, // 탭 알림(옵션)
    this.onDropEnd, // ★ 드랍 완료 콜백(옵션)
    this.dropDuration = const Duration(milliseconds: 800),
    this.dropCurve = Curves.easeInQuad,
  });

  final String pumpkinAsset;
  final String overlayAsset; // 내부에서 경로로 조합해 사용
  final double iconSize;
  final double? overlaySize;
  final double overlayDy;
  final double padding;
  final VoidCallback? onTap;
  final VoidCallback? onDropEnd; // ★ 추가
  final Duration dropDuration; // ★ 추가
  final Curve dropCurve; // ★ 추가

  @override
  State<DragMovePair> createState() => _DragMovePairState();
}

class _DragMovePairState extends State<DragMovePair>
    with SingleTickerProviderStateMixin {
  double x = 0;

  late final AnimationController _ac; // ★ 추가
  late final Animation<Offset> _fall; // ★ 추가
  bool _isDropping = false; // ★ 탭 연타 방지

  @override
  void initState() {
    super.initState();
    _ac = AnimationController(vsync: this, duration: widget.dropDuration);
    _fall = Tween<Offset>(
      begin: const Offset(0, -1.0),
      end: const Offset(0, 1.0),
    ).animate(CurvedAnimation(parent: _ac, curve: widget.dropCurve));

    _ac.addStatusListener((s) {
      if (s == AnimationStatus.completed) {
        widget.onDropEnd?.call(); // ★ 드랍 완료 알림 (부모에서 mq.next() 호출)
        _ac.reset(); // 다음 드랍 대비 초기화
        setState(() => _isDropping = false);
      }
    });
  }

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  void _startDrop() {
    if (_isDropping || _ac.isAnimating) return;
    setState(() => _isDropping = true);
    _ac.forward();
  }

  @override
  Widget build(BuildContext context) {
    final overlayW = widget.overlaySize ?? widget.iconSize;
    final overlayH = widget.overlaySize ?? widget.iconSize;

    return SizedBox(
      height: (widget.iconSize + widget.overlayDy + 105).h,
      child: LayoutBuilder(
        builder: (context, c) {
          final maxX = (c.maxWidth - widget.iconSize - widget.padding * 2)
              .clamp(0.0, double.infinity);

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: widget.padding.w),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                widget.onTap?.call(); // 기존 탭 알림 유지
                _startDrop(); // ★ 드랍 애니메이션 시작
              },
              onHorizontalDragUpdate: (d) {
                if (_isDropping) return; // 드랍 중에는 이동 잠금(선택)
                setState(() => x = (x + d.delta.dx).clamp(0.0, maxX));
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // 집게
                  Positioned(
                    left: x,
                    top: 0,
                    child: Image.asset(
                      widget.pumpkinAsset,
                      width: widget.iconSize.w,
                      height: widget.iconSize.h,
                    ),
                  ),

                  // 오버레이(몬스터) – 위치/레이아웃은 그대로, 모션만 SlideTransition으로
                  Positioned(
                    left: (x + (widget.iconSize - overlayW) / 2),
                    top: widget.iconSize + overlayH / 2 + widget.overlayDy,

                    child: SlideTransition(
                      position: _fall, // ★ 드랍 모션 적용
                      child: Image.asset(
                        "assets/images/monsters/${widget.overlayAsset}.png",
                        width: overlayW.w,
                        height: overlayH.h,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
