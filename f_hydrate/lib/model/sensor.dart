import 'package:f_hydrate/model/tree.dart';

class Sensor {
  String id;
  String name;
  String unit;
  double latitude;
  double longitude;
  Temperature temperature;
  VolumetricWaterContent volumetricWaterContent;
  ElectricalConductivity electricalConductivity;
  Salinity salinity;
  TotalDissolvedSolids totalDissolvedSolids;
  Tree tree;

  Sensor({
    this.id = '',
    this.name = '',
    this.unit = '',
    this.latitude = 0,
    this.longitude = 0,
    this.temperature = const Temperature(0),
    this.volumetricWaterContent = const VolumetricWaterContent(0),
    this.electricalConductivity = const ElectricalConductivity(0),
    this.salinity = const Salinity(0),
    this.totalDissolvedSolids = const TotalDissolvedSolids(0),
    this.tree = const Tree(),
  });
}

class Temperature {
  final num value;
  final num min = -4000;
  final num max = 8000;
  final num multiplier = 0.01;
  final String unit = "°C";
  final String description = "Temperatur";

  const Temperature(this.value);
}

class VolumetricWaterContent {
  final num value;
  final num min = 0;
  final num max = 10000;
  final num multiplier = 0.01;
  final String unit = "%";
  final String description = "Volumetrischer Wassergehalt";

  const VolumetricWaterContent(this.value);
}

class ElectricalConductivity {
  final num value;
  final num min = 0;
  final num max = 20000;
  final num multiplier = 1;
  final String unit = "us/cm";
  final String description = "Elektrische Leitfähigkeit";

  const ElectricalConductivity(this.value);
}

class Salinity {
  final num value;
  final num min = 0;
  final num max = 20000;
  final num multiplier = 1;
  final String unit = "mg/L";
  final String description = "Salzgehalt";

  const Salinity(this.value);
}

class TotalDissolvedSolids {
  final num value;
  final num min = 0;
  final num max = 20000;
  final num multiplier = 1;
  final String unit = "mg/L";
  final String description = "Abdampfrückstand";

  const TotalDissolvedSolids(this.value);
}
