import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get themeData => ThemeData(
        colorSchemeSeed: Colors.purple,
        useMaterial3: true,
        textTheme: GoogleFonts.manropeTextTheme(),
        appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.manrope(
            fontSize: 17,
            color: Colors.black,
          ),
          centerTitle: false,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
          ),
        ),
      );
}
