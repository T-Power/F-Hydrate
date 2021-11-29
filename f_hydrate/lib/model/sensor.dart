import 'dart:math';

import 'package:f_hydrate/model/tree_information.dart';

class Sensor {
  // String id;
  // String name;
  // String unit;
  // GeographicPosition location;
  // double latitude;
  // double longitude;
  Temperature temperature;
  VolumetricWaterContent volumetricWaterContent;
  ElectricalConductivity electricalConductivity;
  Salinity salinity;
  TotalDissolvedSolids totalDissolvedSolids;
  BiologicalTreeType tree;

  Sensor({
    // this.id = '',
    //   this.name = '',
    //   this.unit = '',
    // this.location = const GeographicPosition(0,0),
    // this.latitude = 0,
    // this.longitude = 0,
    this.temperature = const Temperature(0),
    this.volumetricWaterContent = const VolumetricWaterContent(0),
    this.electricalConductivity = const ElectricalConductivity(0),
    this.salinity = const Salinity(0),
    this.totalDissolvedSolids = const TotalDissolvedSolids(0),
    this.tree = const BiologicalTreeType(),
  });

  static Sensor createExample() {
    Sensor s = Sensor();
    s.temperature = const Temperature(20.5);
    s.volumetricWaterContent = const VolumetricWaterContent(75.5);
    s.salinity = const Salinity(10.67);
    s.totalDissolvedSolids = const TotalDissolvedSolids(5.1);
    s.tree = const BiologicalTreeType();
    return s;
  }

  static Sensor randomSensor() {
    return Sensor(
      // name: 'FH DO FB4',
      temperature: Temperature(
        Temperature.randomValue(),
      ),
      volumetricWaterContent: VolumetricWaterContent(
        VolumetricWaterContent.randomValue(),
      ),
      electricalConductivity: ElectricalConductivity(
        ElectricalConductivity.randomValue(),
      ),
      salinity: Salinity(
        Salinity.randomValue(),
      ),
      totalDissolvedSolids: TotalDissolvedSolids(
        TotalDissolvedSolids.randomValue(),
      ),
    );
  }
}

class Temperature {
  final num value;
  final num min = -4000;
  final num max = 8000;
  final num multiplier = 0.01;
  final String unit = "°C";
  final String description = "Temperatur";

  const Temperature(this.value);

  @override
  String toString() {
    return value.toStringAsFixed(1) + " " + unit;
  }

  static num randomValue() {
    Temperature temperature = const Temperature(0);
    num diff = temperature.max - temperature.min;
    return (Random().nextInt((diff).toInt()) -
        temperature.min.abs()) * temperature.multiplier;
  }

  static Temperature random() {
    return Temperature(randomValue());
  }
}

class VolumetricWaterContent {
  final num value;
  final num min = 0;
  final num max = 10000;
  final num multiplier = 0.01;
  final String unit = "%";
  final String description = "Volumetrischer Wassergehalt";

  const VolumetricWaterContent(this.value);

  @override
  String toString() {
    return value.toStringAsFixed(1) + " " + unit;
  }

  static num randomValue() {
    VolumetricWaterContent vwc = const VolumetricWaterContent(0);
    num diff = vwc.max - vwc.min;
    return (Random().nextInt((diff).toInt()) - vwc.min.abs()) * vwc.multiplier;
  }

  static VolumetricWaterContent random() {
    return VolumetricWaterContent(randomValue());
  }
}

class ElectricalConductivity {
  final num value;
  final num min = 0;
  final num max = 20000;
  final num multiplier = 1;
  final String unit = "us/cm";
  final String description = "Elektrische Leitfähigkeit";

  const ElectricalConductivity(this.value);

  @override
  String toString() {
    return value.toStringAsFixed(1) + " " + unit;
  }

  static num randomValue() {
    ElectricalConductivity ec = const ElectricalConductivity(0);
    num diff = ec.max - ec.min;
    return (Random().nextInt((diff).toInt()) - ec.min.abs()) * ec.multiplier;
  }

  static ElectricalConductivity random() {
    return ElectricalConductivity(randomValue());
  }
}

class Salinity {
  final num value;
  final num min = 0;
  final num max = 20000;
  final num multiplier = 1;
  final String unit = "mg/L";
  final String description = "Salzgehalt";

  const Salinity(this.value);

  @override
  String toString() {
    return value.toStringAsFixed(1) + " " + unit;
  }

  static num randomValue() {
    Salinity salinity = const Salinity(0);
    num diff = salinity.max - salinity.min;
    return (Random().nextInt((diff).toInt()) -
        salinity.min.abs()) * salinity.multiplier;
  }

  static Salinity random() {
    return Salinity(randomValue());
  }
}

class TotalDissolvedSolids {
  final num value;
  final num min = 0;
  final num max = 20000;
  final num multiplier = 1;
  final String unit = "mg/L";
  final String description = "Abdampfrückstand";

  const TotalDissolvedSolids(this.value);

  @override
  String toString() {
    return value.toStringAsFixed(1) + " " + unit;
  }

  static num randomValue() {
    TotalDissolvedSolids tds = const TotalDissolvedSolids(0);
    num diff = tds.max - tds.min;
    return (Random().nextInt((diff).toInt()) - tds.min.abs()) * tds.multiplier;
  }

  static TotalDissolvedSolids random() {
    return TotalDissolvedSolids(randomValue());
  }
}

class DynamicUnit {
  final num min;
  final num max;
  final num multiplier;

  DynamicUnit(this.min, this.max, this.multiplier);
}
