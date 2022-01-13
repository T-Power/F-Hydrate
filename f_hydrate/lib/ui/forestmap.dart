import 'dart:async';
import 'dart:convert';
//import 'dart:html';
//import 'dart:js';

import 'package:f_hydrate/model/cookie_manager.dart';
import 'package:f_hydrate/model/tree_information.dart';
import 'package:f_hydrate/ui/tree_information_widget.dart';
import 'package:f_hydrate/ui/tree_information_widget_with_tabs.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'drawer.dart';
import 'forestmap_replacement.dart';

import 'package:http/http.dart' as http;

/**
 * Klasse, welche eine Map integriert und auf Open Street Map basiert.
 * Als package für die Karte wurde flutter_map genutzt
 * (https://pub.dev/packages/flutter_map).
 */
class ForestMap extends StatefulWidget {
  /**
   * Konstruktor der Klasse ForestMap.
   * Die übergebene CookieManager-Klasse kann genutzt werden,
   * um die Karte nur zu laden, falls die Nutzenden die
   * Cookies akzeptieren.
   * (Momentan ist die Funktion zum Ablehnen von Cookies
   * jedoch deaktiviert)
   *
   * @param  title         Der Titel der Klasse
   * @param  cookieManager Ein Objekt der CookieManager-Klasse
   */
  const ForestMap({Key? key, required this.title, required this.cookieManager})
      : super(key: key);

  final CookieManager cookieManager;
  final String title;

  @override
  State<ForestMap> createState() => _ForestMapState();
}

class _ForestMapState extends State<ForestMap> {
  /// Enthält Informationen darüber, ob der MapController bereit ist
  bool controllerReady = false;

  /// Der initiale Zoom
  double zoom = 13.0;

  /// Gibt an, ob das Pop-Up mit den Informationen über den Baum angezeigt werden soll
  bool treeInfoVisible = false;

  /// Gibt an, ob die "Floating Action Buttons (FAB)" sichtbar sind
  bool fabVisible = true;

  /// Die Informationen bezüglich des Baumes
  TreeInformation treeInfo = TreeInformation.createExample();

  /// Die initialen Koordinaten sind Dortmunds Koordinaten
  //LatLng center = LatLng(51.5135872, 7.4652981);
  LatLng center = LatLng(1.0, 1.0);

  /// MapController, um die Karte steuern zu können
  MapController mapController = MapController();

  late Future<List<TreeInformation>> futureTreeInformation;
  late Future<String> futureString;

  late Future<http.Response> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureString = fetchTreeString();
    futureTreeInformation = fetchTrees();
    futureAlbum = fetchResponse();

    /// Wenn der MapController noch nicht bereit ist, kann es an verschiedenen Stellen
    /// zu Schwierigkeiten kommen, deswegen wird mit einer entsprechenden Variable
    /// zum prüfen gearbeitet
    mapController.onReady.then((_) => controllerReady = true);

    /// Listener um bei Änderungen an den Cookie-Informationen benachrichtigt zu werden
    widget.cookieManager.addListener(() {
      setState(() {
        /// Map wird nur initialisiert, wenn Cookies akzeptiert wurden

        initMap();
      });
    });

    /// AUSKOMMENTIEREN, FALLS COOKIES ABGELEHNT WERDEN DÜRFEN
    /// Macht die Karte sichtbar, auch wenn die Cookies nicht akzeptiert wurden.
    /// Wenn der Code auskommentiert wird, wird die Karte initial nicht angezeigt.
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

  /**
   * Funktion um den Zoom-Faktor zu ändern.
   *
   * @param  value Der Faktor um welche sich der Zoom erhöht bzw. verringert
   */
  void _zoom(double value) {
    if (controllerReady) {
      double newValue = mapController.zoom + value;
      mapController.move(mapController.center, newValue);
    }
  }

  /**
   * Funktion um den Center der Karte zu ändern.
   */
  void _center() {
    if (controllerReady) {
      mapController.move(center, mapController.zoom);
    }
  }

  /// Die Map wird gar nicht initialisiert, solange die Cookies nicht akzeptiert wurden
  Widget shownMap = Container();

