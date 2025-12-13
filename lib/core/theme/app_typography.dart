import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Clean typography hierarchy using Inter font (shadcn/ui style)
class AppTypography {
  AppTypography._();

  // ============================================
  // BASE TEXT STYLE
  // ============================================
  
  static TextStyle _baseTextStyle(Color color) => GoogleFonts.inter(
        color: color,
        fontWeight: FontWeight.w400,
      );

  // ============================================
  // DISPLAY STYLES
  // ============================================
  
  static TextStyle displayLarge(Color color) => _baseTextStyle(color).copyWith(
        fontSize: 60,
        fontWeight: FontWeight.w600,
        height: 1.1,
        letterSpacing: -1.5,
      );

  static TextStyle displayMedium(Color color) => _baseTextStyle(color).copyWith(
        fontSize: 48,
        fontWeight: FontWeight.w600,
        height: 1.15,
        letterSpacing: -1.0,
      );

  static TextStyle displaySmall(Color color) => _baseTextStyle(color).copyWith(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        height: 1.2,
        letterSpacing: -0.5,
      );

  // ============================================
  // HEADING STYLES
  // ============================================
  
  static TextStyle headingLarge(Color color) => _baseTextStyle(color).copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        height: 1.25,
        letterSpacing: -0.5,
      );

  static TextStyle headingMedium(Color color) => _baseTextStyle(color).copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.3,
        letterSpacing: -0.25,
      );

  static TextStyle headingSmall(Color color) => _baseTextStyle(color).copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.4,
      );

  // ============================================
  // BODY STYLES
  // ============================================
  
  static TextStyle bodyLarge(Color color) => _baseTextStyle(color).copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 1.6,
      );

  static TextStyle bodyMedium(Color color) => _baseTextStyle(color).copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.6,
      );

  static TextStyle bodySmall(Color color) => _baseTextStyle(color).copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
      );

  // ============================================
  // UTILITY STYLES
  // ============================================
  
  static TextStyle caption(Color color) => _baseTextStyle(color).copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.4,
        letterSpacing: 0.2,
      );

  static TextStyle button(Color color) => _baseTextStyle(color).copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.4,
        letterSpacing: 0.1,
      );

  static TextStyle label(Color color) => _baseTextStyle(color).copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.4,
      );

  static TextStyle overline(Color color) => _baseTextStyle(color).copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 1.4,
        letterSpacing: 1.0,
      );
}
