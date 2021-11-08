import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:f_hydrate/model/tree_information.dart';

import 'drawer.dart';
import 'not_implemented_widget.dart';

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
        body: Container(
            width: 200,
            child: Card(
              child: SizedBox(
                width: 200,
                height: 100,
                child: Text(TreeInformation.createExample().printText()),
              ),
            )));
  }
}
