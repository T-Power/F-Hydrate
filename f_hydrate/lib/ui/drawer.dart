import 'package:f_hydrate/model/cookie_manager.dart';
import 'package:f_hydrate/model/tree_information.dart';
import 'package:f_hydrate/ui/data_protection_widget.dart';
import 'package:f_hydrate/ui/forestmap.dart';
import 'package:f_hydrate/ui/not_implemented_widget.dart';
import 'package:f_hydrate/ui/sensor_page.dart';
import 'package:f_hydrate/ui/tree_information_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'cookies_banner.dart';
import 'imprint_widget.dart';

class DrawerBuilder {
  static Widget build(BuildContext context) {
    final CookieManager cookieManager = CookieManager();
    return Drawer(
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              accountName: Text(
                'Hallo ${getUsername()}!',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
              accountEmail: Text(
                getEmail(),
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
              currentAccountPicture: CircleAvatar(
                foregroundColor: Theme.of(context).primaryColor,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: Text(
                  getInitials(),
                ),
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
              title: const Text('Benachrichtigungen'),
              leading: const Icon(Icons.notifications),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotImplementedWidget(
                      key: Key('notifications'),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Bauminformationen Popup'),
              leading: const Icon(Icons.info),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TreeInformationWidget(
                      model: TreeInformation.createExample(),
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
            const SizedBox(
              height: 50,
            ),
            ListTile(
              title: const Text('Zurück'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  static String getUsername() {
    return "Mustermann";
  }

  static String getEmail() {
    return "mustermann@domain.de";
  }

  static String getInitials() {
    return "MM";
  }
}
