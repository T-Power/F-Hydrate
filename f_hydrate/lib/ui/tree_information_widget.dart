import 'package:f_hydrate/model/sensor.dart';
import 'package:f_hydrate/model/tree_information.dart';
import 'package:f_hydrate/ui/widgets/gauge.dart';
import 'package:f_hydrate/util/DateUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'popup_text_style.dart';

/**
 * Erzeugt die Bauminformationen in Popup mit einer scrollbaren Liste.
 *
 * Siehe auch [TreeInformationTab].
 */
class TreeInformationWidget extends StatefulWidget {
  const TreeInformationWidget(
      {Key? key, required this.model, this.onClosePressed})
      : super(key: key);

  final TreeInformation model;
  final void Function()? onClosePressed;

  @override
  TreeInformationWidgetState createState() => TreeInformationWidgetState();
}

class TreeInformationWidgetState extends State<TreeInformationWidget> {
  final bool _useList = true;
  final List<Widget> contentWidgets = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width *
        MediaQuery.of(context).devicePixelRatio;
    return SizedBox(
      width: width * 0.25,
      child: new LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: buildContent(constraints),
          ),
        );
      }),
    );
  }

  Widget buildContent(BoxConstraints constraints) {
    if (_useList) {
      contentWidgets.clear();
      contentWidgets.add(buildCloseButton());
      for(Sensor sensor in widget.model.sensors) {
        contentWidgets.addAll(buildTreeInformation(sensor));
        contentWidgets.addAll(buildGauges(constraints, sensor));
      }
      return buildList();
    }
    return Container();
  }

  List<Widget> buildGauges(BoxConstraints constraints, Sensor sensor) {
    return [
      SizedBox(
        height: 10,
      ),
      Gauge(
        unit: sensor.volumetricWaterContent,
        targetValue: widget.model.type.targetVolumetricWaterContent.value,
        constraints: constraints,
      ),
      SizedBox(
        height: 10,
      ),
      Gauge(
        unit: sensor.temperature,
        targetValue: widget.model.type.targetTemperature.value,
        constraints: constraints,
      ),
      SizedBox(
        height: 10,
      ),
      Gauge(
        unit: sensor.electricalConductivity,
        targetValue: widget.model.type.targetElectricalConductivity.value,
        constraints: constraints,
      ),
      SizedBox(
        height: 10,
      ),
      Gauge(
        unit: sensor.salinity,
        targetValue: widget.model.type.targetSalinity.value,
        constraints: constraints,
      ),
      SizedBox(
        height: 10,
      ),
      Gauge(
        unit: sensor.totalDissolvedSolids,
        targetValue: widget.model.type.targetTotalDissolvedSolids.value,
        constraints: constraints,
      ),
      SizedBox(
        height: 10,
      ),
    ];
  }

  ListView buildList() {
    return ListView(
        // mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: contentWidgets);
  }

  Widget buildCloseButton() {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        icon: const Icon(Icons.close_rounded),
        onPressed: () {
          var closePressed = widget.onClosePressed;
          if (closePressed != null) {
            closePressed();
          }
        },
      ),
    );
  }

  List<Widget> buildTreeInformation(Sensor sensor) {
    return [
      Text('ID: ${widget.model.id}'),
      const SizedBox(height: 20),
      createDivider(),
      createPropertyRow(
        "Akkuspannung",
        sensor.voltage.toString(),
      ),
      createDivider(),
      createPropertyRow(
        "Pflanzdatum",
        widget.model.plantedDate.toDateString(),
      ),
      createDivider(),
      createPropertyRow(
        "Temperatur",
        sensor.temperature.toString(),
      ),
      createDivider(),
      createPropertyRow(
        "Wassergehalt",
        sensor.volumetricWaterContent.toString(),
      ),
      createDivider(),
      createPropertyRow(
        "Salzgehalt",
        sensor.salinity.toString(),
      ),
    ];
  }

  Row createPropertyRow(String header, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextPopup(
          text: header,
          isBold: true,
        ),
        TextPopup(
          text: value,
          isBold: false,
        ),
      ],
    );
  }

  Divider createDivider() {
    return Divider(color: Theme.of(context).textTheme.headline1!.color);
  }
}
