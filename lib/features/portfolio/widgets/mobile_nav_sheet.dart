import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/core/constants/strings.dart';
import 'package:portfolio/core/theme/theme_data.dart';
import 'package:portfolio/core/utils/url_laucher.dart';

class MobileNavSheet extends StatelessWidget {
  final VoidCallback onNavBegin;
  final VoidCallback onNavTrajectory;
  final VoidCallback onNavProjects;

  const MobileNavSheet({
    super.key,
    required this.onNavBegin,
    required this.onNavTrajectory,
    required this.onNavProjects,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor.withValues(alpha: 0.8),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: Border(
              top: BorderSide(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              // Drag Handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 32),
              
              // Menu Items
              _NavSheetItem(
                icon: Icons.home_rounded,
                label: AppStrings.navBegin,
                onTap: () {
                  Navigator.pop(context);
                  onNavBegin();
                },
              ),
              _NavSheetItem(
                icon: Icons.timeline_rounded,
                label: AppStrings.navTrajectory,
                onTap: () {
                  Navigator.pop(context);
                  onNavTrajectory();
                },
              ),
              _NavSheetItem(
                icon: Icons.grid_view_rounded,
                label: AppStrings.navProjects,
                onTap: () {
                  Navigator.pop(context);
                  onNavProjects();
                },
              ),
              
              const SizedBox(height: 24),
              Divider(color: theme.dividerColor.withValues(alpha: 0.1)),
              const SizedBox(height: 24),
              
              // Social & Theme
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                   IconButton(
                    onPressed: toggleTheme,
                    icon: const Icon(Icons.brightness_6),
                    tooltip: 'Alternar Tema',
                    style: IconButton.styleFrom(
                      backgroundColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                      padding: const EdgeInsets.all(12),
                    ),
                  ),
                  _SocialButton(
                    icon: FontAwesomeIcons.linkedin,
                    url: AppStrings.profileLinkedInUrl,
                  ),
                  _SocialButton(
                    icon: FontAwesomeIcons.github,
                    url: AppStrings.profileGitHubUrl,
                  ),
                  _SocialButton(
                    icon: Icons.email_rounded,
                    url: 'mailto:${AppStrings.profileEmail}',
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavSheetItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _NavSheetItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Icon(
              icon,
              color: theme.colorScheme.primary,
              size: 28,
            ),
            const SizedBox(width: 20),
            Text(
              label,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right_rounded,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String url;

  const _SocialButton({required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return IconButton(
      onPressed: () => launchCustomUrl(url),
      icon: Icon(icon, size: 20),
      style: IconButton.styleFrom(
        backgroundColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        padding: const EdgeInsets.all(12),
        foregroundColor: theme.colorScheme.onSurface,
      ),
    );
  }
}
