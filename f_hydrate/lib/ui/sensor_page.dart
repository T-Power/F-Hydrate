import 'dart:math';

import 'package:f_hydrate/model/sensor.dart';
import 'package:f_hydrate/model/tree.dart';
import 'package:f_hydrate/ui/drawer.dart';
import 'package:f_hydrate/ui/widgets/gauge.dart';
import 'package:flutter/material.dart';

class SensorPage extends StatefulWidget {
  const SensorPage({Key? key, this.sensor}) : super(key: key);

  final Sensor? sensor;

  @override
  _SensorPageState createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> with TickerProviderStateMixin {
  TabController? controller;

  List<Widget> tabs = [];
  Sensor? sensor;

  @override
  void initState() {
    super.initState();
    sensor = widget.sensor ?? Sensor.randomSensor();
    tabs = buildTabs(sensor!);
    controller = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerBuilder.build(context),
      appBar: AppBar(
        title: Text(
          // sensor.name,
          'Sensor unbekannt'
        ),
        bottom: TabBar(
          indicatorColor: Theme.of(context).colorScheme.secondary,
          labelColor: Theme.of(context).colorScheme.secondary,
          unselectedLabelColor: Theme.of(context).textTheme.headline1!.color,
          tabs: const [
            Icon(Icons.local_drink),
            Icon(Icons.thermostat),
            Icon(Icons.bolt),
            Icon(Icons.local_florist),
            Icon(Icons.science),
          ],
          controller: controller!,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Expanded(
            child: TabBarView(
              children: tabs,
              controller: controller!,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          TabPageSelector(
            controller: controller!,
          ),
        ],
      ),
    );
  }

  List<Widget> buildTabs(Sensor sensor) {
    return [
      Gauge(
        unit: sensor.volumetricWaterContent,
        targetValue:
            Random().nextInt(sensor.volumetricWaterContent.max.toInt()),
      ),
      Gauge(
        unit: sensor.temperature,
        targetValue: Random().nextInt(sensor.temperature.max.toInt()),
      ),
      Gauge(
        unit: sensor.electricalConductivity,
        targetValue:
            Random().nextInt(sensor.electricalConductivity.max.toInt()),
      ),
      Gauge(
        unit: sensor.salinity,
        targetValue: Random().nextInt(sensor.salinity.max.toInt()),
      ),
      Gauge(
        unit: sensor.totalDissolvedSolids,
        targetValue: Random().nextInt(sensor.totalDissolvedSolids.max.toInt()),
      ),
    ];
  }
}