  /**
   * Funktion zum Initialisieren der Map.
   * Die Map wird nur initialisiert, falls die Cookies akzeptiert wurden.
   */
  void initMap() {
    if (widget.cookieManager.isAccepted()) {
      shownMap = FutureBuilder<List<TreeInformation>>(
          future: futureTreeInformation,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return getMap(snapshot.data!);
            } else {
              return Center(child: Text("Cannot load Map."));
            }
          });
    } else {
      /// Wenn die Cookies nicht akzeptiert wurden wird die Map nicht
      /// initialisiert
      shownMap = Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    // return Center(child: FutureBuilder<http.Response>(
    //   future: futureAlbum,
    //   builder: (context, snapshot) {
    //     if(snapshot.hasData){
    //       return Text(snapshot.data!.body);
    //     }
    //     else{
    //       return Text("No data loaded");
    //     }
    // },),);

    return Visibility(
      /// Die Karte wird nur angezeigt, falls die Cookies akzeptiert
      /// wurden
      visible: widget.cookieManager.isAccepted(),

      /// Wird angezeigt, wenn visible nicht auf true gesetzt ist, und die Karte
      /// somit nicht angezeigt wird
      replacement: ForestMapReplacement(
        title: 'FHydrate - Karte',
        cookieManager: widget.cookieManager,
      ),

      /// Wird angezeigt, falls die Cookies akzeptiert wurden
      child: Scaffold(
        drawer: DrawerBuilder.build(context),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Stack(
          children: [
            /// Die an anderer Stelle initialisierte Karte
            shownMap,

            /// Das Pop-Up mit den Bauminformationen
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

        /// Die Aktionen zum zentrieren und zum Anpassen des
        /// Zoom-Faktors
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
    );
  }

  /**
   * Funktion um das passende TreeInformationWidget
   * zurückgegeben zu bekommen.
   *
   * @param  type Der gewünschte Typ des Widgets
   * @return      Das TreeInformationWidget
   */
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

  Future<String> fetchTreeString() async {
    final response = await http.get(
      Uri.parse('https://fhydrate.fb4.fh-dortmund.de/api/v1/trees'),
      // headers: {
      //   "Accept": "application/json",
      //   "Access-Control-Allow-Origin": "*"
      // }
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "Nothing";
    }
  }

  Future<http.Response> fetchResponse() async {
    return http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
  }

  Future<List<TreeInformation>> fetchTrees() async {
    print("--------------test");

    final response = await http
        .get(Uri.parse('https://fhydrate.fb4.fh-dortmund.de/api/v1/trees'));
    /*final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));*/

    print(response.body);
    print("--------------test2");

    if (response.statusCode == 200) {
      var jsonObj = jsonDecode(response.body);
      List<dynamic> trees = jsonObj['_embedded']['trees'];
      List<TreeInformation> treeInfos = [];

      trees.forEach((tree) {
        treeInfos.add(TreeInformation.fromJson(tree));
      });

      return treeInfos;
    } else {
      throw Exception('Failed to load trees.');
    }
  }

  FlutterMap getMap(List<TreeInformation> treeInfos) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: center,
        zoom: zoom,

        /// Bei größerem/kleinerem Zoom würde nur grauer Bildschirm angezeigt
        maxZoom: 18,
        minZoom: 2,

        /// Wenn die Flags nicht eingeschränkt würden, ließe sich der Bildschirm
        /// am Handy rotieren, was leicht irritierend sein kann, falls Norden
        /// plötzlich nicht mehr oben vom Bildschirm ist.
        interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
      ),
      layers: [
        /// Konfiguration der Karte
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

        /// Konfiguration der angezeigten Bäume
        MarkerLayerOptions(
          markers: getMarkers(treeInfos),
        ),
      ],
    );
  }

  List<Marker> getMarkers(List<TreeInformation> treeInfos) {
    List<Marker> markers = [];
    treeInfos.forEach((tree) {
      markers.add(Marker(
        point: LatLng(tree.position.latitude, tree.position.longitude),
        builder: (ctx) => IconButton(
            icon: const Icon(
              Icons.location_on,
              size: 30.0,
            ),
            onPressed: () => setState(() {
                  treeInfo = tree;
                  treeInfoVisible = true;
                  fabVisible = MediaQuery.of(context).size.width > 500;
                })),
      ));
    });

    return markers;
  }
}
