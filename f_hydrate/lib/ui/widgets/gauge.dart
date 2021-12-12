import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

/*
 * Example from https://rm3l.org/creating-a-mid-circle-radial-gauge-in-flutter/
 */
class Gauge extends StatelessWidget {
  const Gauge(
      {Key? key,
      required this.unit,
      this.targetValue = -1,
      this.constraints = const BoxConstraints()})
      : super(key: key);

  final dynamic unit;
  final num targetValue;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    Widget child = buildContent(context);
    return createLayoutBuilder(context, child);
  }

  Widget createLayoutBuilder(BuildContext context, Widget child) {
    return Container(
      child: CustomPaint(
        foregroundPainter:
            _GaugePainter(context, unit, targetValue: targetValue),
        size: Size(constraints.maxWidth, constraints.maxHeight),
        child: Center(
          child: child,
        ),
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    final screenWidth = constraints.maxWidth;
    final screenHeight = constraints.maxHeight;
    final density = MediaQuery.of(context).devicePixelRatio;
    double smallestSide = min(screenWidth, screenHeight);
    print('Width: $screenWidth, height: $screenHeight, density: $density');
    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.3,
        ),
        Text(
          calculateValue(),
          style: TextStyle(
            fontSize: 10 + additionalFontSize(smallestSide, 52, density),
            fontWeight: FontWeight.bold,
          ),
          maxLines: 3,
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        Text(
          unit.description.toString().replaceAll(" ", "\n"),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 5 + additionalFontSize(smallestSide, 29, density),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: screenHeight * 0.04,
        ),
        Text(
          'Zielwert:',
          style: TextStyle(
            fontSize: 8 + additionalFontSize(smallestSide, 29, density),
          ),
        ),
        Text(
          '${(targetValue * unit.multiplier).toStringAsFixed(1)} ${unit.unit}',
          style: TextStyle(
            fontSize: 8 + additionalFontSize(smallestSide, 29, density),
          ),
        ),
      ],
    );
  }

  double additionalFontSize(num limit, double max, double density) {
    print('Additional font size screen limit: $limit');
    double addSize = limit < (100 * density) ? 0 : min((limit / 70), max);
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
      ..color = Theme.of(context).colorScheme.secondary
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.height / 40;

    final background = Paint()
      ..color = Theme.of(context).textTheme.headline1!.color ??
          Theme.of(context).primaryColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.height / 40;

    final targetValueCircle = Paint()
      ..color = Colors.lightGreen
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.height / 30;

    final centerOfScreen = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width, size.height);
    print('Gauge radius: $radius');
    try {
      if (Platform.isIOS || Platform.isAndroid) {
        radius *= 0.3;
      } else {
        radius *= 0.4;
      }
    } catch (e) {
      print(e);
      radius *= 0.4;
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
    lowerBoundText.paint(canvas, Offset(size.width * 0.28, size.height * 0.75));

    final upperBoundText = TextPainter(textDirection: TextDirection.ltr)
      ..text = TextSpan(
          text: '${(unit.max * unit.multiplier)}',
          style: TextStyle(
              color: Theme.of(context).textTheme.headline2!.color,
              fontSize:
                  12 + (smallestSide < 200 ? 0 : min((smallestSide / 40), 30)),
              fontWeight: FontWeight.bold))
      ..layout(minWidth: 0, maxWidth: size.width * 0.25);
    upperBoundText.paint(canvas, Offset(size.width * 0.70, size.height * 0.75));
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
