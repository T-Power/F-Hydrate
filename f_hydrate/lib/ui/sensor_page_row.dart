import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:f_hydrate/model/sensor.dart';
import 'package:f_hydrate/model/tree_information.dart';
import 'package:f_hydrate/ui/drawer.dart';
import 'package:f_hydrate/ui/widgets/gauge.dart';
import 'package:flutter/material.dart';

class SensorPageRow extends StatefulWidget {
  const SensorPageRow({required this.treeInfo, Key? key}) : super(key: key);

  final TreeInformation treeInfo;

  @override
  _SensorPageRowState createState() => _SensorPageRowState();
}

class _SensorPageRowState extends State<SensorPageRow>
    with TickerProviderStateMixin {
  TabController? controller;

  List<Widget> tabs = [];
  List<Sensor> sensors = [];
  late TreeInformation treeInformation;

  @override
  void initState() {
    super.initState();
    treeInformation = widget.treeInfo;
    sensors = treeInformation.sensors;
    tabs = buildTabs();
    controller = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerBuilder.build(context),
      appBar: AppBar(
        title: Text(treeInformation.name),
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

  List<Widget> buildTabs() {
    if (sensors.length == 0) {
      return [];
    }
    num volumetricWaterContent = 0;
    num volumetricWaterContentTarget =
        Random().nextInt(VolumetricWaterContent(0).max.toInt());
    num temperature = 0;
    num temperatureTarget = 0;
    num electricalConductivity = 0;
    num electricalConductivityTarget = 0;
    num salinity = 0;
    num salinityTarget = 0;
    num totalDissolvedSolids = 0;
    num totalDissolvedSolidsTarget = 0;
    for (Sensor sensor in sensors) {
      volumetricWaterContent += sensor.volumetricWaterContent.value;
      temperature += sensor.temperature.value;
      electricalConductivity += sensor.electricalConductivity.value;
      salinity += sensor.salinity.value;
      totalDissolvedSolids += sensor.totalDissolvedSolids.value;
    }
    return [
      buildRow(VolumetricWaterContent(volumetricWaterContent / sensors.length),
          volumetricWaterContentTarget),
      buildRow(
        Temperature(temperature / sensors.length),
        Random().nextInt(Temperature(0).max.toInt()),
      ),
      buildRow(
        ElectricalConductivity(electricalConductivity / sensors.length),
        Random().nextInt(ElectricalConductivity(0).max.toInt()),
      ),
      buildRow(
        Salinity(salinity / sensors.length),
        Random().nextInt(Salinity(0).max.toInt()),
      ),
      buildRow(
        TotalDissolvedSolids(totalDissolvedSolids / sensors.length),
        Random().nextInt(TotalDissolvedSolids(0).max.toInt()),
      ),
    ];
  }

  Widget buildRow(dynamic unit, num targetValue) {
    ConfettiController controller = ConfettiController();
    return Row(
      children: [
        Gauge(
          unit: unit,
          targetValue: targetValue,
        ),
        ConfettiWidget(
          confettiController: controller,
        ),
        Container(
          color: Colors.red,
        )
      ],
    );
  }
}
