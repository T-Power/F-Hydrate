import 'package:f_hydrate/model/sensor.dart';

import 'geographic_position.dart';

class TreeInformation {
  String id = "";
  String name = "";
  BiologicalTreeType type = const BiologicalTreeType();
  DateTime birthday = DateTime.now();
  GeographicPosition position = const GeographicPosition(0, 0);
  Sensor sensor = Sensor();
  List<Sensor> sensors = [];

  static TreeInformation createExample() {
    var tree = TreeInformation();
    tree.id = "tree_0123456";
    tree.name = "Baum 01";
    tree.type = BiologicalTreeType.createExample();
    tree.position =
        const GeographicPosition(51.494111843297155, 7.422219578674077);
    tree.sensor = Sensor.randomSensor();
    tree.sensors.add(Sensor.randomSensor());
    tree.sensors.add(Sensor.randomSensor());
    tree.sensors.add(Sensor.randomSensor());
    return tree;
  }
}

class BiologicalTreeType {
  final String id;
  final String name;
  final String description;
  final Temperature targetTemperature;
  final VolumetricWaterContent targetVolumetricWaterContent;
  final ElectricalConductivity targetElectricalConductivity;
  final Salinity targetSalinity;
  final TotalDissolvedSolids targetTotalDissolvedSolids;

  const BiologicalTreeType({
    this.id = '',
    this.name = '',
    this.description = '',
    this.targetTemperature = const Temperature(0),
    this.targetVolumetricWaterContent = const VolumetricWaterContent(0),
    this.targetElectricalConductivity = const ElectricalConductivity(0),
    this.targetSalinity = const Salinity(0),
    this.targetTotalDissolvedSolids = const TotalDissolvedSolids(0),
  });

  static BiologicalTreeType createExample() {
    BiologicalTreeType treeType = BiologicalTreeType(
      id: "id_1239345781",
      name: 'Buche',
      description: 'Fagoideae',
      targetTemperature: Temperature.random(),
      targetSalinity: Salinity.random(),
      targetElectricalConductivity: ElectricalConductivity.random(),
      targetTotalDissolvedSolids: TotalDissolvedSolids.random(),
      targetVolumetricWaterContent: VolumetricWaterContent.random(),
    );
    return treeType;
  }
}
