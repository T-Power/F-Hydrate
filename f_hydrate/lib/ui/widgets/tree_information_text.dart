import 'package:f_hydrate/model/tree_information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../popup_text_style.dart';

/**
 * Stateful Widget bildet die Informationen über einen Baum als Text ab.
 */
class TreeInformationTextWidget extends StatefulWidget {
  const TreeInformationTextWidget({Key? key, required this.model})
      : super(key: key);

  /// Darzustellende Bauminformationen.
  final TreeInformation model;

  @override
  TreeInformationTextWidgetState createState() =>
      TreeInformationTextWidgetState();
}

class TreeInformationTextWidgetState extends State<TreeInformationTextWidget> {
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

  /// Liefert die Textinformationen in Form einer scrollbaren ListView.
  ListView buildList() {
    return ListView(
        // mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: buildTreeInformation());
  }

  /// Formatiert das Datum zu dd.mm.yyyy
  String getFormattedDate(DateTime date) {
    return date.day.toString() +
        "." +
        date.month.toString() +
        "." +
        date.year.toString();
  }

  /// Formatiert das Datum zu dd.mm.yyyy
  String getFormattedDateTime(DateTime date) {
    return date.day.toString() +
        "." +
        date.month.toString() +
        "." +
        date.year.toString() +
        " " +
        date.hour.toString() +
        ":" +
        date.minute.toString();
  }

  /// Baut eine Liste der Informationen in Textform.
  List<Widget> buildTreeInformation() {
    return [
      Text('ID: ${widget.model.id}'),
      const SizedBox(height: 20),
      createPropertyRow(
        "Pflanzdatum",
        getFormattedDate(widget.model.birthday),
      ),
      createDivider(),
      createPropertyRow("Akkuspannung", widget.model.sensor.voltage.toString()),
      createDivider(),
      createPropertyRow(
        "Wassergehalt",
        widget.model.sensor.volumetricWaterContent.toString(),
      ),
      createDivider(),
      createPropertyRow(
        "Temperatur",
        widget.model.sensor.temperature.toString(),
      ),
      createDivider(),
      createPropertyRow(
        "Leitfähigkeit",
        widget.model.sensor.electricalConductivity.toString(),
      ),
      createDivider(),
      createPropertyRow(
        "Salzgehalt",
        widget.model.sensor.salinity.toString(),
      ),
      createDivider(),
      createPropertyRow(
        "Abdampfrückstand",
        widget.model.sensor.totalDissolvedSolids.toString(),
      ),
      createDivider(),
      createPropertyRow(
        "Zeitstempel",
        getFormattedDateTime(widget.model.sensor.dateTime),
      )
    ];
  }

  /// Erzeugt eine Zeile für Wertbezeichnung und Wert.
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

  /// Erzeugt eine optische Abtrennung.
  Divider createDivider() {
    return Divider(color: Theme.of(context).textTheme.headline1!.color);
  }
}
