import 'package:flutter/material.dart';

class Dragicons extends StatefulWidget {
  const Dragicons({
    super.key,
    required this.assetPath,
    required this.size,
    required this.padding,
  });

  final String assetPath;
  final double size;
  final double padding;

  @override
  State<Dragicons> createState() => _DragMoveIconState();
}

class _DragMoveIconState extends State<Dragicons> {
  double x = 0; // 현재 x 좌표(왼쪽 기준)

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size,
      child: LayoutBuilder(
        builder: (context, c) {
          final maxX = (c.maxWidth - widget.size - widget.padding * 2).clamp(
            0.0,
            double.infinity,
          );

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: widget.padding),
            child: GestureDetector(
              onHorizontalDragUpdate: (d) {
                setState(() {
                  x = (x + d.delta.dx).clamp(0.0, maxX);
                });
              },
              child: Stack(
                children: [
                  Positioned(
                    left: x,
                    bottom: 0,
                    child: Image.asset(
                      widget.assetPath,
                      width: widget.size,
                      height: widget.size,
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
