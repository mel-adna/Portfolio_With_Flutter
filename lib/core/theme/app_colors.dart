import 'package:flutter/material.dart';

/// shadcn/ui-inspired color palette for the portfolio
class AppColors {
  AppColors._();

  // ============================================
  // LIGHT THEME COLORS
  // ============================================
  
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightForeground = Color(0xFF0A0A0A);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightCardForeground = Color(0xFF0A0A0A);
  static const Color lightPrimary = Color(0xFF171717);
  static const Color lightPrimaryForeground = Color(0xFFFAFAFA);
  static const Color lightSecondary = Color(0xFFF5F5F5);
  static const Color lightSecondaryForeground = Color(0xFF171717);
  static const Color lightMuted = Color(0xFFF5F5F5);
  static const Color lightMutedForeground = Color(0xFF737373);
  static const Color lightAccent = Color(0xFF6366F1); // Indigo accent
  static const Color lightAccentForeground = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0xFFE5E5E5);
  static const Color lightInput = Color(0xFFE5E5E5);
  static const Color lightRing = Color(0xFF6366F1);
  static const Color lightDestructive = Color(0xFFEF4444);
  static const Color lightDestructiveForeground = Color(0xFFFFFFFF);

  // ============================================
  // DARK THEME COLORS
  // ============================================
  
  static const Color darkBackground = Color(0xFF0A0A0A);
  static const Color darkForeground = Color(0xFFFAFAFA);
  static const Color darkCard = Color(0xFF171717);
  static const Color darkCardForeground = Color(0xFFFAFAFA);
  static const Color darkPrimary = Color(0xFFFAFAFA);
  static const Color darkPrimaryForeground = Color(0xFF171717);
  static const Color darkSecondary = Color(0xFF262626);
  static const Color darkSecondaryForeground = Color(0xFFFAFAFA);
  static const Color darkMuted = Color(0xFF262626);
  static const Color darkMutedForeground = Color(0xFFA3A3A3);
  static const Color darkAccent = Color(0xFF818CF8); // Lighter indigo for dark mode
  static const Color darkAccentForeground = Color(0xFF0A0A0A);
  static const Color darkBorder = Color(0xFF262626);
  static const Color darkInput = Color(0xFF262626);
  static const Color darkRing = Color(0xFF818CF8);
  static const Color darkDestructive = Color(0xFFDC2626);
  static const Color darkDestructiveForeground = Color(0xFFFAFAFA);

  // ============================================
  // COLOR SCHEME GETTERS
  // ============================================
  
  static Color background(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkBackground : lightBackground;
  
  static Color foreground(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkForeground : lightForeground;
  
  static Color card(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkCard : lightCard;
  
  static Color cardForeground(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkCardForeground : lightCardForeground;
  
  static Color primary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkPrimary : lightPrimary;
  
  static Color primaryForeground(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkPrimaryForeground : lightPrimaryForeground;
  
  static Color secondary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkSecondary : lightSecondary;
  
  static Color secondaryForeground(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkSecondaryForeground : lightSecondaryForeground;
  
  static Color muted(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkMuted : lightMuted;
  
  static Color mutedForeground(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkMutedForeground : lightMutedForeground;
  
  static Color accent(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkAccent : lightAccent;
  
  static Color accentForeground(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkAccentForeground : lightAccentForeground;
  
  static Color border(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkBorder : lightBorder;
  
  static Color input(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkInput : lightInput;
  
  static Color ring(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkRing : lightRing;
  
  static Color destructive(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkDestructive : lightDestructive;
  
  static Color destructiveForeground(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkDestructiveForeground : lightDestructiveForeground;
}
