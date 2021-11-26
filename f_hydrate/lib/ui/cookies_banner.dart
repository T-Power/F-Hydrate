import 'package:f_hydrate/model/cookie_manager.dart';
import 'package:flutter/material.dart';

/// Ein Banner, welcher auf Cookie-Nutzung der Map hinweist und die Möglichkeit
/// zum Akzeptieren oder zum Ablehnen anbietet.
class CookiesBanner extends StatefulWidget {
  final CookieManager cookieManager;

  const CookiesBanner({Key? key, required this.cookieManager}) : super(key: key);

  @override
  _CookiesBanner createState() => _CookiesBanner();
}

class _CookiesBanner extends State<CookiesBanner> {

  @override
  void initState() {
    super.initState();
    /// Listener um bei Änderungen an den Cookie-Informationen benachrichtigt zu werden
    widget.cookieManager.addListener(() {
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const Spacer(),
            MaterialBanner(
              padding: const EdgeInsets.all(20),
              content: const Text('Diese Seite verwendet Cookies'),
              leading: const Icon(Icons.info),
              actions: <Widget>[
                TextButton(
                  child: const Text('Ablehnen'),
                  onPressed: () {
                    setState(() {
                      widget.cookieManager.setAcceptedAndVisible(false, false);
                    });
                  },
                ),
                TextButton(
                  child: const Text('Akzeptieren'),
                  onPressed: () {
                    setState(() {
                      widget.cookieManager.setAcceptedAndVisible(true, false);
                    });
                  },
                ),
              ],
            ),
          ],
        ),
        visible: widget.cookieManager.isVisible());
  }
}
