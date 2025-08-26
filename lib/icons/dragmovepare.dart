import 'package:flutter/material.dart';

class DragMovePair extends StatefulWidget {
  const DragMovePair({
    super.key,
    required this.pumpkinAsset,
    required this.overlayAsset,
    required this.iconSize,
    required this.overlaySize,
    required this.overlayDy,
    required this.padding,
    this.onTap, // 아이콘 영역 탭 액션(옵션)
  });

  final String pumpkinAsset;
  final String overlayAsset;
  final double iconSize;
  final double? overlaySize;
  final double overlayDy;
  final double padding;
  final VoidCallback? onTap;

  @override
  State<DragMovePair> createState() => _DragMovePairState();
}

class _DragMovePairState extends State<DragMovePair> {
  double x = 0;

  @override
  Widget build(BuildContext context) {
    final overlayW = widget.overlaySize ?? widget.iconSize;
    final overlayH = widget.overlaySize ?? widget.iconSize;

    return SizedBox(
      height: widget.iconSize + widget.overlayDy + overlayH,
      child: LayoutBuilder(
        builder: (context, c) {
          final maxX = (c.maxWidth - widget.iconSize - widget.padding * 2)
              .clamp(0.0, double.infinity);

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: widget.padding),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: widget.onTap,
              // onDoubleTap: widget.onDoubleTap,
              onHorizontalDragUpdate: (d) {
                setState(() => x = (x + d.delta.dx).clamp(0.0, maxX));
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: x,
                    top: 0,
                    child: Image.asset(
                      widget.pumpkinAsset,
                      width: widget.iconSize,
                      height: widget.iconSize,
                    ),
                  ),
                  Positioned(
                    left: x + (widget.iconSize - overlayW) / 2,
                    top: widget.iconSize - overlayH / 2 + widget.overlayDy,
                    child: Image.asset(
                      "assets/images/monsters/${widget.overlayAsset}.png",
                      width: overlayW,
                      height: overlayH,
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
