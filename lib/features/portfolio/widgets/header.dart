import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/strings.dart';
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
    backgroundColor:
        Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.8),
    elevation: 0,
    title: Text(
      AppStrings.profileName,
      style: GoogleFonts.outfit(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    ),
    centerTitle: false,
    actions: [
      _NavButton(label: AppStrings.navTrajectory, onTap: onNavTrajectory),
      _NavButton(label: AppStrings.navProjects, onTap: onNavProjects),
      const SizedBox(width: 24),
    ],
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
      style: TextButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.onSurface),
      child: Text(label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
    );
  }
}
