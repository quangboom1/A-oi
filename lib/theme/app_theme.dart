import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Palette: A-oi New Brand Colors
  static const Color c50 = Color(0xFFF5F9EC);
  static const Color c100 = Color(0xFFE8F1D6);
  static const Color c200 = Color(0xFFD2E4B2);
  static const Color c300 = Color(0xFFACCD75);

  static const Color primary = c300;
  static const Color primaryContainer = c200;
  static const Color background = c50;

  static const Color onSurface = Colors.black;
  static const Color onSurfaceVariant = Colors.black54;
  static const Color outline = c100;
  static const Color SurfaceContainer = Colors.white; // Using White as requested
  
  // Custom Accents
  static const Color accentGreen = c300;
  static const Color accentGrey = Color(0xFF757575);
  static const Color progressBackground = c100;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary: primary,
        onPrimary: Colors.white,
        background: background,
        onSurface: onSurface,
        onSurfaceVariant: onSurfaceVariant,
        outline: outline,
      ),
      scaffoldBackgroundColor: background,
      textTheme: GoogleFonts.interTextTheme().copyWith(
        displayLarge: GoogleFonts.inter(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: onSurface,
          letterSpacing: -1.0,
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: onSurface,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          color: onSurface,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          color: onSurfaceVariant,
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: primary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF7BA33F),
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 60),
          elevation: 2,
          shadowColor: Colors.black.withOpacity(0.2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
          textStyle: GoogleFonts.inter(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ).copyWith(
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (states) {
              if (states.contains(MaterialState.hovered)) {
                return Colors.white.withOpacity(0.1);
              }
              if (states.contains(MaterialState.pressed)) {
                return Colors.white.withOpacity(0.2);
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}


