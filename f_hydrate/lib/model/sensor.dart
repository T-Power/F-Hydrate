import 'dart:math';

import 'package:f_hydrate/model/tree_information.dart';

/**
 * Klasse, um Daten über einen vergrabenen Sensor zu halten.
 */
class Sensor {
  /// Die Id des Sensors.
  int id = 0;

  /// MQTT Id des Sensors.
  int mqtt_sensor_id = 0;

  /// Tiefen Id des Sensors
  int depth = 1;

  /// Eine sprechende Bezeichnung des Sensors, z. B. "Campus Emil-Figge-Straße, FB4".
  // String name;
  /**/

  /// Akkuspannung des Sensors
  Voltage voltage = const Voltage(0);

  /// Aktuelle Temperatur.
  Temperature temperature = const Temperature(0);

  /// Aktueller Wassergehalt der Erde.
  VolumetricWaterContent volumetricWaterContent =
      const VolumetricWaterContent(0);

  /// Elektrische Leitfähigkeit der Erde.
  ElectricalConductivity electricalConductivity =
      const ElectricalConductivity(0);

  /// Salzgehalt der Erde.
  Salinity salinity = const Salinity(0);

  /// Im Bodem gelöste Stoffe.
  TotalDissolvedSolids totalDissolvedSolids = const TotalDissolvedSolids(0);

  /// Zeitstempel der Messung
  DateTime dateTime = DateTime.now();

  /// Biologische Informationen über den Baum (Art, Sollwerte, etc.).
  BiologicalTreeType tree = const BiologicalTreeType();

  /**
   * Ein Standardkonstruktor, der alle Werte mit 0 bzw. '' initialisiert.
   */
  Sensor.standardValues({
    this.id = 1,
    this.mqtt_sensor_id = 1,
    this.depth = 1,
    this.voltage = const Voltage(0),
    this.temperature = const Temperature(0),
    this.volumetricWaterContent = const VolumetricWaterContent(0),
    this.electricalConductivity = const ElectricalConductivity(0),
    this.salinity = const Salinity(0),
    this.totalDissolvedSolids = const TotalDissolvedSolids(0),
    this.tree = const BiologicalTreeType(),
  });

  factory Sensor.fromJson(Map<String, dynamic> json) {
    return Sensor(
        id: json['id'],
        mqtt_sensor_id: json['mqtt_sensor_id'],
        depth: json['depth'] ?? -1,
        voltage: Voltage(json['voltage']),
        temperature: Temperature(json['temperature']),
        volumetricWaterContent: VolumetricWaterContent(json['vwc']),
        electricalConductivity: ElectricalConductivity(json['ec']),
        salinity: Salinity(json['salinity']),
        totalDissolvedSolids: TotalDissolvedSolids(json['tds']),
        dateTime: DateTime.parse(json['time']),
        tree: BiologicalTreeType());
  }

  static List<Sensor> listFromJson(List<dynamic> json) {
    List<Map<String, dynamic>> jsonList = json.cast<Map<String, dynamic>>();
    List<Sensor> sensors = new List.of([], growable: true);
    for (Map<String, dynamic> map in json) {
      sensors.add(Sensor.fromJson(map));
    }
    return sensors;
  }

  Map<String, dynamic> toTreeCreationSensorJson() {
    Map<String, dynamic> map = new Map();
    map['"mqtt_sensor_id"'] = this.mqtt_sensor_id;
    map['"depth"'] = this.depth;
    return map;
  }

  /**
   * Konstruktor für die Klasse Sensor
   */
  Sensor({
    required this.id,
    required this.mqtt_sensor_id,
    required this.depth,
    required this.voltage,
    required this.temperature,
    required this.volumetricWaterContent,
    required this.electricalConductivity,
    required this.salinity,
    required this.totalDissolvedSolids,
    required this.dateTime,
    required this.tree,
  });

  /**
   * Named constructor, um einen Beispielsensor mit realistischen, statischen Daten zu erzeugen.
   */
  static Sensor createExample() {
    Sensor s = Sensor.standardValues();
    s.temperature = const Temperature(20.5);
    s.volumetricWaterContent = const VolumetricWaterContent(75.5);
    s.salinity = const Salinity(10.67);
    s.totalDissolvedSolids = const TotalDissolvedSolids(5.1);
    s.tree = const BiologicalTreeType();
    return s;
  }

