import 'package:flutter/material.dart';

class CustomSliderThumbRect extends SliderComponentShape {
  final double thumbRadius;
  final thumbHeight;
  final thumbWidth;
  final int min;
  final int max;

  const CustomSliderThumbRect({
    this.thumbRadius,
    this.thumbHeight,
    this.thumbWidth,
    this.min,
    this.max,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
    double textScaleFactor,
    Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final rRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
          center: center, width: thumbHeight * 0.1, height: thumbHeight * .6),
      Radius.circular(thumbRadius * .4),
    );

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // TextSpan span = new TextSpan(
    //     style: new TextStyle(
    //         fontSize: thumbHeight * .3,
    //         fontWeight: FontWeight.w700,
    //         color: sliderTheme.thumbColor,
    //         height: 0.9),
    //     text: '${getValue(value)}');
    // TextPainter tp = new TextPainter(
    //     text: span,
    //     textAlign: TextAlign.left,
    //     textDirection: TextDirection.ltr);
    // tp.layout();
    // Offset textCenter =
    //     Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));

    canvas.drawRRect(rRect, paint);
    // tp.paint(canvas, textCenter);
  }

  String getValue(double value) {
    return (min + (max - min) * (value)).round().toString();
  }
}
