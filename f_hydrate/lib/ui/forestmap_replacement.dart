import 'package:f_hydrate/model/cookie_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'drawer.dart';

/**
 * Widget, welches angezeigt werden soll, falls die Map auf
 * datenschutz-technischen Gründen nicht angezeigt werden darf,
 * wenn die Cookies nicht akzeptiert wurden.
 */
class ForestMapReplacement extends StatefulWidget {
  final CookieManager cookieManager;

  const ForestMapReplacement(
      {Key? key, required this.title, required this.cookieManager})
      : super(key: key);

  final String title;

  @override
  State<ForestMapReplacement> createState() => _ForestMapReplacement();
}

class _ForestMapReplacement extends State<ForestMapReplacement> {
  @override
  void initState() {
    super.initState();

    /// Listener um bei Änderungen an den Cookie-Informationen benachrichtigt zu werden
    widget.cookieManager.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerBuilder.build(context),
      appBar: AppBar(
        title: Text(widget.title),
      ),

      /// Notwendig, um die Column zu zentrieren
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          /// Ebenfalls notwendig fürs Zentrieren
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /// Notwendig, damit sich der Text nicht verschiebt, wenn der Button angezeigt wird
                SizedBox(
                  height: 100,
                  child: Column(
                    children: <Widget>[
                      const Text(
                        'Damit die Karte angezeigt werden kann, müssen Cookies akzeptiert werden.',
                        textAlign: TextAlign.center,
                      ),

                      /// Der Text zum erneuten Anzeigen des Banners soll nur angezeigt werden,
                      /// falls die Cookies abgelehnt wurden und der Banner somit nicht mehr
                      /// sichtbar ist
                      Visibility(
                        child: TextButton(
                          child: const Text('Optionen erneut zeigen'),
                          onPressed: () {
                            widget.cookieManager.setVisible(true);
                          },
                        ),
                        visible: !widget.cookieManager.isVisible(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