  /**
   * Named constructor, um einen Beispielsensor mit zufälligen Daten zu erzeugen.
   */
  static Sensor randomSensor() {
    return Sensor(
        id: 0,
        mqtt_sensor_id: 0,
        depth: 1,
        voltage: Voltage.random(),
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
        dateTime: DateTime.now(),
        tree: BiologicalTreeType.createExample());
  }
}

/**
 * Klasse, um Werte für die Temperatur zu kapseln.
 */
class Temperature {
  /// Der aktuelle Wert als Fließkommazahl.
  final num value;

  /// Der minimal gültiger/messbarer Wert.
  final num min = -4000;

  /// Der maximal gültiger/messbarer Wert.
  final num max = 8000;

  /// Multiplikator zur Umrechnung in einen logischen Wert. Ein Wert von 8000.0 entspricht einer Temperatur von 80° C.
  final num multiplier = 0.01;

  /// Die Einheit, in der die Temperatur gemessen wird.
  final String unit = "°C";

  /// Der Anzeigename für diese Messeinheit.
  final String description = "Temperatur";

  /// Konstruktor zur Erzeugung eines Temperatur-Objekts.
  const Temperature(this.value);

  /// Methode, um den aktuellen Wert als String mit 1 Nachkommastelle und Einheit auszugeben.
  @override
  String toString() {
    return (value * multiplier).toStringAsFixed(1) + " " + unit;
  }

  /// Erzeugt einen zufälligen Wert im zulässigen Wertebereich.
  static num randomValue() {
    Temperature temperature = const Temperature(0);
    num diff = temperature.max - temperature.min;
    return (Random().nextInt((diff).toInt()) - temperature.min.abs()) *
        temperature.multiplier;
  }

  /// Erzeugt ein zufälliges Temperatur-Objekt.
  static Temperature random() {
    return Temperature(randomValue());
  }
}

/**
 * Klasse, um Werte für den Wassergehalt der Erde zu kapseln.
 */
class VolumetricWaterContent {
  /// Der aktuelle Wert als Fließkommazahl.
  final num value;

  /// Der minimal gültiger/messbarer Wert.
  final num min = 0;

  /// Der maximal gültiger/messbarer Wert.
  final num max = 10000;

  /// Multiplikator zur Umrechnung in einen logischen Wert. Ein Wert von 10000.0 entspricht einer Feuchtigkeit von 100%.
  final num multiplier = 0.01;

  /// Die Einheit, in der die Feuchtigkeit gemessen wird.
  final String unit = "%";

  /// Der Anzeigename für diese Messeinheit.
  final String description = "Volumetrischer Wassergehalt";

  /// Konstruktor zur Erzeugung eines Feuchtigkeit-Objekts.
  const VolumetricWaterContent(this.value);

  /// Methode, um den aktuellen Wert als String mit 1 Nachkommastelle und Einheit auszugeben.
  @override
  String toString() {
    return (value * multiplier).toStringAsFixed(1) + " " + unit;
  }

  /// Erzeugt einen zufälligen Wert im zulässigen Wertebereich.
  static num randomValue() {
    VolumetricWaterContent vwc = const VolumetricWaterContent(0);
    num diff = vwc.max - vwc.min;
    return (Random().nextInt((diff).toInt()) - vwc.min.abs()) * vwc.multiplier;
  }

  /// Erzeugt ein zufälliges Feuchtigkeit-Objekt.
  static VolumetricWaterContent random() {
    return VolumetricWaterContent(randomValue());
  }
}

class ElectricalConductivity {
  /// Der aktuelle Wert als Fließkommazahl.
  final num value;

  /// Der minimal gültiger/messbarer Wert.
  final num min = 0;

  /// Der maximal gültiger/messbarer Wert.
  final num max = 20000;

  /// Multiplikator zur Umrechnung in einen logischen Wert.
  final num multiplier = 1;

  /// Die Einheit, in der die El. Leitfähigkeit gemessen wird.
  final String unit = "us/cm";

  /// Der Anzeigename für diese Messeinheit.
  final String description = "Elektrische Leitfähigkeit";

  /// Konstruktor zur Erzeugung eines El. Leitfähigkeit-Objekts.
  const ElectricalConductivity(this.value);

  /// Methode, um den aktuellen Wert als String mit 1 Nachkommastelle und Einheit auszugeben.
  @override
  String toString() {
    return (value * multiplier).toStringAsFixed(1) + " " + unit;
  }

  /// Erzeugt einen zufälligen Wert im zulässigen Wertebereich.
  static num randomValue() {
    ElectricalConductivity ec = const ElectricalConductivity(0);
    num diff = ec.max - ec.min;
    return (Random().nextInt((diff).toInt()) - ec.min.abs()) * ec.multiplier;
  }

