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
    return Scaffold(
      drawer: DrawerBuilder.build(context),
      appBar: AppBar(
        title: Text('${sensor.name} Feuchtigkeit'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Gauge(
              title: 'Feuchtigkeit',
              maxValue: 10000,
              currentValue: sensor.volumetricWaterContent,
            ),
          ],
        ),
      ),
    );
  }

  Sensor randomSensor() {
    return Sensor(
      name: 'FH DO FB4',
      volumetricWaterContent: Random().nextInt(10000) * 1.0,
    );
  }
}
