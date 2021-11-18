import 'package:f_hydrate/ui/tree_information_widget.dart';
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
  bool controllerReady = false;
  double zoom = 13.0;

  /* TODO Hier müssen wir gucken welcher initiale Mittelpunkt Sinn ergibt */
  LatLng initialCenter = LatLng(51.494111843297155, 7.422219578674077);
  MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
    mapController.onReady.then((_) => controllerReady = true);
  }

  void _zoom(double value) {
    if (controllerReady) {
      double newValue = mapController.zoom + value;
      if (newValue > 1 && newValue < 19) {
        mapController.move(mapController.center, newValue);
      }
    }
  }

  void _center() {
    if (controllerReady) {
      mapController.move(initialCenter, mapController.zoom);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerBuilder.build(context),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center: initialCenter,
          zoom: zoom,
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
                      builder: (BuildContext context) {
                        return const AlertDialog(
                            content: TreeInformationWidget(title: "Testtitel"));
                      }),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Row(
        // https://www.youtube.com/watch?v=nvAh3ENt2Kk&t=98s
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: "btnCenter",
            onPressed: () => _center(),
            child: const Icon(
              Icons.center_focus_strong,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            heroTag: "btnZoomOut",
            onPressed: () => _zoom(-1),
            child: const Icon(
              Icons.zoom_out,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            heroTag: "btnZoomIn",
            onPressed: () => _zoom(1),
            child: const Icon(
              Icons.zoom_in,
            ),
          ),
        ],
      ),
    );
  }
}
