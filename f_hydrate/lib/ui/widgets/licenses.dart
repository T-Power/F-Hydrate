import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LicenseDialog {
  static void show(BuildContext context) {
    String pubDev = 'https://pub.dev/';
    showAboutDialog(
      context: context,
      // applicationIcon: Container(
      //     height: 25,
      //     width: 25,
      //     child: Image(
      //       image: AssetImage('assets/icons/favicon.png'),
      //     )),
      applicationIcon: FlutterLogo(),
      applicationName: 'FHydrate',
      applicationVersion: '0.0.1',
      applicationLegalese: '©2021 FHydrate',
      children: <Widget>[
        RichText(
          text: TextSpan(
              style: TextStyle(
                  color: Theme.of(context).textTheme.headline1!.color),
              children: [
                TextSpan(
                  text: 'DE:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.headline1!.color,
                  ),
                ),
                TextSpan(
                    text:
                        'Im Folgenden finden Sie die Lizenzen aller verwendeten Softwarekomponenten. Für den Großteil der Softwarekomponenten finden Sie unter '),
                TextSpan(
                  text: pubDev,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      final url = pubDev;
                      if (await canLaunch(url)) {
                        await launch(
                          url,
                          forceSafariVC: false,
                        );
                      }
                    },
                )
              ]),
        ),
      ],
    );
  }
}
