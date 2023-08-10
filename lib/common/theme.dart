import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  bool _isDarkMode = true;
  ThemeData theme = Themes.darkTheme;
  Color iconColor = Color(0xFFFFF8E7);

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;

    if (_isDarkMode) {
      theme = Themes.darkTheme;
      iconColor = Color(0xFFFFF8E7);
    } else {
      theme = Themes.lightTheme;
      iconColor = Color(0xFF363949);
    }
    notifyListeners();
  }
}

class Themes {
  static final lightTheme = ThemeData(
      // Define the default brightness and colors.
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: Color(0xFFFFF8E7),
        secondary: Color(0xFFA1b5d8),
        error: Colors.red,
      ),
      fontFamily: 'Georgia',
      iconTheme: IconThemeData(
        color: Color(0xFF363949),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.black),
        prefixIconColor: Colors.black,
        prefixStyle: TextStyle(color:Colors.black)
      ),

      // Define the default `TextTheme`. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontSize: 72, fontWeight: FontWeight.bold, color: Colors.black),
        titleLarge: TextStyle(
            fontSize: 36, fontStyle: FontStyle.italic, color: Colors.black),
        bodyMedium:
            TextStyle(fontSize: 14, fontFamily: 'Hind', color: Colors.black),
      ));

  static final darkTheme = ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: Color(0xFF363949),
        secondary: Color(0xFF696773),
        error: Colors.red,
      ),
      fontFamily: 'Georgia',
      iconTheme: IconThemeData(
        color: Color(0xFFFFF8E7),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.white),
        prefixIconColor: Colors.white,
        prefixStyle: TextStyle(color:Colors.white),
        hoverColor: Colors.white,
        suffixStyle: TextStyle(color: Colors.white),
        focusColor: Colors.white
      ),

      // Define the default `TextTheme`. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontSize: 72, fontWeight: FontWeight.bold, color: Colors.white),
        titleLarge: TextStyle(
            fontSize: 36, fontStyle: FontStyle.italic, color: Colors.white),
        bodyMedium:
            TextStyle(fontSize: 14, fontFamily: 'Hind', color: Colors.white),
      ));

  static final ButtonThemeData buttonColor1 = ButtonThemeData(
    colorScheme: ColorScheme.light(
      primary: Color(0xFFE4F0D0),
    ),
  );

  static final ButtonThemeData buttonColor2 = ButtonThemeData(
    colorScheme: ColorScheme.dark(
      primary: Color(0xFFb1b6a6),
    ),
  );
}
