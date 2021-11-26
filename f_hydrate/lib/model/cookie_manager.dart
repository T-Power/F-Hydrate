import 'package:flutter/cupertino.dart';

import 'cookies.dart';

/// Bietet die Möglichkeit Cookies zu verwalten.
/// Ist notwendig, um die statischen Variablen der Cookie Klasse "stateful"-
/// ähnlich in Widgets zu nutzen.
class CookieManager extends ChangeNotifier {

  bool isAccepted() {
    return Cookies.accepted;
  }

  bool isVisible() {
    return Cookies.visible;
  }

  void setAccepted(bool acc) {
    Cookies.accepted = acc;
    notifyListeners();
  }

  void setVisible(bool vis) {
    Cookies.visible = vis;
    notifyListeners();
  }

  /// Ist notwendig um beide Werte zu setzen, aber nur ein Notify zu schicken.
  /// Sollten noch mehr Variablen zu der Klasse hinzukommen, könnte die
  /// notify-Methode auch ausgelagert werden.
  void setAcceptedAndVisible(bool acc, bool vis) {
    Cookies.accepted = acc;
    Cookies.visible = vis;
    notifyListeners();
  }
}
