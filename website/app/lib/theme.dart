import 'package:flutter/material.dart';

class AppColors {
  static const primary300 = Color(0xFF1389FD);
  static const primary600 = Color(0xFF0175C2);
  static const primary900 = Color(0xFF02569B);
  static const secondary600 = Color(0xFFFFC108);
  static const grey100 = Color(0xFFD5D7DA);
  static const grey600 = Color(0xFF60646B);
  static const grey900 = Color(0xFF202124);
}

class AppTheme {
  const AppTheme();

  ThemeData get theme => ThemeData(
        // Colors
        primaryColor: AppColors.primary600,
        toggleableActiveColor: AppColors.primary300,
        canvasColor: Colors.transparent,
        backgroundColor: Colors.transparent,

        // Checkbox
        checkboxTheme: const CheckboxThemeData(
          shape: CircleBorder(),
        ),

        // Cards
        cardTheme: CardTheme(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),

        // Text Fields
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding: const EdgeInsets.all(16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),

        // Buttons
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: AppColors.primary300,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
            minimumSize: const Size(180, 56),
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
