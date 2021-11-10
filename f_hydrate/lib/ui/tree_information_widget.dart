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
    return SizedBox(
                child: Text(TreeInformation.createExample().printText()),
            );
  }
}
