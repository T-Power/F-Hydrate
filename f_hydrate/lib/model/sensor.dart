class Sensor {
  String id;
  String name;
  String description;
  double latitude;
  double longitude;
  double temperature;
  double volumetricWaterContent;
  double electricalConductivity;
  double salinity;
  double totalDissolvedSolids;

  Sensor(
      {this.id = '',
      this.name = '',
      this.description = '',
      this.latitude = 0,
      this.longitude = 0,
      this.temperature = 0,
      this.volumetricWaterContent = 0,
      this.electricalConductivity = 0,
      this.salinity = 0,
      this.totalDissolvedSolids = 0});
}
