import 'package:f_hydrate/model/sensor.dart';
import 'package:f_hydrate/ui/widgets/gauge.dart';
import 'package:test/test.dart';

void main() {
  test('calculate 0-100 scale', () {
    final unit = DynamicUnit(0, 100, 1);
    expect(GaugeCalculator.calculateUnitRange(unit), 100);
    expect(GaugeCalculator.calculatePercentage(unit, 0), 0);
    expect(GaugeCalculator.calculatePercentage(unit, 25), 0.25);
    expect(GaugeCalculator.calculatePercentage(unit, 50), 0.5);
    expect(GaugeCalculator.calculatePercentage(unit, 75), 0.75);
    expect(GaugeCalculator.calculatePercentage(unit, 100), 1);
  });

  test('calculate 0-500 scale', () {
    final unit = DynamicUnit(0, 500, 1);
    expect(GaugeCalculator.calculateUnitRange(unit), 500);
    expect(GaugeCalculator.calculatePercentage(unit, 0), 0);
    expect(GaugeCalculator.calculatePercentage(unit, 50), 0.1);
    expect(GaugeCalculator.calculatePercentage(unit, 250), 0.5);
    expect(GaugeCalculator.calculatePercentage(unit, 500), 1);
  });

  test('calculate -100-100 scale', () {
    final unit = DynamicUnit(-100, 100, 1);
    expect(GaugeCalculator.calculateUnitRange(unit), 200);
    expect(GaugeCalculator.calculatePercentage(unit, -100), 0);
    expect(GaugeCalculator.calculatePercentage(unit, -50), 0.25);
    expect(GaugeCalculator.calculatePercentage(unit, 0), 0.5);
    expect(GaugeCalculator.calculatePercentage(unit, 50), 0.75);
    expect(GaugeCalculator.calculatePercentage(unit, 100), 1);
  });

  test('calculate -4000-8000 scale with multiplier 0.1', () {
    final unit = DynamicUnit(-4000, 8000, 0.1);
    expect(GaugeCalculator.calculateUnitRange(unit), 12000);
    expect(GaugeCalculator.calculatePercentage(unit, -4000), 0);
    expect(GaugeCalculator.calculatePercentage(unit, -1000), 0.25);
    expect(GaugeCalculator.calculatePercentage(unit, 2000), 0.5);
    expect(GaugeCalculator.calculatePercentage(unit, 5000), 0.75);
    expect(GaugeCalculator.calculatePercentage(unit, 8000), 1);
  });
}