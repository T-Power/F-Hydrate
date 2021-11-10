import 'dart:math';

import 'package:f_hydrate/ui/theme_manager.dart';
import 'package:flutter/material.dart';

/*
 * Example from https://rm3l.org/creating-a-mid-circle-radial-gauge-in-flutter/
 */
class Gauge extends StatelessWidget {
  const Gauge({Key? key, required this.unit, this.targetValue = -1})
      : super(key: key);

  final dynamic unit;
  final num targetValue;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return CustomPaint(
      foregroundPainter: _GaugePainter(context, unit, targetValue: targetValue),
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
              const SizedBox(
                height: 10,
              ),
              const Text('Zielwert:'),
              Text(
                  '${(targetValue * unit.multiplier).toStringAsFixed(1)} ${unit.unit}')
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

  final num targetValue;

  _GaugePainter(this.context, this.unit, {this.targetValue = -1});

  @override
  void paint(Canvas canvas, Size size) {
    final currentValueCircle = Paint()
      ..color = ThemeManager.currentTheme().colorScheme.secondary
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 13.0;

    final background = Paint()
      ..color = ThemeManager.currentTheme().primaryColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 13.0;

    final targetValueCircle = Paint()
      ..color = Colors.lightGreen
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 33.0;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height);

    final startAngle = -7 * pi / 6;
    final sweepAngle = 4 * pi / 3;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        sweepAngle, false, background);

    final value = unit.value;
    final currentAngle =
        (sweepAngle) * GaugeCalculator.calculatePercentage(unit, value);
    final targetAngle =
        (sweepAngle) * GaugeCalculator.calculatePercentage(unit, targetValue);

    if (targetValue != -1) {
      const targetMarkerRange = 0.1;
      final lowerTargetAngle = targetAngle - targetMarkerRange;
      canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          startAngle + lowerTargetAngle,
          targetMarkerRange,
          false,
          targetValueCircle);
    }
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        currentAngle, false, currentValueCircle);

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

class GaugeCalculator {
  static num calculateUnitRange(dynamic unit) {
    return unit.max - unit.min;
  }

  static num calculatePercentage(dynamic unit, value) {
    num denominator = (value + ((0 - unit.min)));
    num counter = calculateUnitRange(unit);
    num percentage = denominator / counter;
    return percentage;
  }
}
