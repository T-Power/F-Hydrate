import 'dart:math';

import 'package:f_hydrate/model/sensor.dart';
import 'package:f_hydrate/model/tree_information.dart';
import 'package:f_hydrate/ui/drawer.dart';
import 'package:f_hydrate/ui/widgets/gauge.dart';
import 'package:flutter/material.dart';

class SensorPage extends StatefulWidget {
  const SensorPage({required this.treeInfo, Key? key}) : super(key: key);

  final TreeInformation treeInfo;

  @override
  _SensorPageState createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> with TickerProviderStateMixin {
  TabController? controller;

  List<Widget> tabs = [];

  @override
  void initState() {
    super.initState();
    tabs = buildTabs(widget.treeInfo.sensor);
    controller = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerBuilder.build(context),
      appBar: AppBar(
        title: Text(
            // sensor.name,
            'Unnamed sensor'),
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
          Expanded(
            child: TabBarView(
              children: tabs,
              controller: controller!,
            ),
          ),
          Center(
            child: TabPageSelector(
              controller: controller!,
            ),
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
