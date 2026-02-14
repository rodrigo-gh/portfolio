import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(ThemeMode.dark);

void toggleTheme() {
  themeModeNotifier.value = themeModeNotifier.value == ThemeMode.light
      ? ThemeMode.dark
      : ThemeMode.light;
}

TextTheme _buildTextTheme(TextTheme base) {
  return GoogleFonts.interTextTheme(base).copyWith(
    displayLarge: GoogleFonts.outfit(textStyle: base.displayLarge),
    displayMedium: GoogleFonts.outfit(textStyle: base.displayMedium),
    displaySmall: GoogleFonts.outfit(textStyle: base.displaySmall),
    headlineLarge: GoogleFonts.outfit(textStyle: base.headlineLarge),
    headlineMedium: GoogleFonts.outfit(textStyle: base.headlineMedium),
    headlineSmall: GoogleFonts.outfit(textStyle: base.headlineSmall),
    titleLarge: GoogleFonts.outfit(textStyle: base.titleLarge, fontWeight: FontWeight.bold),
    titleMedium: GoogleFonts.outfit(textStyle: base.titleMedium, fontWeight: FontWeight.w600),
    titleSmall: GoogleFonts.outfit(textStyle: base.titleSmall, fontWeight: FontWeight.w600),
  );
}

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF0EA5E9), // Sky 500 
    brightness: Brightness.light,
    primary: const Color(0xFF0284C7), // Sky 600
    secondary: const Color(0xFF8B5CF6), // Violet 500
    surface: const Color(0xFFFFFFFF),
    onSurface: const Color(0xFF0F172A), // Slate 900
  ),
  textTheme: _buildTextTheme(ThemeData.light().textTheme),
  scaffoldBackgroundColor: const Color(0xFFF8FAFC), // Slate 50
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF38BDF8), // Sky 400
    brightness: Brightness.dark,
    primary: const Color(0xFF38BDF8), // Sky 400
    secondary: const Color(0xFFA78BFA), // Violet 400
    surface: const Color(0xFF1E293B), // Slate 800
    onSurface: const Color(0xFFF1F5F9), // Slate 100
  ),
  textTheme: _buildTextTheme(ThemeData.dark().textTheme),
  scaffoldBackgroundColor: const Color(0xFF0F172A), // Slate 900
);