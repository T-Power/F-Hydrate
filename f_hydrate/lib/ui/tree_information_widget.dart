import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TreeInformationWidget extends StatefulWidget {
  const TreeInformationWidget({Key? key}) : super(key: key);

  @override
  TreeInformationWidgetState createState() => TreeInformationWidgetState();
}

class TreeInformationWidgetState extends State<TreeInformationWidget> {
  @override
  Widget build(BuildContext context) {
    return const Card(
      child: SizedBox(
        width: 200,
        height: 100,
        child: Text("thimo"),
      ),
    );
  }
}
