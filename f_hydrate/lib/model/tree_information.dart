import 'package:f_hydrate/model/sensor.dart';

import 'geographic_position.dart';

class TreeInformation {
  String id = "";
  String name = "";
  String type = "";
  DateTime birthday = DateTime.now();
  GeographicPosition position = const GeographicPosition(0, 0);
  Sensor sensor = Sensor();

  static TreeInformation createExample() {
    var tree = TreeInformation();
    tree.id = "tree_0123456";
    tree.name = "Baum 01";
    tree.type = "Buche";
    tree.position =
        const GeographicPosition(51.494111843297155, 7.422219578674077);
    tree.sensor = Sensor.createExample();
    return tree;
  }
}
