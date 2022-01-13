import 'package:flutter/cupertino.dart';

import 'cookies.dart';

/**
 * Klasse, welche die Möglichkeit bietet Cookies zu verwalten.
 * Ist notwendig, um die statischen Variablen der Cookie-Klasse
 * "stateful"-ähnlich in Widgets zu nutzen.
 */
class CookieManager extends ChangeNotifier {

  bool isAccepted() {
    return Cookies.accepted;
  }

  bool isVisible() {
    return Cookies.visible;
  }

  void setAccepted(bool accepted) {
    Cookies.accepted = accepted;
    notifyListeners();
  }

  void setVisible(bool visible) {
    Cookies.visible = visible;
    notifyListeners();
  }

  /**
   * Funktion zum setzen von 'accepted' und 'visible',
   * wobei nur ein Notify zurückgegeben wird.
   * Sollten noch mehr Variablen zu der Klasse
   * hinzukommen, könnte die notify-Methode auch
   * ausgelagert werden.
   *
   * @param  accepted Info, ob Cookies akzeptiert wurden
   * @param  visible  Info, ob Cookie-Banner sichtbar ist
   */
  void setAcceptedAndVisible(bool accepted, bool visible) {
    Cookies.accepted = accepted;
    Cookies.visible = visible;
    notifyListeners();
  }
}
