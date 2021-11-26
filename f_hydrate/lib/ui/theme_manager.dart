import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class ThemeManager {
  // static const Color primaryColor = Colors.white;
  static const Color primaryColor = Color(
    0xff00582E,
  );

  static const Color accentColor = Color(
    // 0xff0A2342,
    0xff2AA9E1,
  );
  static final Color backGroundColor = Colors.grey.shade300;

  static const Color textColor = Color(
    0xffa2a2a2,
  );

  // static final Color primaryColorDark = Colors.grey.shade300;

  static const Color primaryColorDark = Color(
    // 0xff459535,
    0xff459535,
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
    return buildTheme(
        primaryColorDark, accentColorDark, backGroundColorDark, textColorDark);
  }

  static ThemeData buildTheme(final Color primary, final Color accent,
      final Color background, final Color text) {
    final ThemeData theme = ThemeData();
    return theme.copyWith(
      colorScheme: theme.colorScheme.copyWith(secondary: accent),
      primaryColor: primary,
      backgroundColor: background,
      scaffoldBackgroundColor: background,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: accent,
        foregroundColor: primary,
      ),
      iconTheme: IconThemeData(
        color: accent,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primary,
        titleTextStyle: TextStyle(
          color: accent,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        iconTheme: IconThemeData(
          color: accent,
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: accent,
        selectionColor: accent,
      ),
      primaryTextTheme: TextTheme(
        headline1: buildTextStyle(text),
        headline2: buildTextStyle(text),
        headline3: buildTextStyle(text),
        headline4: buildTextStyle(text),
        headline5: buildTextStyle(text),
        headline6: buildTextStyle(text),
        subtitle1: buildTextStyle(text),
        subtitle2: buildTextStyle(text),
        bodyText1: buildTextStyle(text),
        bodyText2: buildTextStyle(text),
        button: buildTextStyle(text),
        caption: buildTextStyle(text),
        overline: buildTextStyle(text),
      ),
      textTheme: TextTheme(
        headline1: buildTextStyle(text),
        headline2: buildTextStyle(text),
        headline3: buildTextStyle(text),
        headline4: buildTextStyle(text),
        headline5: buildTextStyle(text),
        headline6: buildTextStyle(text),
        subtitle1: buildTextStyle(text),
        subtitle2: buildTextStyle(text),
        bodyText1: buildTextStyle(text),
        bodyText2: buildTextStyle(text),
        button: buildTextStyle(text),
        caption: buildTextStyle(text),
        overline: buildTextStyle(text),
      ),
    );
  }

  static TextStyle buildTextStyle(Color text) {
    return TextStyle(
      color: text,
    );
  }
}