  /// Erzeugt ein zufälliges El. Leitfähigkeit-Objekt.
  static ElectricalConductivity random() {
    return ElectricalConductivity(randomValue());
  }
}

/**
 * Klasse, um Werte für den Salzgehalt der Erde zu kapseln.
 */
class Salinity {
  /// Der aktuelle Wert als Fließkommazahl.
  final num value;

  /// Der minimal gültiger/messbarer Wert.
  final num min = 0;

  /// Der maximal gültiger/messbarer Wert.
  final num max = 20000;

  /// Multiplikator zur Umrechnung in einen logischen Wert.
  final num multiplier = 1;

  /// Die Einheit, in der der Salzgehalt gemessen wird.
  final String unit = "mg/L";

  /// Der Anzeigename für diese Messeinheit.
  final String description = "Salzgehalt";

  /// Konstruktor zur Erzeugung eines Salzgehalt-Objekts.
  const Salinity(this.value);

  /// Methode, um den aktuellen Wert als String mit 1 Nachkommastelle und Einheit auszugeben.
  @override
  String toString() {
    return (value * multiplier).toStringAsFixed(1) + " " + unit;
  }

  /// Erzeugt einen zufälligen Wert im zulässigen Wertebereich.
  static num randomValue() {
    Salinity salinity = const Salinity(0);
    num diff = salinity.max - salinity.min;
    return (Random().nextInt((diff).toInt()) - salinity.min.abs()) *
        salinity.multiplier;
  }

  /// Erzeugt ein zufälliges Salzgehalt-Objekt.
  static Salinity random() {
    return Salinity(randomValue());
  }
}

/**
 * Klasse um Werte für die gelösten Stoffe in der Erde zu kapseln.
 */
class TotalDissolvedSolids {
  /// Der aktuelle Wert als Fließkommazahl.
  final num value;

  /// Der minimal gültiger/messbarer Wert.
  final num min = 0;

  /// Der maximal gültiger/messbarer Wert.
  final num max = 20000;

  /// Multiplikator zur Umrechnung in einen logischen Wert.
  final num multiplier = 1;

  /// Die Einheit, in der die gelösten Stoffe gemessen werden.
  final String unit = "mg/L";

  /// Der Anzeigename für diese Messeinheit.
  final String description = "Abdampfrückstand";

  /// Konstruktor zur Erzeugung eines gelöste Stoffe-Objekts.
  const TotalDissolvedSolids(this.value);

  /// Methode, um den aktuellen Wert als String mit 1 Nachkommastelle und Einheit auszugeben.
  @override
  String toString() {
    return (value * multiplier).toStringAsFixed(1) + " " + unit;
  }

  /// Erzeugt einen zufälligen Wert im zulässigen Wertebereich.
  static num randomValue() {
    TotalDissolvedSolids tds = const TotalDissolvedSolids(0);
    num diff = tds.max - tds.min;
    return (Random().nextInt((diff).toInt()) - tds.min.abs()) * tds.multiplier;
  }

  /// Erzeugt ein zufälliges gelöste Stoffe-Objekt.
  static TotalDissolvedSolids random() {
    return TotalDissolvedSolids(randomValue());
  }
}

class Voltage {
  /// Der aktuelle Wert als Fließkommazahl.
  final num value;

  /// Multiplikator zur Umrechnung in einen logischen Wert.
  final num multiplier = 1;

  /// Die Einheit, in der die gelösten Stoffe gemessen werden.
  final String unit = "V";

  /// Konstruktor zur Erzeugung eines gelöste Stoffe-Objekts.
  const Voltage(this.value);

  /// Methode, um den aktuellen Wert als String mit 1 Nachkommastelle und Einheit auszugeben.
  @override
  String toString() {
    return (value * multiplier).toStringAsFixed(1) + " " + unit;
  }

  /// Erzeugt ein zufälliges gelöste Stoffe-Objekt.
  static Voltage random() {
    return Voltage(1.1);
  }
}

/**
 * Klasse, um Werte für eine generische Verarbeitung von Messwerten zu kapseln.
 */
class DynamicUnit {
  /// Der minimal gültiger/messbarer Wert.
  final num min;

  /// Der maximal gültiger/messbarer Wert.
  final num max;

  /// Multiplikator zur Umrechnung in einen logischen Wert.
  final num multiplier;

  /// Konstruktor zur Erzeugung eines generischen Messeinheit-Objekts.
  DynamicUnit(this.min, this.max, this.multiplier);
}
