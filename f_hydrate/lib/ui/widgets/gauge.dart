import 'dart:io';
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
    BoxConstraints c;
    return SizedBox(child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      c = constraints;
      return CustomPaint(
        foregroundPainter:
            _GaugePainter(context, unit, targetValue: targetValue),
        size: Size(constraints.maxWidth, constraints.maxHeight),
        child: Center(
          child: buildContent(context, c),
        ),
      );
    }));
  }

  Widget buildContent(BuildContext context, BoxConstraints constraints) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double smallestSide = min(constraints.maxHeight, constraints.maxWidth);
    print('Width: $screenWidth, height: $screenHeight');
    print(
        'BoxConstraint Width: ${constraints.maxWidth}, height: ${constraints.maxHeight}');
    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.2,
        ),
        Text(
          calculateValue(),
          style: TextStyle(
            fontSize: 10 + additionalFontSize(smallestSide, 52),
            fontWeight: FontWeight.bold,
          ),
          maxLines: 3,
        ),
        SizedBox(
          height: screenHeight * 0.04,
        ),
        Text(
          unit.description,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 8 + additionalFontSize(smallestSide, 29),
          ),
        ),
        SizedBox(
          height: screenHeight * 0.04,
        ),
        Text(
          'Zielwert:',
          style: TextStyle(
            fontSize: 8 + additionalFontSize(smallestSide, 29),
          ),
        ),
        Text(
          '${(targetValue * unit.multiplier).toStringAsFixed(1)} ${unit.unit}',
          style: TextStyle(
            fontSize: 8 + additionalFontSize(smallestSide, 29),
          ),
        )
      ],
    );
  }

  double additionalFontSize(num limit, double max) {
    print('Additional font size screen limit: $limit');
    double addSize = limit < 350 ? 0 : min((limit / 30), max);
    print('Additional font size: $addSize');
    return addSize;
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
    print('GaugePainter.paint(). Width: ${size.width} Height: ${size.height}');
    final currentValueCircle = Paint()
      ..color = ThemeManager.currentTheme().colorScheme.secondary
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 13.0;

    final background = Paint()
      ..color = ThemeManager.currentTheme().textTheme.headline1!.color ??
          ThemeManager.currentTheme().primaryColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 13.0;

    final targetValueCircle = Paint()
      ..color = Colors.lightGreen
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 33.0;

    final centerOfScreen = Offset(size.width / 2, size.height / 1.6);
    double radius = min(size.width, size.height);
    try {
      if (Platform.isIOS || Platform.isAndroid) {
        radius *= 0.45;
      } else {
        radius *= 0.6;
      }
    } catch (e) {
      radius *= 0.6;
    }

    const startAngle = -7 * pi / 6;
    const sweepAngle = 4 * pi / 3;

    canvas.drawArc(Rect.fromCircle(center: centerOfScreen, radius: radius),
        startAngle, sweepAngle, false, background);

    final value = unit.value;
    final currentAngle =
        (sweepAngle) * GaugeCalculator.calculatePercentage(unit, value);
    final targetAngle =
        (sweepAngle) * GaugeCalculator.calculatePercentage(unit, targetValue);

    if (targetValue != -1) {
      const targetMarkerRange = 0.1;
      final lowerTargetAngle = targetAngle - targetMarkerRange;
      canvas.drawArc(
          Rect.fromCircle(center: centerOfScreen, radius: radius),
          startAngle + lowerTargetAngle,
          targetMarkerRange,
          false,
          targetValueCircle);
    }
    canvas.drawArc(Rect.fromCircle(center: centerOfScreen, radius: radius),
        startAngle, currentAngle, false, currentValueCircle);

    double smallestSide = min(size.width, size.height);

    final lowerBoundText = TextPainter(textDirection: TextDirection.ltr)
      ..text = TextSpan(
          text: '${(unit.min * unit.multiplier)}',
          style: TextStyle(
              color: Theme.of(context).textTheme.headline2!.color,
              fontSize:
                  12 + (smallestSide < 200 ? 0 : min((smallestSide / 40), 30)),
              fontWeight: FontWeight.bold))
      ..layout(minWidth: 0, maxWidth: size.width * 0.25);
    lowerBoundText.paint(canvas, Offset(size.width * 0.28, size.height * 0.9));

    final upperBoundText = TextPainter(textDirection: TextDirection.ltr)
      ..text = TextSpan(
          text: '${(unit.max * unit.multiplier)}',
          style: TextStyle(
              color: Theme.of(context).textTheme.headline2!.color,
              fontSize:
                  12 + (smallestSide < 200 ? 0 : min((smallestSide / 40), 30)),
              fontWeight: FontWeight.bold))
      ..layout(minWidth: 0, maxWidth: size.width * 0.25);
    upperBoundText.paint(canvas, Offset(size.width * 0.70, size.height * 0.9));
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
