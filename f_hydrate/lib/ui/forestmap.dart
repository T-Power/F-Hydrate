import 'package:f_hydrate/model/cookie_manager.dart';
import 'package:f_hydrate/model/tree_information.dart';
import 'package:f_hydrate/ui/tree_information_widget.dart';
import 'package:f_hydrate/ui/tree_information_widget_with_tabs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'drawer.dart';
import 'forestmap_replacement.dart';

/// https://pub.dev/packages/flutter_map -> Dokumentation zu flutter_map
/// Integration einer Map, basierend auf Open Street Map.
class ForestMap extends StatefulWidget {
  final CookieManager cookieManager;

  const ForestMap({Key? key, required this.title, required this.cookieManager})
      : super(key: key);

  final String title;

  @override
  State<ForestMap> createState() => _ForestMapState();
}

class _ForestMapState extends State<ForestMap> {
  bool controllerReady = false;

  /// Der initiale Zoom
  double zoom = 13.0;
  bool treeInfoVisible = false;
  bool fabVisible = true;
  TreeInformation treeInfo = TreeInformation.createExample();

  /// Die initialen Koordinaten sind Dortmunds Koordinaten
  LatLng center = LatLng(51.5135872, 7.4652981);
  MapController mapController = MapController();

  @override
  void initState() {
    super.initState();

    /// Wenn der MapController noch nicht bereit ist, kann es an verschiedenen Stellen
    /// zu Schwierigkeiten kommen
    mapController.onReady.then((_) => controllerReady = true);

    /// Listener um bei Änderungen an den Cookie-Informationen benachrichtigt zu werden
    widget.cookieManager.addListener(() {
      setState(() {
        /// Map wird nur initialisiert, wenn Cookies akzeptiert wurden
        initMap();
      });
    });

    /// AUSKOMMENTIEREN, FALLS COOKIES ABGELEHNT WERDEN DÜRFEN
    if (!widget.cookieManager.isAccepted()) {
      widget.cookieManager.setAcceptedAndVisible(true, true);
    }
  }

  /// https://api.flutter.dev/flutter/widgets/State-class.html
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    /// Map wird nur initialisiert, wenn Cookies akzeptiert wurden
    initMap();
  }

  void _zoom(double value) {
    if (controllerReady) {
      double newValue = mapController.zoom + value;
      mapController.move(mapController.center, newValue);
    }
  }

  void _center() {
    if (controllerReady) {
      mapController.move(center, mapController.zoom);
    }
  }

  /// Die Map wird gar nicht initialisiert, solange die Cookies nicht akzeptiert wurden
  Widget shownMap = Container();

  /// Die Initialisierung der Map wurde hierhin ausgelagert
  /// und an eine entsprechende Bedingung geknüpft
  void initMap() {
    if (widget.cookieManager.isAccepted()) {
      shownMap = FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center: center,
          zoom: zoom,

          /// Bei größerem/kleinerem Zoom würde nur grauer Bildschirm angezeigt
          maxZoom: 18,
          minZoom: 2,

          /// Wenn die Flags nicht eingeschränkt würden, ließe sich der Bildschirm
          /// am Handy rotieren, was leicht irritierend ist.
          interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.de/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
            attributionBuilder: (_) {
              return const Text(
                "© OpenStreetMap contributors",
                style: TextStyle(backgroundColor: Colors.white),
              );
            },
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                point: LatLng(
                    treeInfo.position.latitude, treeInfo.position.longitude),
                builder: (ctx) => IconButton(
                    icon: const Icon(
                      Icons.location_on,
                      size: 30.0,
                    ),
                    onPressed: () => setState(() {
                          treeInfoVisible = true;
                          fabVisible = MediaQuery.of(context).size.width > 500
                              ? true
                              : false;
                        })
                    // showDialog<String>(
                    //     context: context,
                    //     builder: (BuildContext context) {
                    //       return const AlertDialog(
                    //           content: TreeInformationWidget(
                    //               title: "TreeInfoWidget"));
                    //     }),
                    ),
              ),
            ],
          ),
        ],
      );
    } else {
      shownMap = Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      child: Scaffold(
        drawer: DrawerBuilder.build(context),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Stack(
          children: [
            shownMap,
            Align(
              alignment: Alignment.centerLeft,
              child: Visibility(
                key: const Key("TreeInfoVisibility"),
                visible: treeInfoVisible,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: getTreeInformationWidget('tabs'),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: Visibility(
          visible: fabVisible,
          child: Row(
            // https://www.youtube.com/watch?v=nvAh3ENt2Kk&t=98s
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                heroTag: "btnCenter",
                onPressed: () => _center(),
                child: const Icon(
                  Icons.my_location,
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
        ),
      ),
      visible: widget.cookieManager.isAccepted(),

      /// Wird angezeigt, wenn visible nicht auf true gesetzt ist, und die Karte
      /// somit nicht angezeigt wird.
      replacement: ForestMapReplacement(
        title: 'FHydrate - Karte',
        cookieManager: widget.cookieManager,
      ),
    );
  }

  Widget getTreeInformationWidget(String type) {
    switch (type.toLowerCase()) {
      case 'tabs':
        return TreeInformationWidgetTab(
          model: treeInfo,
          onClosePressed: () => setState(
            () {
              treeInfoVisible = false;
              fabVisible = true;
            },
          ),
        );
      default:
        return TreeInformationWidget(
          model: treeInfo,
          onClosePressed: () => setState(
            () {
              treeInfoVisible = false;
            },
          ),
        );
    }
  }
}
