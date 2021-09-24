import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn){
    themeMode = isOn? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyTheme{
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Color(0xFF212939),
      primaryColor: Color(0xFF323E57),
      colorScheme: ColorScheme.dark(),
      fontFamily: 'Montserrat',
      iconTheme: IconThemeData(color: Colors.blueAccent,),
      buttonColor: Colors.blueAccent,
      accentColor: Colors.blueGrey,
  );

  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Color(0xFFE7EEFB),
      colorScheme: ColorScheme.light(),
      fontFamily: 'Montserrat',
      iconTheme: IconThemeData(color: Colors.blueAccent,),
      buttonColor: Colors.blueAccent,
      accentColor: Colors.lightBlue[100],
  );
}