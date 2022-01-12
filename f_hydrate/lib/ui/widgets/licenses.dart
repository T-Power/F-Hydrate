import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/**
 * Erzeugt einen Lizenz-Dialog.
 */
class LicenseDialog {
  /// Methode erzeugt einen Lizenz-Dialog in System-Sprache (nicht zwangsläufig die Sprache der Nutzeroberfläche).
  static void show(BuildContext context) {
    /// Text (Link) zum Hervorheben.
    String pubDev = 'https://pub.dev/';
    showAboutDialog(
      context: context,

      /// In der oberen Ecke wird das Logo dargestellt.
      applicationIcon: ImageIcon(
        AssetImage('assets/icons/favicon.png'),
        semanticLabel:
            'The FHydrate logo. Containing a stylistic water wave and tree.',
      ),
      applicationName: 'FHydrate',
      applicationVersion: '0.0.1',
      applicationLegalese: '©2021 FHydrate',
      children: <Widget>[
        /// Text, der im Dialog angezeigt werden soll.
        RichText(
          text: TextSpan(
            style:
                TextStyle(color: Theme.of(context).textTheme.headline1!.color),
            children: [
              TextSpan(
                text: 'DE: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.headline1!.color,
                ),
              ),
              TextSpan(
                  text:
                      'Im Folgenden finden Sie die Lizenzen aller verwendeten Softwarekomponenten. Für den Großteil der Softwarekomponenten finden Sie unter '),

              /// Hervorheben und "klickbar-Machen" des Links.
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
              ),
              TextSpan(
                text: ' weitere Informationen.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
