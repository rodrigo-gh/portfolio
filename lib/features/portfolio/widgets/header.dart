import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/constants/strings.dart';
import 'package:portfolio/core/utils/url_laucher.dart';

Widget header(
  bool isDesktop,
  BuildContext context, {
  required VoidCallback onNavTrajectory,
  required VoidCallback onNavProjects,
}) {
  return SliverAppBar(
    expandedHeight: isDesktop ? 500.0 : 450.0, // Increased height for nav
    floating: false,
    pinned: true,
    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
    flexibleSpace: FlexibleSpaceBar(
      background: Container(
        padding: const EdgeInsets.all(30),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade900, Colors.blue.shade600],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectableText(
              strings["headerTitle"]!,
              style: GoogleFonts.poppins(
                fontSize: isDesktop ? 48 : 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            SelectableText(
              strings["headerSubtitle"]!,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: isDesktop ? 24 : 18,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                launchCustomUrl("https://linkedin.com/in/seu-perfil");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue.shade900,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
              icon: const Icon(FontAwesomeIcons.linkedin),
              label: const Text("Ver meu LinkedIn"),
            ),
            const SizedBox(height: 40),
            // Navigation Buttons
            Wrap(
              spacing: 20,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                _NavButton(label: "Minha Trajetória", onTap: onNavTrajectory),
                _NavButton(label: "Projetos", onTap: onNavProjects),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

class _NavButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _NavButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(foregroundColor: Colors.white),
      child: Text(label, style: const TextStyle(fontSize: 16)),
    );
  }
}
