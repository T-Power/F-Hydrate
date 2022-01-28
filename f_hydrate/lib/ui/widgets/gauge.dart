import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

/**
 * StatefulWidget, welches eine Einheit grafisch als "Tacho" in Prozent mit Sollwert darstellt.
 * Weiterhin werden die minimalen/maximalen Werte, sowie der aktuelle und Soll-Wert mit Einheit angezeigt.
 * Example from https://rm3l.org/creating-a-mid-circle-radial-gauge-in-flutter/
 */
class Gauge extends StatefulWidget {
  const Gauge(
      {Key? key,
      required this.unit,
      this.description = "",
      this.targetValue = -1,
      this.constraints = const BoxConstraints()})
      : super(key: key);

  /// Die darzustellende Einheit als generisches Objekt (min, max, Multiplikator).
  final dynamic unit;

  /// Der Soll-Wert.
  final num targetValue;

  //Beschreibung des Sensors
  final String description;

  /// Die Containergröße, die in der UI zur Verfügung steht.
  final BoxConstraints constraints;

  @override
  GaugeState createState() => GaugeState();
}

class GaugeState extends State<Gauge> {
  /// Die Containergröße, die in der UI zur Verfügung steht.
  BoxConstraints constraints = BoxConstraints();

  /// Die darzustellende Einheit als generisches Objekt (min, max, Multiplikator).
  dynamic unit;

  /// Der Soll-Wert.
  num targetValue = -999;

  @override
  void initState() {
    super.initState();
    constraints = widget.constraints;
    unit = widget.unit;
    targetValue = widget.targetValue;
  }

  @override
  Widget build(BuildContext context) {
    Widget child = buildContent(context);
    return createLayoutBuilder(context, child);
  }

  /// Erzeugt einen LayoutBuilder.
  Widget createLayoutBuilder(BuildContext context, Widget child) {
    /// Bildschirmgröße.
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      /// Der "Tacho" wird mit einem CustomPainter erzeugt.
      child: CustomPaint(
        foregroundPainter:
            _GaugePainter(context, unit, targetValue: targetValue),

        /// Die Größe wird auf die maximale Bildschirmgröße beschränkt.
        size: Size(screenWidth, screenHeight),

        /// Widget für aktuellen + Soll-Wert.
        child: Center(
          child: child,
        ),
      ),
    );
  }

  /// Erzeugt ein Widget für den aktuellen und Soll-Wert.
  Widget buildContent(BuildContext context) {
    /// Bildschirmgröße.
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final density = MediaQuery.of(context).devicePixelRatio;

    /// Berechnen der kleinsten Seite zum Resizing.
    double smallestSide = min(screenWidth, screenHeight);
    print('Width: $screenWidth, height: $screenHeight, density: $density');

    /// Scroll-View, um Überlauf zu verhindern.
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          /// Anzeige des aktuellen Werts (mit Einheit).
          Text(
            calculateValue(),
            style: TextStyle(
              fontSize: 10 + additionalFontSize(smallestSide, 52, density),
              fontWeight: FontWeight.bold,
            ),
            maxLines: 3,
          ),

          /// Abstand
          SizedBox(
            height: screenHeight * 0.02,
          ),

          /// Beschreibung der Messeinheit, z. B. 'Temperatur'
          Text(
            unit.description.toString().replaceAll(" ", "\n"),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 5 + additionalFontSize(smallestSide, 29, density),
            ),
            textAlign: TextAlign.center,
          ),

          /// Abstand
          SizedBox(
            height: screenHeight * 0.04,
          ),

          /// Soll-Wert (Überschrift).
          Text(
            'Zielwert:',
            style: TextStyle(
              fontSize: 8 + additionalFontSize(smallestSide, 29, density),
            ),
          ),

          /// Soll-Wert (Wert).
          Text(
            '${(targetValue * unit.multiplier).toStringAsFixed(1)} ${unit.unit}',
            style: TextStyle(
              fontSize: 8 + additionalFontSize(smallestSide, 29, density),
            ),
          ),

          /// Abstand
          SizedBox(
            height: screenHeight * 0.04,
          ),

          /// Sensor-Beschreibung.
          Text(
            '${widget.description}',
            style: TextStyle(
              fontSize: 8 + additionalFontSize(smallestSide, 29, density),
            ),
          ),
        ],
      ),
    );
  }

  /// Berechnet einen Aufschlag auf die Schriftgröße anhand der kleinsten Bildschirmseite und Pixel-Dichte.
  double additionalFontSize(num limit, double max, double density) {
    print('Additional font size screen limit: $limit');
    double addSize = limit < (100 * density) ? 0 : min((limit / 80), max);
    print('Additional font size: $addSize');
    return addSize;
  }

  /// Berechnet den aktuellen Wert und ergänzt die Einheit.
  String calculateValue() {
    return '${(unit.value * unit.multiplier).toStringAsFixed(1)} ${unit.unit}';
  }
}

