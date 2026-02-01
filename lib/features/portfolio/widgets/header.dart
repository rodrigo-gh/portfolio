import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget header(
  bool isDesktop,
  BuildContext context, {
  required VoidCallback onNavTrajectory,
  required VoidCallback onNavProjects,
}) {
  return SliverAppBar(
    pinned: true,
    floating: true,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
    elevation: 0,
    title: Text(
      "Rodrigo Dev", // Or strings["appName"]
      style: GoogleFonts.outfit(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    ),
    centerTitle: false,
    actions: isDesktop
        ? [
            _NavButton(label: "Trajetória", onTap: onNavTrajectory),
            _NavButton(label: "Projetos", onTap: onNavProjects),
            const SizedBox(width: 24),
          ]
        : null, // Mobile menu could be a Drawer or PopupMenu, for now keeping simple or adding later
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
      style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.onSurface),
      child: Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
    );
  }
}
