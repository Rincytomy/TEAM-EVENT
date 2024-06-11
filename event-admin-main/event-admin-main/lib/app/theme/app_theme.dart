import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get themeData => ThemeData(
      primarySwatch: Colors.pink,
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
          centerTitle: false,
          titleTextStyle: TextStyle(
            fontSize: 17,
            color: Colors.black,
          )));
}
