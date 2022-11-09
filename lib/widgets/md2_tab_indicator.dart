import 'package:flutter/material.dart';

class MD2TabIndicator extends Decoration {
  final Color indicatorColor;

  /// Custom decoration for active tab indicator.
  ///
  /// For intended look, the TabBar height should be 48 (default)
  const MD2TabIndicator(this.indicatorColor);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _MD2Painter(this, onChanged!);
  }
}

class _MD2Painter extends BoxPainter {
  final MD2TabIndicator indicator;

  _MD2Painter(this.indicator, VoidCallback onChanged) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Rect rect = Offset(offset.dx, (configuration.size!.height - 48)) &
        Size(configuration.size!.width, 4);

    final Paint paint = Paint();
    paint.color = indicator.indicatorColor;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        rect,
        bottomRight: const Radius.circular(4),
        bottomLeft: const Radius.circular(4),
      ),
      paint,
    );
  }
}
