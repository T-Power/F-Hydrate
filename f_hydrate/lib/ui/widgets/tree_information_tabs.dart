import 'dart:math';

import 'package:f_hydrate/model/sensor.dart';
import 'package:f_hydrate/model/tree_information.dart';
import 'package:f_hydrate/ui/widgets/gauge.dart';
import 'package:f_hydrate/ui/widgets/tree_information_text.dart';
import 'package:flutter/material.dart';

class TreeInformationTab extends StatefulWidget {
  const TreeInformationTab(
      {required this.treeInfo,
      Key? key,
      this.constraints = const BoxConstraints()})
      : super(key: key);

  final TreeInformation treeInfo;
  final BoxConstraints constraints;

  @override
  _TreeInformationTabState createState() => _TreeInformationTabState();
}

class _TreeInformationTabState extends State<TreeInformationTab>
    with TickerProviderStateMixin {
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
      appBar: AppBar(
        title: Text(
            // sensor.name,
            widget.treeInfo.name),
        bottom: TabBar(
          indicatorColor: Theme.of(context).colorScheme.secondary,
          labelColor: Theme.of(context).colorScheme.secondary,
          unselectedLabelColor: Theme.of(context).textTheme.headline1!.color,
          tabs: const [
            Icon(Icons.info),
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
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Center(
              child: TabPageSelector(
                controller: controller!,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildTabs(Sensor sensor) {
    return [
      TreeInformationTextWidget(model: widget.treeInfo),
      Gauge(
        unit: sensor.volumetricWaterContent,
        targetValue:
            Random().nextInt(sensor.volumetricWaterContent.max.toInt()),
        constraints: widget.constraints,
      ),
      Gauge(
        unit: sensor.temperature,
        targetValue: Random().nextInt(sensor.temperature.max.toInt()),
        constraints: widget.constraints,
      ),
      Gauge(
        unit: sensor.electricalConductivity,
        targetValue:
            Random().nextInt(sensor.electricalConductivity.max.toInt()),
        constraints: widget.constraints,
      ),
      Gauge(
        unit: sensor.salinity,
        targetValue: Random().nextInt(sensor.salinity.max.toInt()),
        constraints: widget.constraints,
      ),
      Gauge(
        unit: sensor.totalDissolvedSolids,
        targetValue: Random().nextInt(sensor.totalDissolvedSolids.max.toInt()),
        constraints: widget.constraints,
      ),
    ];
  }
}
