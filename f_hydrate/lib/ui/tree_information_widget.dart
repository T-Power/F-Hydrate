import 'package:f_hydrate/model/sensor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:f_hydrate/model/tree_information.dart';
import 'popup_text_style.dart';

class TreeInformationWidget extends StatefulWidget {
  const TreeInformationWidget({Key? key, this.onClosePressed})
      : super(key: key);

  final void Function()? onClosePressed;

  @override
  TreeInformationWidgetState createState() => TreeInformationWidgetState();
}

class TreeInformationWidgetState extends State<TreeInformationWidget> {


  @override
  Widget build(BuildContext context) {
    return SizedBox(
         width: 300,
         height: 400,
        child: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Align(alignment: Alignment.topRight, child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    var closePressed = widget.onClosePressed;
                    if(closePressed != null){
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
                const Text("ID: tree_01234"),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextPopup(
                      text: "Baumtyp",
                      isBold: true,
                    ),
                    TextPopup(
                      text: "Fichte",
                      isBold: false,
                    ),
                  ],
                ),
                const Divider(color: Colors.grey),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextPopup(
                      text: "Alter",
                      isBold: true,
                    ),
                    TextPopup(
                      text: "10 Jahre",
                      isBold: false,
                    ),
                  ],
                ),
                const Divider(color: Colors.grey),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextPopup(
                      text: "Position",
                      isBold: true,
                    ),
                    TextPopup(
                      text: "An der Straße 3",
                      isBold: false,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

/*child: SizedBox(
                width: 200,
                height: 100,
                child: Text(TreeInformation.createExample().printText()),*/
