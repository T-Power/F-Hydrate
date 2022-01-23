import 'package:f_hydrate/model/cookie_manager.dart';
import 'package:f_hydrate/model/tree_information.dart';
import 'package:f_hydrate/ui/admin-ui/create_tree_widget.dart';
import 'package:f_hydrate/ui/data_protection_widget.dart';
import 'package:f_hydrate/ui/forestmap.dart';
import 'package:f_hydrate/ui/sensor_page.dart';
import 'package:f_hydrate/ui/widgets/licenses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'cookies_banner.dart';
import 'imprint_widget.dart';

/**
 * Klasse zum Erzeugen einer Drawer-Navigation.
 */
class DrawerBuilder {
  /// Erzeugt eine Drawer-Navigation.
  static Widget build(BuildContext context) {
    final CookieManager cookieManager = CookieManager();
    return Drawer(
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SafeArea(
              child: Image(
                image: AssetImage('assets/logos/FHydrateLogo.png'),
                semanticLabel:
                    'The FHydrate logo. Containing a stylistic water wave and tree.',
              ),
            ),
            ListTile(
              title: const Text('Karte'),
              leading: const Icon(Icons.map),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Stack(
                      children: <Widget>[
                        ForestMap(
                          title: 'FHydrate - Karte',
                          cookieManager: cookieManager,
                        ),
                        CookiesBanner(
                          cookieManager: cookieManager,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Sensordaten'),
              leading: const Icon(Icons.speed),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SensorPage(
                      treeInfo: TreeInformation.createExample(),
                      key: const Key('sensorData'),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Baum registrieren'),
              leading: const Icon(Icons.local_florist),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateTreeWidget(
                      key: const Key('createTree'),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Datenschutz'),
              leading: const Icon(Icons.info),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DataProtectionWidget(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Impressum'),
              leading: const Icon(Icons.info),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ImprintWidget(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('App Informationen'),
              leading: const Icon(Icons.info),
              onTap: () {
                LicenseDialog.show(context);
              },
            ),
            const SizedBox(
              height: 50,
            ),
            ListTile(
              title: Text(
                'Zurück',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
