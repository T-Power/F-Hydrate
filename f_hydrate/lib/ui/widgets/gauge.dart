import 'dart:math';

import 'package:f_hydrate/ui/theme_manager.dart';
import 'package:flutter/material.dart';

/*
 * Example from https://rm3l.org/creating-a-mid-circle-radial-gauge-in-flutter/
 */
class Gauge extends StatelessWidget {
  const Gauge({Key? key, required this.unit}) : super(key: key);

  final dynamic unit;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return CustomPaint(
      foregroundPainter: _GaugePainter(context, unit),
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
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 5,
              ),
              Text(
                unit.description,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${unit.unit}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String calculateValue() {
    return '${(unit.value * unit.multiplier).toStringAsFixed(1)} ${unit.unit}';
  }
}

class _GaugePainter extends CustomPainter {
  final dynamic unit;
  final BuildContext context;

  _GaugePainter(this.context, this.unit);

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

    final arcAngle = (sweepAngle) * (unit.value / unit.max);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        arcAngle, false, complete);

    final lowerBoundText = TextPainter(textDirection: TextDirection.ltr)
      ..text = TextSpan(text: '${(unit.min * unit.multiplier)}')
      ..layout(minWidth: 0, maxWidth: double.maxFinite);
    lowerBoundText.paint(canvas, Offset(-size.width * 0.42, size.height / 1));

    final upperBoundText = TextPainter(textDirection: TextDirection.ltr)
      ..text = TextSpan(text: '${(unit.max * unit.multiplier)}')
      ..layout(minWidth: 0, maxWidth: double.maxFinite);
    upperBoundText.paint(canvas, Offset(size.width / 0.77, size.height / 1));
  }

  @override
  bool shouldRepaint(_GaugePainter oldDelegate) => false;
}
