import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/core/utils/url_laucher.dart';
import 'package:portfolio/data/models/project_model.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.03 : 1.0,
        duration: 200.ms,
        curve: Curves.easeInOut,
        child: Card(
          elevation: _isHovered ? 8 : 2,
          shadowColor: widget.project.colorBase.withOpacity(0.3),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header with Icon/Image
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: widget.project.colorBase.withOpacity(0.1),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      widget.project.colorBase.withOpacity(0.1),
                      widget.project.colorBase.withOpacity(0.05),
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    widget.project.icon,
                    size: 64,
                    color: widget.project.colorBase,
                  ).animate(target: _isHovered ? 1 : 0).scale(end: const Offset(1.1, 1.1)),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 2. Status Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: widget.project.colorBase.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: widget.project.colorBase.withOpacity(0.2)),
                      ),
                      child: Text(
                        widget.project.statusText,
                        style: TextStyle(
                          color: widget.project.colorBase,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 3. Title & Description
                    SelectableText(
                      widget.project.title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SelectableText(
                      widget.project.description,
                      maxLines: 3,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 4. Tech Stack Tags
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.project.techStack.map((tech) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            tech,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              
              // 5. Actions
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Row(
                  children: [
                    if (widget.project.link != null)
                      Expanded(
                        child: FilledButton.tonalIcon(
                          onPressed: () => launchCustomUrl(widget.project.link!),
                          icon: Icon(widget.project.linkIcon ?? Icons.open_in_new, size: 18),
                          label: Text(widget.project.buttonText),
                          style: FilledButton.styleFrom(
                            backgroundColor: widget.project.colorBase.withOpacity(0.1),
                            foregroundColor: widget.project.colorBase,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    if (widget.project.link != null && widget.project.repoLink != null)
                      const SizedBox(width: 12),
                    if (widget.project.repoLink != null)
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => launchCustomUrl(widget.project.repoLink!),
                          icon: const Icon(FontAwesomeIcons.github, size: 18),
                          label: const Text("Código"),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            side: BorderSide(color: theme.dividerColor),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0, curve: Curves.easeOut);
  }
}
