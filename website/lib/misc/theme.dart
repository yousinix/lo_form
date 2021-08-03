import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const _primary = Color(0xFF007BFF);

  ThemeData get data => ThemeData(
        // Base
        canvasColor: const Color(0xFFF8F9FA),
        textTheme: GoogleFonts.openSansTextTheme().copyWith(
          headline1: const TextStyle(fontWeight: FontWeight.w900),
          headline2: const TextStyle(fontWeight: FontWeight.w900),
          headline3: const TextStyle(fontWeight: FontWeight.w800),
          headline4: const TextStyle(fontWeight: FontWeight.w700),
          headline5: const TextStyle(fontWeight: FontWeight.w600),
          headline6: const TextStyle(fontWeight: FontWeight.w600),
          subtitle1: const TextStyle(fontWeight: FontWeight.w500),
          subtitle2: const TextStyle(fontWeight: FontWeight.w600),
        ),

        // Cards
        cardTheme: CardTheme(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        // Text Fields
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFEBEDEE),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding: const EdgeInsets.all(16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),

        // Button
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: _primary,
            onPrimary: Colors.white,
            textStyle: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 56,
              vertical: 20,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      );
}
