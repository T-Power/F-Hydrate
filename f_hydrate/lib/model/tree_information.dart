import 'dart:convert';

import 'package:f_hydrate/model/sensor.dart';
import 'geographic_position.dart';
import 'package:intl/intl.dart';

/**
 * Klasse, um Informationen über einen Baum zu kapseln.
 */
class TreeInformation {
  /// Die ID des Baumes.
  int id = 0;

  /// Das Pflanzdatum des Baumes.
  DateTime birthday = DateTime.now();

  /// Die genaue gegrafische Position des Baumes (Längen- und Breitengrad).
  GeographicPosition position = const GeographicPosition(0, 0);

  /// Handelt es sich um einen jungen Baum?
  bool yougTree = false;

  /// Der am Baum montierte Sensor-
  Sensor sensor = Sensor.standardValues();

  /// Bezeichnung des Baumes, z. B. Jungbuche Campus Emil-Figge-Str, FB4, blaue Banderole.
  //String name = "";

  /// Die biologische Art des Baumes.
  BiologicalTreeType type = const BiologicalTreeType();

  factory TreeInformation.fromJson(Map<String, dynamic> json) {
    return TreeInformation(
        id: json['id'],
        birthday: DateTime.parse(json['plantedDate']),
        position: GeographicPosition(json['latitude'], json['longitude']),
        yougTree: json['youngTree'],
        sensor: json['latestMeasurement'] == null
            ? Sensor.standardValues()
            : Sensor(
                id: json['latestMeasurement']['id'],
                voltage: Voltage(json['latestMeasurement']['voltage']),
                temperature:
                    Temperature(json['latestMeasurement']['temperature']),
                volumetricWaterContent:
                    VolumetricWaterContent(json['latestMeasurement']['vwc']),
                electricalConductivity:
                    ElectricalConductivity(json['latestMeasurement']['ec']),
                salinity: Salinity(json['latestMeasurement']['salinity']),
                totalDissolvedSolids:
                    TotalDissolvedSolids(json['latestMeasurement']['tds']),
                dateTime: DateTime.parse(json['latestMeasurement']['time']),
                tree: BiologicalTreeType()));
  }

  TreeInformation(
      {required this.id,
      required this.birthday,
      required this.position,
      required this.yougTree,
      required this.sensor});

  /// Named constructor, erzeugt einen Beispieldatensatz.
  static TreeInformation createExample() {
    var tree = TreeInformation(
      id: 1,
      birthday: DateTime.now(),
      yougTree: true,
      position: const GeographicPosition(51.494111843297155, 7.422219578674077),
      sensor: Sensor.randomSensor(),
    );

    return tree;
  }
}

/**
 * Klasse, um Informationen über eine Baumart zu kapseln. Die Sollwerte repräsentieren die Idealwerte für diese Baumart.
 */
class BiologicalTreeType {
  /// ID der Baumart.
  final String id;

  /// Name der Baumart, z. B. Rotbuche.
  final String name;

  /// Beschreibung zur Baumart, z. B. weitere wissenswerte Informationen wie der lateinische Name, Verbreitung, etc.
  final String description;

  /// Die Soll-Temperatur.
  final Temperature targetTemperature;

  /// Der Soll-Wassergehalt.
  final VolumetricWaterContent targetVolumetricWaterContent;

  /// Die Soll-Elektrische Leitfähigkeit.
  final ElectricalConductivity targetElectricalConductivity;

  /// Der Soll-Salzgehalt.
  final Salinity targetSalinity;

  /// Der Soll-gelöste Stoffe Wert.
  final TotalDissolvedSolids targetTotalDissolvedSolids;

  /// Standardkonstruktor, um Werte mit 0 bzw. '' zu initialisieren.
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

  /// Named constructor, um einen Beispieldatensatz zu erzeugen.
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
