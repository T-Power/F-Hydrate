import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:f_hydrate/model/tree_information.dart';

import 'drawer.dart';
import 'not_implemented_widget.dart';
import 'popup_text_style.dart';

class TreeInformationWidget extends StatefulWidget {
  const TreeInformationWidget({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  TreeInformationWidgetState createState() => TreeInformationWidgetState();
}

class TreeInformationWidgetState extends State<TreeInformationWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerBuilder.build(context),
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: SizedBox(
          width: 300,
          height: 400,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
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
          ),
        ));
  }
}

/*child: SizedBox(
                width: 200,
                height: 100,
                child: Text(TreeInformation.createExample().printText()),*/
