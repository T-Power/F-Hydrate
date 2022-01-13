import 'dart:math';

import 'package:f_hydrate/model/sensor.dart';
import 'package:f_hydrate/model/tree_information.dart';
import 'package:f_hydrate/ui/widgets/gauge.dart';
import 'package:f_hydrate/ui/widgets/tree_information_text.dart';
import 'package:flutter/material.dart';

/**
 * StatefulWidget zur Anzeige von Bauminformationen bzw. der Messwerte.
 */
class TreeInformationTab extends StatefulWidget {
  const TreeInformationTab(
      {required this.treeInfo,
      Key? key,
      this.constraints = const BoxConstraints()})
      : super(key: key);

  /// Darzustellende Bauminformationen.
  final TreeInformation treeInfo;

  /// Maximal zur Verfügung stehende Größe in der UI.
  final BoxConstraints constraints;

  @override
  _TreeInformationTabState createState() => _TreeInformationTabState();
}

class _TreeInformationTabState extends State<TreeInformationTab>
    with TickerProviderStateMixin {
  /// Controller zur Veränderung der Tabs.
  TabController? controller;

  /// Liste aller darzustellenden Tabs.
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
            "Es gibt keinen Namen mehr"),
        bottom: TabBar(
          indicatorColor: Theme.of(context).colorScheme.secondary,
          labelColor: Theme.of(context).colorScheme.secondary,
          unselectedLabelColor: Theme.of(context).textTheme.headline1!.color,
          tabs: const [
            /// Textinformationen
            Icon(Icons.info),

            /// Wassergehalt
            Icon(Icons.local_drink),

            /// Temperatur
            Icon(Icons.thermostat),

            /// Elektrische Leitfähigkeit
            Icon(Icons.bolt),

            /// Salzgehalt
            Icon(Icons.local_florist),

            /// Gelöste Stoffe
            Icon(Icons.science),
          ],
          controller: controller!,
        ),
      ),

      /// Ausrichtung der UI Elemente als Spalte.
      body: Column(
        children: [
          /// Kompletten Platz für den Inhalt einnehmen
          Expanded(
            child: TabBarView(
              children: tabs,
              controller: controller!,
            ),
          ),

          /// Am unteren Bildschirmrand ein Widget verankern, das die Tab-Navigation erleichtert.
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

  /// Erzeugt eine Liste mit Tabs für jede Messeinheit des Sensors. Die Liste wird begonnen mit den Textinformationen über den Baum.
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
