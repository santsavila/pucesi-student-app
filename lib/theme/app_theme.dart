import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryBlue = Color(0xFF1D3F73);
  static const Color accentBlue = Color(0xFF4B6E9E);
  static const Color lightBlue = Color(0xFFF3F6FB);
  static const Color gold = Color(0xFFF5A623);
  static const Color darkGray = Color(0xFF1F2937);
  static const Color mediumGray = Color(0xFF4B5563);
  static const Color lightGray = Color(0xFFF7FAFC);
  static const Color white = Color(0xFFFFFFFF);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color danger = Color(0xFFEF4444);

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: primaryBlue,
          onPrimary: white,
          secondary: darkGray,
          onSecondary: white,
          error: danger,
          onError: white,
          surface: white,
          onSurface: darkGray,
        ),
        scaffoldBackgroundColor: lightGray,
        appBarTheme: const AppBarTheme(
          backgroundColor: white,
          foregroundColor: darkGray,
          elevation: 0.5,
          surfaceTintColor: white,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: darkGray,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.25,
          ),
          iconTheme: IconThemeData(color: darkGray),
        ),
        cardTheme: CardThemeData(
          color: white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBlue,
            foregroundColor: white,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
        textTheme: const TextTheme(
          displaySmall: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: darkGray, letterSpacing: 0.15),
          titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: darkGray),
          bodyLarge: TextStyle(fontSize: 15, height: 1.5, color: darkGray),
          bodyMedium: TextStyle(fontSize: 14, color: mediumGray),
          labelLarge: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: darkGray),
        ),
        dividerColor: mediumGray,
        fontFamily: 'Roboto',
      );
}
