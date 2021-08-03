import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const _primary = Color(0xFF007BFF);
  static final _textTheme = ThemeData().textTheme;

  ThemeData get data => ThemeData(
        // Base
        canvasColor: const Color(0xFFF8F9FA),
        textTheme: GoogleFonts.poppinsTextTheme(_textTheme),

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
