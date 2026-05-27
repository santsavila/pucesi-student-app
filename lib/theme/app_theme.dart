import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryBlue = Color(0xFF1D3F73);
  static const Color accentBlue = Color(0xFF4B6E9E);
  static const Color lightBlue = Color(0xFFF3F6FB);
  static const Color gold = Color(0xFFF5A623);
  static const Color darkGray = Color(0xFF1F2937);
  static const Color mediumGray = Color(0xFF4B5563);
  static const Color lightGray = Color(0xFFF0F4F8);
  static const Color surfaceGray = Color(0xFFF3F6FB);
  static const Color surfaceBlue = Color(0xFFE6EEFF);
  static const Color scaffoldBackground = Color(0xFFF2F7FF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color danger = Color(0xFFEF4444);

  static ThemeData get light {
    // Base TextTheme con proporciones y pesos amplios — Poppins aplica encima
    const base = TextTheme(
      displaySmall: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w800,
        color: darkGray,
        letterSpacing: 0.6,
        height: 1.05,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        color: darkGray,
        height: 1.1,
        letterSpacing: 0.8,
      ),
      headlineSmall: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: darkGray,
        letterSpacing: 0.5,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: darkGray,
        letterSpacing: 0.4,
      ),
      titleMedium: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: darkGray,
        letterSpacing: 0.3,
      ),
      bodyLarge: TextStyle(
        fontSize: 15,
        height: 1.65,
        color: darkGray,
        letterSpacing: 0.15,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: mediumGray,
        letterSpacing: 0.1,
      ),
      bodySmall: TextStyle(
        fontSize: 12.5,
        color: mediumGray,
        height: 1.45,
        letterSpacing: 0.1,
      ),
      labelLarge: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: darkGray,
        letterSpacing: 0.4,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: mediumGray,
        letterSpacing: 0.3,
      ),
    );

    return ThemeData(
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
      scaffoldBackgroundColor: scaffoldBackground,

      // Poppins en todo el textTheme — fuente geométrica, amplia y moderna
      textTheme: GoogleFonts.poppinsTextTheme(base),

      appBarTheme: AppBarTheme(
        backgroundColor: white,
        foregroundColor: darkGray,
        elevation: 0,
        surfaceTintColor: white,
        centerTitle: false,
        titleTextStyle: GoogleFonts.poppins(
          color: darkGray,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
        iconTheme: const IconThemeData(color: darkGray),
      ),

      cardTheme: CardThemeData(
        color: white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryBlue,
          side: const BorderSide(color: primaryBlue),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          textStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      ),

      dividerColor: const Color(0xFFD7E0EC),
    );
  }
}
