import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

import 'drawer.dart';
import 'not_implemented_widget.dart';

/// https://pub.dev/packages/flutter_map -> Dokumentation zu flutter_map
class ForestMap extends StatefulWidget {
  const ForestMap({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ForestMap> createState() => _ForestMapState();
}

class _ForestMapState extends State<ForestMap> {
  bool controllerReady = false;
  double zoom = 13.0;

  /// Die initialen Koordinaten sind Dortmunds Koordinaten
  LatLng center = LatLng(51.5135872, 7.4652981);
  MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
    mapController.onReady.then((_) => controllerReady = true);
  }

  void _zoom(double value) {
    if (controllerReady) {
      double newValue = mapController.zoom + value;
      //if (newValue >= 2 && newValue <= 18) {
      mapController.move(mapController.center, newValue);
      //}
    }
  }

  /// https://pub.dev/packages/geolocator
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<LatLng> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      // return Future.error('Location services are disabled.');
      return Future.error('Lokalisierungs-Services sind nicht aktiviert.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        // return Future.error('Location permissions are denied');
        return Future.error('Der Zugriff auf den Standort wurde verweigert.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      // return Future.error( 'Location permissions are permanently denied, we cannot request permissions.');
      return Future.error(
          'Der Zugriff auf den Standort wurde permanent verweigert.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    return LatLng(position.latitude, position.longitude);
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
          onPositionChanged: (mapPosition, boolVal) {
            center = mapPosition.center!;
          },
          center: center,
          zoom: zoom,
          maxZoom: 18,
          minZoom: 2,
          interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
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
      floatingActionButton: Row(
        // https://www.youtube.com/watch?v=nvAh3ENt2Kk&t=98s
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Tooltip(
            message: "Auf eigenen Standort zentrieren",
            child: FloatingActionButton(
              heroTag: "btnCenter",
              onPressed: () async => {
                if (controllerReady)
                  {
                    _determinePosition().catchError((error, stackTrace) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(error),
                      ));

                      /// Wenn kein Standort gefunden wird, dann wird auf den aktuellen Punkt zentriert (was quasi keinen Effekt hat)
                      return center;
                    }).then((position) => {
                          mapController.move(position, mapController.zoom),
                        })
                  }
              },
              child: const Icon(
                Icons.my_location,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Tooltip(
            message: "Rauszoomen",
            child: FloatingActionButton(
              heroTag: "btnZoomOut",
              onPressed: () => _zoom(-1),
              child: const Icon(
                Icons.zoom_out,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Tooltip(
            message: "Reinzoomen",
            child: FloatingActionButton(
              heroTag: "btnZoomIn",
              onPressed: () => _zoom(1),
              child: const Icon(
                Icons.zoom_in,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
