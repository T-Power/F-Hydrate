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
    tabs = buildTabs(widget.treeInfo.sensors);
    controller = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            // sensor.name,
            "Bauminformationen"),
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
  List<Widget> buildTabs(List<Sensor> sensors) {
    List<Widget> widgets = [];
    widgets = [
      TreeInformationTextWidget(model: widget.treeInfo),
      ListView(
        children: buildGauges(sensors, widget.constraints,
            "volumetricWaterContent", widget.treeInfo),
      ),
      ListView(
        children: buildGauges(
            sensors, widget.constraints, "temperature", widget.treeInfo),
      ),
      ListView(
        children: buildGauges(sensors, widget.constraints,
            "electricalConductivity", widget.treeInfo),
      ),
      ListView(
        children: buildGauges(
            sensors, widget.constraints, "salinity", widget.treeInfo),
      ),
      ListView(
        children: buildGauges(sensors, widget.constraints,
            "totalDissolvedSolids", widget.treeInfo),
      ),
    ];
    return widgets;
  }

  List<Widget> buildGauges(List<Sensor> sensors, BoxConstraints constraints,
      String unit, TreeInformation treeInfo) {
    List<Widget> widgets = [];
    for (Sensor sensor in sensors) {
      switch (unit) {
        case "volumetricWaterContent":
          num targetValue = 0;
          widgets.add(
            SizedBox(
              height: constraints.maxHeight * 0.85,
              width: constraints.maxWidth,
              child: Gauge(
                description: "Sensor Id ${sensor.id}",
                unit: sensor.volumetricWaterContent,
                targetValue: targetValue,
                constraints: constraints,
              ),
            ),
          );
          break;
        case "temperature":
          num targetValue = 0;
          widgets.add(
            SizedBox(
              height: constraints.maxHeight * 0.85,
              width: constraints.maxWidth,
              child: Gauge(
                description: "Sensor Id ${sensor.id}",
                unit: sensor.temperature,
                targetValue: targetValue,
                constraints: constraints,
              ),
            ),
          );
          break;
        case "electricalConductivity":
          num targetValue = 0;
          widgets.add(
            SizedBox(
              height: constraints.maxHeight * 0.85,
              width: constraints.maxWidth,
              child: Gauge(
                description: "Sensor Id ${sensor.id}",
                unit: sensor.electricalConductivity,
                targetValue: targetValue,
                constraints: constraints,
              ),
            ),
          );
          break;
        case "salinity":
          num targetValue = 0;
          widgets.add(
            SizedBox(
              height: constraints.maxHeight * 0.85,
              width: constraints.maxWidth,
              child: Gauge(
                description: "Sensor Id ${sensor.id}",
                unit: sensor.salinity,
                targetValue: targetValue,
                constraints: constraints,
              ),
            ),
          );
          break;
        case "totalDissolvedSolids":
          num targetValue = 0;
          widgets.add(
            SizedBox(
              height: constraints.maxHeight * 0.85,
              width: constraints.maxWidth,
              child: Gauge(
                description: "Sensor Id ${sensor.id}",
                unit: sensor.totalDissolvedSolids,
                targetValue: targetValue,
                constraints: constraints,
              ),
            ),
          );
          break;
      }
    }
    return widgets;
  }
}
