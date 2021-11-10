import 'package:f_hydrate/model/sensor.dart';

class Tree {
  final String id;
  final String name;
  final String description;
  final Temperature targetTemperature;
  final VolumetricWaterContent targetVolumetricWaterContent;
  final ElectricalConductivity targetElectricalConductivity;
  final Salinity targetSalinity;
  final TotalDissolvedSolids targetTotalDissolvedSolids;

  const Tree({
    this.id = '',
    this.name = '',
    this.description = '',
    this.targetTemperature = const Temperature(0),
    this.targetVolumetricWaterContent = const VolumetricWaterContent(0),
    this.targetElectricalConductivity = const ElectricalConductivity(0),
    this.targetSalinity = const Salinity(0),
    this.targetTotalDissolvedSolids = const TotalDissolvedSolids(0),
  });
}
