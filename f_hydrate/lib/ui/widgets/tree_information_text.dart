import 'package:f_hydrate/model/tree_information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../popup_text_style.dart';

class TreeInformationTextWidget extends StatefulWidget {
  const TreeInformationTextWidget({Key? key, required this.model})
      : super(key: key);

  final TreeInformation model;

  @override
  TreeInformationTextWidgetState createState() =>
      TreeInformationTextWidgetState();
}

class TreeInformationTextWidgetState
    extends State<TreeInformationTextWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: buildList(),
    );
  }

  ListView buildList() {
    return ListView(
        // mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: buildTreeInformation());
  }

  String getFormattedDate(DateTime date) {
    return date.day.toString() +
        "." +
        date.month.toString() +
        "." +
        date.year.toString();
  }

  List<Widget> buildTreeInformation() {
    return [
      Text(
        "Bauminformationen",
        style: Theme.of(context).textTheme.headline5,
      ),
      Text('ID: ${widget.model.id}'),
      const SizedBox(height: 20),
      createPropertyRow(
        "Name",
        widget.model.name,
      ),
      createDivider(),
      createPropertyRow(
        "Typ",
        widget.model.type.name,
      ),
      createDivider(),
      createPropertyRow(
        "Pflanzdatum",
        getFormattedDate(widget.model.birthday),
      ),
      createDivider(),
      createPropertyRow(
        "Temperatur",
        widget.model.sensor.temperature.toString(),
      ),
      createDivider(),
      createPropertyRow(
        "Wassergehalt",
        widget.model.sensor.volumetricWaterContent.toString(),
      ),
      createDivider(),
      createPropertyRow(
        "Salzgehalt",
        widget.model.sensor.salinity.toString(),
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
