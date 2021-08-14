import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const blue400 = Color(0xFF1389FD);
  static const blue600 = Color(0xFF0175C2);
  static const blue700 = Color(0xFF02569B);
  static const yellow700 = Color(0xFFFFC108);
  static const grey100 = Color(0xFFD5D7DA);
  static const grey600 = Color(0xFF60646B);
  static const grey900 = Color(0xFF202124);
}

class AppTheme {
  const AppTheme();

  ThemeData get light => ThemeData.light().copyWith(
        primaryColor: base.primaryColor,
        toggleableActiveColor: base.toggleableActiveColor,
        textTheme: base.textTheme.apply(
          bodyColor: Colors.black87,
          displayColor: Colors.black87,
        ),
        checkboxTheme: base.checkboxTheme,
        cardTheme: base.cardTheme,
        inputDecorationTheme: base.inputDecorationTheme,
        elevatedButtonTheme: base.elevatedButtonTheme,
      );

  ThemeData get dark => ThemeData.dark().copyWith(
        errorColor: Colors.red[200],
        primaryColor: base.primaryColor,
        toggleableActiveColor: base.toggleableActiveColor,
        textTheme: base.textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        checkboxTheme: base.checkboxTheme,
        cardTheme: base.cardTheme,
        inputDecorationTheme: base.inputDecorationTheme,
        elevatedButtonTheme: base.elevatedButtonTheme,
      );

  ThemeData get base => ThemeData(
        // Colors
        primaryColor: AppColors.blue600,
        toggleableActiveColor: AppColors.blue400,

        // Text
        textTheme: GoogleFonts.interTextTheme().copyWith(
          headline1: const TextStyle(fontWeight: FontWeight.w900),
          headline2: const TextStyle(fontWeight: FontWeight.w900),
          headline3: const TextStyle(fontWeight: FontWeight.w800),
          headline4: const TextStyle(fontWeight: FontWeight.w700),
          headline5: const TextStyle(fontWeight: FontWeight.w600),
          headline6: const TextStyle(fontWeight: FontWeight.w600),
          subtitle1: const TextStyle(fontWeight: FontWeight.w500),
          subtitle2: const TextStyle(fontWeight: FontWeight.w600),
        ),

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
            primary: AppColors.blue400,
            onPrimary: Colors.white,
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
