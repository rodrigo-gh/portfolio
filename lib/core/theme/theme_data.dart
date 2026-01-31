import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Simple Global State for Theme Mode
final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(ThemeMode.light);

void toggleTheme() {
  themeModeNotifier.value = themeModeNotifier.value == ThemeMode.light
      ? ThemeMode.dark
      : ThemeMode.light;
}

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF0D47A1), // Azul profissional
    brightness: Brightness.light,
  ),
  textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
  scaffoldBackgroundColor: const Color(0xFFF5F7FA),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF0D47A1),
    brightness: Brightness.dark,
  ).copyWith(
    surface: const Color(0xFF1E1E2C), // Dark surface
  ),
  textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
  scaffoldBackgroundColor: const Color(0xFF121218), // Dark background
);