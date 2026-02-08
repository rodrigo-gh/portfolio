import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/core/constants/strings.dart';
import 'package:portfolio/core/utils/url_laucher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Container(
      width: double.infinity,
      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 24,
        vertical: 60,
      ),
      child: Column(
        children: [
          _buildCtaSection(context),
          const SizedBox(height: 48),
          Divider(color: theme.dividerColor.withValues(alpha: 0.1)),
          const SizedBox(height: 48),
          _buildBottomSection(context, isDesktop),
        ],
      ),
    );
  }

  Widget _buildCtaSection(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        SelectableText(
          AppStrings.footerCta,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 32),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
            _SocialIconButton(
              icon: FontAwesomeIcons.github,
              url: AppStrings.profileGitHubUrl,
              tooltip: 'GitHub',
            ),
            SizedBox(width: 24),
            _SocialIconButton(
              icon: FontAwesomeIcons.linkedin,
              url: AppStrings.profileLinkedInUrl,
              tooltip: 'LinkedIn',
            ),
            SizedBox(width: 24),
            _SocialIconButton(
              icon: Icons.email_rounded,
              url: 'mailto:${AppStrings.profileEmail}',
              tooltip: 'Email',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomSection(BuildContext context, bool isDesktop) {
    final theme = Theme.of(context);
    final content = [
      Text(
        '© ${DateTime.now().year} ${AppStrings.profileName}',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
      if (isDesktop) const Spacer(),
      if (!isDesktop) const SizedBox(height: 16),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.favorite,
            size: 14,
            color: theme.colorScheme.primary.withValues(alpha: 0.7),
          ),
          const SizedBox(width: 8),
          Text(
            AppStrings.footerMadeWith,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    ];

    if (isDesktop) {
      return Row(children: content);
    } else {
      return Column(children: content);
    }
  }
}

class _SocialIconButton extends StatefulWidget {
  final IconData icon;
  final String url;
  final String tooltip;

  const _SocialIconButton({
    required this.icon,
    required this.url,
    required this.tooltip,
  });

  @override
  State<_SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => launchCustomUrl(widget.url),
        child: Tooltip(
          message: widget.tooltip,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _isHovered 
                  ? theme.colorScheme.primary 
                  : theme.colorScheme.surface.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isHovered 
                    ? theme.colorScheme.primary 
                    : theme.colorScheme.outline.withValues(alpha: 0.2),
              ),
              boxShadow: _isHovered ? [
                BoxShadow(
                  color: theme.colorScheme.primary.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                )
              ] : [],
            ),
            child: Icon(
              widget.icon,
              size: 24,
              color: _isHovered 
                  ? theme.colorScheme.onPrimary 
                  : theme.colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
