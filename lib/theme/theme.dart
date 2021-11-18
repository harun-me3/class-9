import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class ThemeProvider with ChangeNotifier {
  bool isLightTheme;

  ThemeProvider(this.isLightTheme);

  // the code below is to manage the status bar color when the theme changes
  getCurrentStatusNavigationBarColor() {
    if (isLightTheme) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xFFFFFFFF),
        systemNavigationBarIconBrightness: Brightness.dark,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFF26242e),
        systemNavigationBarIconBrightness: Brightness.light,
      ));
    }
  }

  // use to toggle the theme
  toggleThemeData() async {
    final settings = await Hive.openBox('themebox');
    settings.put('isLightTheme', !isLightTheme);
    isLightTheme = !isLightTheme;
    getCurrentStatusNavigationBarColor();
    notifyListeners();
  }

  // Global theme data we are always check if the light theme is enabled #isLightTheme
  ThemeData themeData() {
    return ThemeData(
      //in the context of a UI, is vertical and horizontal ‘compactness’ of the components in the UI.
      visualDensity: VisualDensity.adaptivePlatformDensity,
      //t is the background color of the Scaffold widget.
      scaffoldBackgroundColor:
          isLightTheme ? Color(0xFF18191A) : Color(0xFFFFFFFF),
      //text font type
      textTheme: GoogleFonts.robotoTextTheme(),
      //This is the background color of major parts of the app like toolbars, tab bars, appbar, and many more
      primaryColor: isLightTheme ? Color(0xFF18191A) : Color(0xFFFFFFFF),
      //CircleAvatar color in light theme and This is a lighter version of primaryColor
      primaryColorLight: Color(0xFFFFFFFF),
      //CircleAvatar color in dark theme and This is a darker version of primaryColor
      primaryColorDark: Color(0xFF242526),

      //Icon Theme color
      iconTheme: isLightTheme
          ? IconThemeData(color: Color(0xFFFFFFFF))
          : IconThemeData(color: Color(0xFF242526)),

      //Text theme color
      accentTextTheme: isLightTheme
          ? TextTheme(
              bodyText1: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
              bodyText2: TextStyle(
                color: Color(0xFFB0B3B8),
                fontSize: 16,
              ),
              headline1: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              headline2: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 14,
              ),

              //diologe
              headline3: TextStyle(
                color: Color(0xFF3A3B3C),
              ),

              //for drawer pure white
              headline4: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
            )
          : TextTheme(
              bodyText1: TextStyle(
                color: Color(0xFF242526),
                fontSize: 16,
              ),
              bodyText2: TextStyle(
                color: Color(0xFF242526),
                fontSize: 16,
              ),
              headline1: TextStyle(
                  color: Color(0xFF242526),
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              headline2: TextStyle(
                color: Color(0xFF242526),
                fontSize: 14,
              ),
              //diologe
              headline3: TextStyle(
                color: Color(0xFFFFFFFF),
              ),
              //for drawer pure white
              headline4: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
            ),

      accentColor: isLightTheme ? Color(0xFF3A3B3C) : Color(0xFFFFFFFF),
    );
  }

  // Theme mode to display unique properties not cover in theme data
  ThemeColor themeMode() {
    return ThemeColor(
      backgroundColor: Colors.red,
      gradient: [
        if (isLightTheme) ...[Color(0xDDFF0080), Color(0xDDFF8C00)],
        if (!isLightTheme) ...[Color(0xFF8983F7), Color(0xFFA3DAFB)]
      ],
      textColor: isLightTheme ? Color(0xFF000000) : Color(0xFFFFFFFF),
      toggleButtonColor: isLightTheme ? Color(0xFFFFFFFF) : Color(0xFf34323d),
      toggleBackgroundColor:
          isLightTheme ? Color(0xFFe7e7e8) : Color(0xFF222029),
      shadow: [
        if (isLightTheme)
          BoxShadow(
              color: Color(0xFFd8d7da),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 5)),
        if (!isLightTheme)
          BoxShadow(
              color: Color(0x66000000),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 5))
      ],
    );
  }
}

// A class to manage specify colors and styles in the app not supported by theme data
class ThemeColor {
  List<Color> gradient;
  Color backgroundColor;
  Color toggleButtonColor;
  Color toggleBackgroundColor;
  Color textColor;
  List<BoxShadow> shadow;

  ThemeColor({
    required this.gradient,
    required this.backgroundColor,
    required this.toggleBackgroundColor,
    required this.toggleButtonColor,
    required this.textColor,
    required this.shadow,
  });
}
