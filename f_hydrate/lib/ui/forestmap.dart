import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'drawer.dart';
import 'not_implemented_widget.dart';

/* https://pub.dev/packages/flutter_map -> Dokumentation zu flutter_map */
class ForestMap extends StatefulWidget {
  const ForestMap({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ForestMap> createState() => _ForestMapState();
}

class _ForestMapState extends State<ForestMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerBuilder.build(context),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: FlutterMap(
        options: MapOptions(
          /* TODO Hier müssen wir gucken welcher Mittelpunkt Sinn ergibt */
          center: LatLng(51.494111843297155, 7.422219578674077),
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
            attributionBuilder: (_) {
              return const Text("© OpenStreetMap contributors");
            },
          ),
          MarkerLayerOptions(
            markers: [
              /* TODO Hier brauchen wir vermutlich sowas wie einen FutureBuilder um alle Bäume,
                  die wir vom Backend bekommen, anzuzeigen */
              Marker(
                point: LatLng(51.494111843297155, 7.422219578674077),
                builder: (ctx) => IconButton(
                  icon: const Icon(
                    Icons.location_on,
                    size: 30.0,
                  ),
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) =>
                        const NotImplementedWidget(
                      key: Key('treeAlertDialog'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
