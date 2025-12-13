import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'pages/home_page.dart';

/// Main app widget with theme support
class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  ThemeMode _themeMode = ThemeMode.dark; // Default to dark mode

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark 
          ? ThemeMode.light 
          : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mohamed Eladnani | Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      home: HomePage(
        onThemeToggle: _toggleTheme,
        isDarkMode: _themeMode == ThemeMode.dark,
      ),
    );
  }
}
