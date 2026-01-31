import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/strings.dart';
import 'package:portfolio/core/theme/theme_data.dart';
import 'package:portfolio/features/portfolio/pages/home_page.dart';

void main() {
  runApp(const MyPortfolioApp());
}

// ================== TEMA E CONFIGURAÇÃO PRINCIPAL ==================
class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, currentMode, _) {
        return MaterialApp(
          title: strings["headerTitle"]!,
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: currentMode,
          home: const HomePage(),
        );
      },
    );
  }
}


