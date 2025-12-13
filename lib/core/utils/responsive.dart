import 'package:flutter/material.dart';

/// Responsive breakpoints and utilities
class Responsive {
  Responsive._();

  // ============================================
  // BREAKPOINTS
  // ============================================
  
  static const double mobileBreakpoint = 640;
  static const double tabletBreakpoint = 1024;
  static const double desktopBreakpoint = 1280;

  // ============================================
  // DEVICE TYPE DETECTION
  // ============================================
  
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileBreakpoint;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileBreakpoint &&
      MediaQuery.of(context).size.width < tabletBreakpoint;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletBreakpoint;

  static bool isLargeDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= desktopBreakpoint;

  // ============================================
  // RESPONSIVE VALUE HELPERS
  // ============================================
  
  /// Returns a value based on the current screen size
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(context)) {
      return desktop ?? tablet ?? mobile;
    } else if (isTablet(context)) {
      return tablet ?? mobile;
    }
    return mobile;
  }

  // ============================================
  // GRID COLUMN COUNT
  // ============================================
  
  static int gridColumns(BuildContext context) {
    if (isDesktop(context)) return 3;
    if (isTablet(context)) return 2;
    return 1;
  }

  // ============================================
  // SECTION PADDING
  // ============================================
  
  static EdgeInsets sectionPadding(BuildContext context) {
    final horizontal = value<double>(
      context,
      mobile: 24,
      tablet: 48,
      desktop: 64,
    );
    return EdgeInsets.symmetric(horizontal: horizontal);
  }

  // ============================================
  // CONTENT WIDTH
  // ============================================
  
  static double contentMaxWidth(BuildContext context) {
    return value<double>(
      context,
      mobile: double.infinity,
      tablet: 768,
      desktop: 1200,
    );
  }
}

/// A widget that returns different layouts based on screen size
class ResponsiveBuilder extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= Responsive.tabletBreakpoint) {
          return desktop ?? tablet ?? mobile;
        } else if (constraints.maxWidth >= Responsive.mobileBreakpoint) {
          return tablet ?? mobile;
        }
        return mobile;
      },
    );
  }
}