/**
 * CustomPainter zum zeichnen des "Tachos".
 */
class _GaugePainter extends CustomPainter {
  /// Darzustellende Messeinheit.
  final dynamic unit;

  /// BuildContext
  final BuildContext context;

  /// Soll-Wert
  final num targetValue;

  /// Konstruktor. Soll-Wert Standard ist -1. Wird kein Wert angegeben, wird kein Soll-Wert abgebildet.
  _GaugePainter(this.context, this.unit, {this.targetValue = -1});

  @override
  void paint(Canvas canvas, Size size) {
    print('GaugePainter.paint(). Width: ${size.width} Height: ${size.height}');

    /// Erzeugt den (Halb-)Kreis für den aktuellen Wert.
    final currentValueCircle = Paint()
      ..color = Theme.of(context).colorScheme.secondary
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.height / 40;

    /// Erzeugt den (Halb-)Kreis für den Hintergrund.
    final background = Paint()
      ..color = Theme.of(context).textTheme.headline1!.color ??
          Theme.of(context).primaryColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.height / 40;

    /// Erzeugt eine Markierung für den Soll-Wert.
    final targetValueCircle = Paint()
      ..color = Colors.lightGreen
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.height / 28;

    /// Mitte des Bildschirms
    final centerOfScreen = Offset(size.width / 2, size.height / 2);

    /// Radius des (Halb-)Kreises.
    double radius = min(size.width, size.height);
    print('Gauge radius: $radius');
    try {
      /// Berechnen des Radius basierend auf der Plattform. Wenn nicht iOS und nicht Android, dann wird die Anwendung im Web (PC) benutzt und ist im "Landscape"-Modus, also breiter.
      if (Platform.isIOS || Platform.isAndroid) {
        radius *= 0.3;
      } else {
        radius *= 0.4;
      }
    } catch (e) {
      /// Platform.xyz steht im Web nicht zur Verfügung und erzeugt eine Exception.
      print(e);
      radius *= 0.4;
    }

    /// Start-Winkel.
    const startAngle = -7 * pi / 6;

    /// Drehe bis Winkel.
    const sweepAngle = 4 * pi / 3;

    /// Zeichnen des Hintergrunds.
    canvas.drawArc(Rect.fromCircle(center: centerOfScreen, radius: radius),
        startAngle, sweepAngle, false, background);

    /// aktueller Wert.
    final value = unit.value;

    /// Winkel für den aktuellen Wert.
    final currentAngle =
        (sweepAngle) * GaugeCalculator.calculatePercentage(unit, value);

    /// Winkel für den Soll-Wert.
    final targetAngle =
        (sweepAngle) * GaugeCalculator.calculatePercentage(unit, targetValue);

    /// Wenn kein Soll-Wert angegeben, wird der Soll-Wert nicht dargestellt.
    if (targetValue != -1) {
      /// Wert, der als "okaye" Abweichung vom Soll-Wert in Ordnung ist (in Grad).
      const targetMarkerRange = 0.1;
      final lowerTargetAngle = targetAngle - targetMarkerRange;

      /// Zeichnen der Soll-Wert Markierung.
      canvas.drawArc(
          Rect.fromCircle(center: centerOfScreen, radius: radius),
          startAngle + lowerTargetAngle,
          targetMarkerRange,
          false,
          targetValueCircle);
    }

    /// Zeichnen des aktuellen Wertes.
    canvas.drawArc(Rect.fromCircle(center: centerOfScreen, radius: radius),
        startAngle, currentAngle, false, currentValueCircle);

    /// Berechnet die schmalste Bildschirmseite
    double smallestSide = min(size.width, size.height);

    /// Text für die untere Wertgrenze.
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

    /// Text für die obere Wertgrenze.
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

/**
 * Helferklasse zum Berechnen.
 */
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
