import 'package:f_hydrate/ui/cookies_banner.dart';
import 'package:f_hydrate/ui/drawer.dart';
import 'package:f_hydrate/ui/forestmap.dart';
import 'package:f_hydrate/ui/theme_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'model/cookie_manager.dart';

void main() {
  addLicencesToLicenseRegistry();
  runApp(const MyApp());
}

void addLicencesToLicenseRegistry() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FHydrate',
      theme: ThemeManager.defaultTheme(),
      darkTheme: ThemeManager.darkTheme(),
      themeMode: ThemeMode.system,
      home: const MyHomePage(title: 'FHydrate'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Alternative, um mit statischen Klassen arbeiten zu können
  // https://stackoverflow.com/questions/48481590/how-to-set-update-state-of-statefulwidget-from-other-statefulwidget-in-flutter

  final CookieManager cookieManager = CookieManager();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      drawer: DrawerBuilder.build(context),
      body: Stack(
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
    );
  }
}
