import 'dart:math';

import 'package:f_hydrate/model/sensor.dart';
import 'package:f_hydrate/ui/drawer.dart';
import 'package:f_hydrate/ui/widgets/gauge.dart';
import 'package:flutter/material.dart';

class SensorPage extends StatefulWidget {
  const SensorPage({Key? key, this.sensor}) : super(key: key);

  final Sensor? sensor;

  @override
  _SensorPageState createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> {
  @override
  Widget build(BuildContext context) {
    Sensor sensor = widget.sensor ?? randomSensor();
    dynamic unit = randomUnit(sensor);
    return Scaffold(
      drawer: DrawerBuilder.build(context),
      appBar: AppBar(
        title: Text('${sensor.name} ${unit.description}'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Gauge(
              unit: unit,
            ),
          ],
        ),
      ),
    );
  }

  Sensor randomSensor() {
    return Sensor(
      name: 'FH DO FB4',
      temperature: Temperature(Random().nextInt(8000)),
      volumetricWaterContent: VolumetricWaterContent(Random().nextInt(10000)),
      electricalConductivity: ElectricalConductivity(Random().nextInt(20000)),
      salinity: Salinity(Random().nextInt(20000)),
      totalDissolvedSolids: TotalDissolvedSolids(Random().nextInt(20000)),
    );
  }

  dynamic randomUnit(Sensor sensor) {
    int random = Random().nextInt(4);
    switch (random) {
      case 0:
        return sensor.temperature;
      case 1:
        return sensor.volumetricWaterContent;
      case 2:
        return sensor.electricalConductivity;
      case 3:
        return sensor.salinity;
      case 4:
        return sensor.totalDissolvedSolids;
      default:
        return sensor.volumetricWaterContent;
    }
  }
}
