import 'package:f_hydrate/model/sensor.dart';

import 'geographic_position.dart';

/**
 * Klasse, um Informationen über einen Baum zu kapseln.
 */
class TreeInformation {
  /// Die ID des Baumes.
  String id = "";

  /// Bezeichnung des Baumes, z. B. Jungbuche Campus Emil-Figge-Str, FB4, blaue Banderole.
  String name = "";

  /// Die biologische Art des Baumes.
  BiologicalTreeType type = const BiologicalTreeType();

  /// Das Pflanzdatum des Baumes.
  DateTime birthday = DateTime.now();

  /// Die genaue gegrafische Position des Baumes (Längen- und Breitengrad).
  GeographicPosition position = const GeographicPosition(0, 0);

  /// Der am Baum montierte Sensor-
  Sensor sensor = Sensor();

  /// Named constructor, erzeugt einen Beispieldatensatz.
  static TreeInformation createExample() {
    var tree = TreeInformation();
    tree.id = "tree_0123456";
    tree.name = "Baum 01";
    tree.type = BiologicalTreeType.createExample();
    tree.position =
        const GeographicPosition(51.494111843297155, 7.422219578674077);
    tree.sensor = Sensor.randomSensor();
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
