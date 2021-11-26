import 'dart:html';
import 'dart:io';

import 'package:f_hydrate/ui/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImprintWidget extends StatefulWidget {
  const ImprintWidget({Key? key}) : super(key: key);

  final String title = "Impressum";

  @override
  ImprintWidgetState createState() => ImprintWidgetState();
}

class ImprintWidgetState extends State<ImprintWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerBuilder.build(context),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: createBody(),
    );
  }

  dynamic createBody() {
    return RichText(
      text: TextSpan(
        text: 'Hello ',
        style: DefaultTextStyle.of(context).style,
        children: const <TextSpan>[
          TextSpan(text: 'bold', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: ' world!'),
        ],
      ),
    );
  }
}
