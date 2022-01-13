import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

/**
 * Mit dem ThemeManager können Farben, Schriftarten, Schriftgrößen, etc. an einem zentralen Ort geändert werden.
 *
 * Der Zugriff kann dann mit
 * `Theme.of(context)`
 * erfolgen.
 *
 * Es sind unterschiedliche Farben für den Hell- und Dunkel-Modus der Anwendung hinterlegt. Die Farben und Schriftarten entsprechen dem entworfenen Style-Guide.
 */
class ThemeManager {
  // static const Color primaryColor = Colors.white;
  static const Color primaryColor = Color(
    // 0xff00582E,
    0xff459535,
  );

  static const Color accentColor = Color(
    // 0xff0A2342,
    0xff2AA9E1,
  );
  static final Color backGroundColor = Colors.grey.shade300;

  static const Color textColor = Color(
    // 0xffa2a2a2,
    0xff000000,
  );

  // static final Color primaryColorDark = Colors.grey.shade300;

  static const Color primaryColorDark = Color(
    // 0xff459535,
    0xff00582E,
  );

  static const Color accentColorDark = Color(
    0xff0A2342,
    // 0xff2AA9E1,
  );
  static final Color backGroundColorDark = Colors.grey.shade800;

  static const Color textColorDark = Color(
    0xffa2a2a2,
  );

  static ThemeData currentTheme() {
    if (isDarkMode()) {
      return darkTheme();
    }
    return defaultTheme();
  }

  static bool isDarkMode() {
    var brightness = SchedulerBinding.instance!.window.platformBrightness;
    return brightness == Brightness.dark;
  }

  static ThemeData defaultTheme() {
    return buildTheme(primaryColor, accentColor, backGroundColor, textColor);
  }

  static ThemeData darkTheme() {
    return buildTheme(primaryColorDark, accentColorDark, backGroundColorDark,
            textColorDark)
        .copyWith(
      dialogBackgroundColor: backGroundColor,
    );
  }

  static ThemeData buildTheme(final Color primary, final Color accent,
      final Color background, final Color text) {
    final ThemeData theme = ThemeData();
    return theme.copyWith(
      colorScheme: theme.colorScheme.copyWith(secondary: accent),
      primaryColor: primary,
      primaryColorLight: primary,
      primaryColorDark: primaryColorDark,
      backgroundColor: background,
      scaffoldBackgroundColor: background,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: accent,
        foregroundColor: text,
      ),
      iconTheme: IconThemeData(
        color: accent,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primary,
        titleTextStyle: TextStyle(
          color: text,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        iconTheme: IconThemeData(
          color: text,
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: accent,
        selectionColor: accent,
      ),
      primaryTextTheme: TextTheme(
        headline1: h1(text),
        headline2: h2(text),
        headline3: h3(text),
        headline4: h4(text),
        headline5: h5(text),
        headline6: h6(text),
        subtitle1: subtitle1(text),
        subtitle2: subtitle2(text),
        bodyText1: body1(text),
        bodyText2: body2(text),
        button: button(text),
        caption: caption(text),
        overline: buildTextStyle(text),
      ),
      textTheme: TextTheme(
        headline1: h1(text),
        headline2: h2(text),
        headline3: h3(text),
        headline4: h4(text),
        headline5: h5(text),
        headline6: h6(text),
        subtitle1: subtitle1(text),
        subtitle2: subtitle2(text),
        bodyText1: body1(text),
        bodyText2: body2(text),
        button: button(text),
        caption: caption(text),
        overline: buildTextStyle(text),
      ),
    );
  }

  static TextStyle buildTextStyle(Color text) {
    //https://api.flutter.dev/flutter/dart-ui/FontWeight-class.html
    return GoogleFonts.notoSans().copyWith(
      color: text,
    );
  }

  static TextStyle h1(Color text) {
    return buildTextStyle(text).copyWith(
      letterSpacing: -1.5,
      fontSize: 96,
      fontWeight: FontWeight.w300, //light
    );
  }

  static TextStyle h2(Color text) {
    return buildTextStyle(text).copyWith(
      letterSpacing: -0.5,
      fontSize: 60,
      fontWeight: FontWeight.w300, //light
    );
  }

  static TextStyle h3(Color text) {
    return buildTextStyle(text).copyWith(
      letterSpacing: 0,
      fontSize: 48,
      fontWeight: FontWeight.normal,
    );
  }

  static TextStyle h4(Color text) {
    return buildTextStyle(text).copyWith(
      letterSpacing: 0.25,
      fontSize: 34,
      fontWeight: FontWeight.normal,
    );
  }

  static TextStyle h5(Color text) {
    return buildTextStyle(text).copyWith(
      letterSpacing: 0,
      fontSize: 24,
      fontWeight: FontWeight.normal,
    );
  }

  static TextStyle h6(Color text) {
    return buildTextStyle(text).copyWith(
      letterSpacing: 0.15,
      fontSize: 20,
      fontWeight: FontWeight.w500, //medium
    );
  }

  static TextStyle subtitle1(Color text) {
    return buildTextStyle(text).copyWith(
      letterSpacing: 0.15,
      fontSize: 16,
      fontWeight: FontWeight.normal,
    );
  }

  static TextStyle subtitle2(Color text) {
    return buildTextStyle(text).copyWith(
      letterSpacing: 0.1,
      fontSize: 14,
      fontWeight: FontWeight.w500, //medium
    );
  }

  static TextStyle body1(Color text) {
    return buildTextStyle(text).copyWith(
      letterSpacing: 0.5,
      fontSize: 16,
      fontWeight: FontWeight.normal,
    );
  }

  static TextStyle body2(Color text) {
    return buildTextStyle(text).copyWith(
      letterSpacing: 0.25,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    );
  }

  static TextStyle button(Color text) {
    return buildTextStyle(text).copyWith(
      letterSpacing: 1.25,
      fontSize: 14,
      fontWeight: FontWeight.w500, // medium
    );
  }

  static TextStyle caption(Color text) {
    return buildTextStyle(text).copyWith(
      letterSpacing: 0.4,
      fontSize: 12,
      fontWeight: FontWeight.normal,
    );
  }
}
