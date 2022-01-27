import 'package:f_hydrate/model/sensor.dart';
import 'package:f_hydrate/util/DateUtil.dart';

import 'geographic_position.dart';

/**
 * Klasse, um Informationen über einen Baum zu kapseln.
 */
class TreeInformation {
  /// Die ID des Baumes.
  int id = 0;

  /// Das Pflanzdatum des Baumes.
  DateTime plantedDate = DateTime.now();

  /// Die genaue gegrafische Position des Baumes (Längen- und Breitengrad).
  GeographicPosition position = const GeographicPosition(0, 0);

  /// Lebensbereich Faktor (L)
  double locationFactor = 0;

  /// Bodenart Faktor (B)
  double soilTypeFactor = 0;

  /// Seonnenexposition Faktor (S)
  double sunExpositionFactor = 0;

  /// Handelt es sich um einen jungen Baum?
  bool youngTree = false;

  /// Der am Baum montierte Sensor.
  List<Sensor> sensors =
      new List.from({Sensor.standardValues()}, growable: true);

  /// Bezeichnung des Baumes, z. B. Jungbuche Campus Emil-Figge-Str, FB4, blaue Banderole.
  //String name = "";

  /// Die biologische Art des Baumes.
  BiologicalTreeType type = const BiologicalTreeType();

  factory TreeInformation.fromJson(Map<String, dynamic> json) {
    return TreeInformation(
        id: json['id'],
        plantedDate: DateTime.parse(json['plantedDate']),
        position: GeographicPosition(json['latitude'], json['longitude']),
        youngTree: json['youngTree'],
        locationFactor: json['locationFactor'],
        soilTypeFactor: json['soilTypeFactor'],
        sunExpositionFactor: json['sunExpositionFactor'],
        sensors: new List.from({
          json['latestMeasurement'] == null
              ? Sensor.standardValues()
              : Sensor.fromJson(json['latestMeasurement'])
        }, growable: true));
  }

  Map<String, dynamic> toTreeCreationJson() {
    return {
      '"plantedDate"': '"' + this.plantedDate.toBackendDateString() + '"',
      '"longitude"': this.position.longitude,
      '"latitude"': this.position.latitude,
      '"locationFactor"': this.locationFactor,
      '"sunExpositionFactor"': this.sunExpositionFactor,
      '"soilTypeFactor"': this.soilTypeFactor,
      '"youngTree"': this.youngTree,
      '"sensors"': buildSensorList(),
    };
  }

  String buildSensorList() {
    List<Map<String, dynamic>> list = new List.of([], growable: true);
    for (Sensor sensor in sensors) {
      list.add(sensor.toTreeCreationSensorJson());
    }
    return list.toString();
  }

  TreeInformation(
      {required this.id,
      required this.plantedDate,
      required this.position,
      required this.locationFactor,
      required this.soilTypeFactor,
      required this.sunExpositionFactor,
      required this.youngTree,
      required this.sensors});

  /// Named constructor, erzeugt einen Beispieldatensatz.
  static TreeInformation createExample() {
    var tree = TreeInformation(
      id: 1,
      plantedDate: DateTime.now(),
      locationFactor: 1.0,
      soilTypeFactor: 0.9,
      sunExpositionFactor: 1.0,
      youngTree: true,
      position: const GeographicPosition(51.494111843297155, 7.422219578674077),
      sensors: new List.from({Sensor.randomSensor()}, growable: true),
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
