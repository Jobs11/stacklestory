import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacklestory/functions/datas.dart';

class DropDemo extends StatefulWidget {
  final MonsterQueue mq;
  const DropDemo({super.key, required this.mq});

  @override
  State<DropDemo> createState() => _DropDemoState();
}

class _DropDemoState extends State<DropDemo> {
  // 드랍 애니메이션 상태
  final Alignment _dropAlignStart = const Alignment(0, -1.1);
  final Alignment _dropAlignEnd = const Alignment(0, 0.9);
  Alignment _dropAlignCur = const Alignment(0, -1.1);
  bool _isDropping = false;

  int? _droppingIndex; // 드랍 중에 보여줄(스냅샷) 인덱스

  // 현재 보여줄 인덱스(드랍 중이면 스냅샷, 아니면 queue[0])
  int get _currentIdx => _droppingIndex ?? widget.mq.queue[0];

  void _startDrop() {
    if (_isDropping) return;

    setState(() {
      _droppingIndex = widget.mq.queue[0]; // 스냅샷
      _isDropping = true;
      _dropAlignCur = _dropAlignEnd; // 아래로 이동 시작
    });
  }

  void _onDropEnd() {
    // 드랍 완료 → 다음 목록으로 진행
    widget.mq.next();

    // 위치/상태 초기화
    setState(() {
      _isDropping = false;
      _droppingIndex = null;
      _dropAlignCur = _dropAlignStart;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 보드/캔버스
        Container(
          color: const Color(0x11000000),
          width: double.infinity,
          height: 300,
        ),

        // 떨어지는 블록
        AnimatedAlign(
          alignment: _dropAlignCur,
          duration: const Duration(milliseconds: 420),
          curve: Curves.easeInQuad,
          onEnd: () {
            if (_isDropping) _onDropEnd();
          },
          child: monsterByIndex(_currentIdx),
        ),

        // 하단: 대기열 미리보기 (다음/그다음/다다음)
        Align(
          alignment: const Alignment(0, 1.0),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                monsterByIndex(widget.mq.queue[0]),
                SizedBox(width: 12.w),
                Opacity(
                  opacity: 0.8,
                  child: monsterByIndex(widget.mq.queue[1]),
                ),
                SizedBox(width: 12.w),
                Opacity(
                  opacity: 0.6,
                  child: monsterByIndex(widget.mq.queue[2]),
                ),
              ],
            ),
          ),
        ),

        // 드랍 버튼 (예시)
        Positioned(
          right: 12,
          bottom: 12,
          child: ElevatedButton(
            onPressed: _startDrop, // ← 드랍 시작만! next()는 onEnd에서 호출
            child: const Text('떨어뜨리기'),
          ),
        ),
      ],
    );
  }
}
