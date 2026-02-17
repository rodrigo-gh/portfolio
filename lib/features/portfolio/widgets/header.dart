import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/strings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/features/portfolio/widgets/mobile_nav_sheet.dart';

Widget header(
  bool isDesktop,
  BuildContext context, {
  required VoidCallback onNavBegin,
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
    actions: isDesktop
        ? [
            _NavButton(label: AppStrings.navBegin, onTap: onNavBegin),
            _NavButton(label: AppStrings.navTrajectory, onTap: onNavTrajectory),
            _NavButton(label: AppStrings.navProjects, onTap: onNavProjects),
            const SizedBox(width: 24),
          ]
        : [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true, // Permite customizar tamanho se necessário
                  builder: (context) => MobileNavSheet(
                    onNavBegin: onNavBegin,
                    onNavTrajectory: onNavTrajectory,
                    onNavProjects: onNavProjects,
                  ),
                );
              },
              icon: const Icon(Icons.menu),
              style: IconButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(width: 8),
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
