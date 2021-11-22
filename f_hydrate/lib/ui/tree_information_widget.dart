import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:f_hydrate/model/tree_information.dart';
import 'popup_text_style.dart';

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
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 300,
        //height: 400,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () {
                        var closePressed = widget.onClosePressed;
                        if (closePressed != null) {
                          closePressed();
                        }
                      },
                    )),
                const Text(
                  "Bauminformationen",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 27,
                  ),
                ),
                Text('ID: ${widget.model.id}'),
                const SizedBox(height: 20),
                createPropertyRow("Name", widget.model.name),
                createDivider(),
                createPropertyRow("Typ", widget.model.type.name),
                createDivider(),
                createPropertyRow(
                    "Pflanzdatum", getFormattedDate(widget.model.birthday)),
                createDivider(),
                createPropertyRow(
                    "Temperatur", widget.model.sensor.temperature.toString()),
                createDivider(),
                createPropertyRow("Wassergehalt",
                    widget.model.sensor.volumetricWaterContent.toString()),
                createDivider(),
                createPropertyRow(
                    "Salzgehalt", widget.model.sensor.salinity.toString()),
              ],
            ),
          ),
        ));
  }

  String getFormattedDate(DateTime date) {
    return date.day.toString() +
        "." +
        date.month.toString() +
        "." +
        date.year.toString();
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
    return const Divider(color: Colors.grey);
  }
}
