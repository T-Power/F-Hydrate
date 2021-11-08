import 'dart:math';

import 'package:f_hydrate/ui/theme_manager.dart';
import 'package:flutter/material.dart';

/*
 * Example from https://rm3l.org/creating-a-mid-circle-radial-gauge-in-flutter/
 */
class Gauge extends StatelessWidget {
  const Gauge(
      {Key? key,
      required this.title,
      this.maxValue = 100,
      this.currentValue = 0})
      : super(key: key);

  final String title;
  final double maxValue;
  final double currentValue;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return CustomPaint(
      foregroundPainter: _GaugePainter(context, currentValue, maxValue),
      child: Container(
        width: screenWidth * 0.35,
        padding: const EdgeInsets.only(top: 50),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 20,
              ),
              Text(
                calculateValue(),
                style: const TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 5,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String calculateValue() {
    return '${(100 * currentValue / maxValue).toStringAsFixed(1)}%';
  }
}

class _GaugePainter extends CustomPainter {
  final num maxValue;
  final num current;
  final BuildContext context;

  _GaugePainter(this.context, this.current, this.maxValue);

  @override
  void paint(Canvas canvas, Size size) {
    final complete = Paint()
      ..color = ThemeManager.currentTheme().colorScheme.secondary
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 13.0;

    final line = Paint()
      ..color = ThemeManager.currentTheme().primaryColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 13.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height);

    final startAngle = -7 * pi / 6;
    final sweepAngle = 4 * pi / 3;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        sweepAngle, false, line);

    final arcAngle = (sweepAngle) * (current / maxValue);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        arcAngle, false, complete);

    final lowerBoundText = TextPainter(textDirection: TextDirection.ltr)
      ..text = const TextSpan(text: '0')
      ..layout(minWidth: 0, maxWidth: double.maxFinite);
    lowerBoundText.paint(
        canvas, Offset(-size.width * 0.42, size.height / 1));

    final upperBoundText = TextPainter(textDirection: TextDirection.ltr)
      ..text = TextSpan(text: '$maxValue')
      ..layout(minWidth: 0, maxWidth: double.maxFinite);
    upperBoundText.paint(canvas, Offset(size.width / 0.77, size.height / 1));
  }

  @override
  bool shouldRepaint(_GaugePainter oldDelegate) => false;
}
