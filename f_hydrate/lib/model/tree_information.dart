import 'dart:ffi';

import 'geographic_position.dart';

class TreeInformation {
  String name;
  String type;
  DateTime birthday;
  double waterLevel;
  GeographicPosition position;


  TreeInformation(){
    name = "";
    type = "";
    birthday = DateTime.now();
    waterLevel = 0;
    position = new GeographicPosition(0,0);
  }

}