import 'package:f_hydrate/ui/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * StatefulWidget zur Anzeige des Impressums.
 */
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
      body: createBody(context),
    );
  }

  dynamic createBody(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.all(20.0),
      child: SelectableText.rich(
        TextSpan(
          style: TextStyle(
              color:
                  Theme.of(context).textTheme.headline1!.color ?? Colors.black,
              fontSize: 15),
          children: <TextSpan>[
            TextSpan(text: '''
Allgemeine Anschrift:
Prof. Dr. Dino Schönberg
Sonnenstraße 96
44139 Dortmund

Tel. +49 (0)231 9112-0
Fax +49 (0)231 9112-9313

24-Stunden-Notrufnummer der Hochschule:
Tel. +49 (0)231 9112-6789

Postanschrift:
Fachhochschule Dortmund
Postfach 10 50 18
44047 Dortmund

Rechtsform:
Körperschaft des öffentlichen Rechts
          '''),
          ],
        ),
      ),
    ));
  }
}
