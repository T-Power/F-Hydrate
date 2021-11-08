import 'geographic_position.dart';

class TreeInformation {
  String name = "";
  String type = "";
  DateTime birthday = DateTime.now();
  double waterLevel = 0;
  GeographicPosition position = GeographicPosition();

  String printText() {
    return "Name: " +
        name +
        "Type: " +
        type +
        "Birthday: " +
        birthday.toString() +
        "Water Level: " +
        waterLevel.toString() +
        "Longitude: " +
        position.longitude.toString() +
        "Latitude: " +
        position.latitude.toString();
  }

static TreeInformation createExample(){
  var tree = TreeInformation();
  tree.name = "Baum 01";
  tree.waterLevel = 75.02;
  tree.type = "Fichte";
  
  return tree;
}

}
