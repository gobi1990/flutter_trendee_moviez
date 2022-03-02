import 'package:flutter/material.dart';

class TabIndicationPainter extends CustomPainter {
  Paint? painter;
  final double width;
  final double? dxEntry;
  final double? verticalPosition;
  final double? height;
  final double? radius;
  final PageController pageController;

  TabIndicationPainter(
      {required this.pageController,
      required this.width,
      this.dxEntry = 5.0,
      this.verticalPosition = 0.0,
      this.height = 10.0,
      this.radius = 10})
      : super(repaint: pageController) {
    painter = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final pos = pageController.position;
    var fullExtent =
        (pos.maxScrollExtent - pos.minScrollExtent + pos.viewportDimension);
    var pageOffset = pos.extentBefore / fullExtent;

    bool left2right = dxEntry! < width;
    var target = Offset(left2right ? width : dxEntry!, verticalPosition!);

    canvas.translate(size.width * pageOffset, 0.0);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTRB(5, 0, target.dx, 35), Radius.circular(radius!)),
        painter!);
  }

  @override
  bool shouldRepaint(TabIndicationPainter oldDelegate) => true;
}
