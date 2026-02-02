import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/core/utils/url_laucher.dart';
import 'package:portfolio/data/models/project_model.dart';

class ProjectShowcaseItem extends StatelessWidget {
  final ProjectModel project;
  final bool isDesktop;
  final bool isReversed;

  const ProjectShowcaseItem({
    super.key,
    required this.project,
    required this.isDesktop,
    this.isReversed = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!isDesktop) {
      return _buildMobileLayout(context);
    }
    return _buildDesktopLayout(context);
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Visual Part (Top)
          AspectRatio(
            aspectRatio: 16 / 9,
            child: _buildProjectVisual(context),
          ),
          // Content Part (Bottom)
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
              ),
            ),
            child: _buildProjectInfo(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      height: 650, // Fixed height to accommodate content and avoid IntrinsicHeight+PageView issues
      child: Stack(
        children: [
            // Background "Card" Effect
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: project.colorBase.withOpacity(0.05),
                      blurRadius: 40,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              textDirection: isReversed ? TextDirection.rtl : TextDirection.ltr,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Visual Side (Large)
                Expanded(
                  flex: 6,
                  child: ClipRRect(
                    borderRadius: BorderRadius.horizontal(
                      left: isReversed ? Radius.zero : const Radius.circular(32),
                      right: isReversed ? const Radius.circular(32) : Radius.zero,
                    ),
                    child: _buildProjectVisual(context),
                  ),
                ),
                // Content Side
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(48.0),
                    child: _buildProjectInfo(context, center: false),
                  ),
                ),
              ],
            ),
          ],
      ),
    );
  }

  Widget _buildProjectVisual(BuildContext context) {
    if (project.galleryAssets.isNotEmpty) {
      return Stack(
        children: [
          PageView.builder(
            itemCount: project.galleryAssets.length,
            itemBuilder: (context, index) {
              return Image.asset(
                project.galleryAssets[index],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[900],
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.broken_image,
                              size: 48, color: Colors.white24),
                          const SizedBox(height: 16),
                          Text(
                            "Imagem não encontrada:\n${project.galleryAssets[index]}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white24),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Adicione os arquivos na pasta 'assets' do projeto.",
                            style:
                                TextStyle(color: Colors.white12, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          // Overlay Gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.3),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    // Default Fallback (Icon Design)
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            project.colorBase.withOpacity(0.2),
            project.colorBase.withOpacity(0.05),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Decorative Circle
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: project.colorBase.withOpacity(0.1),
              ),
            ),
          ),
          // Main Icon/Image Center
          Center(
            child: Icon(
              project.icon,
              size: 80,
              color: project.colorBase.withOpacity(0.8),
            ),
          ),
          // Overlay Glass Effect
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.1),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectInfo(BuildContext context, {bool center = false}) {
    return Column(
      crossAxisAlignment:
          center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Status Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: project.colorBase.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: project.colorBase.withOpacity(0.3)),
          ),
          child: Text(
            project.statusText.toUpperCase(),
            style: TextStyle(
              color: project.colorBase,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Title
        SelectableText(
          project.title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                height: 1.1,
              ),
        ),
        const SizedBox(height: 16),
        // Description
        SelectableText(
          project.details ?? project.description,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white70,
                height: 1.5,
              ),
          textAlign: center ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 24),
        // Tech Stack
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: center ? WrapAlignment.center : WrapAlignment.start,
          children: project.techStack.map((tech) {
            return Chip(
              label: Text(tech),
              backgroundColor: Theme.of(context).cardColor,
              side: BorderSide.none,
              labelStyle: const TextStyle(fontSize: 12),
              padding: const EdgeInsets.all(4),
              visualDensity: VisualDensity.compact,
            );
          }).toList(),
        ),
        const SizedBox(height: 32),
        // Buttons
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: center ? WrapAlignment.center : WrapAlignment.start,
          children: [
            if (project.link != null)
              ElevatedButton.icon(
                onPressed: () => launchCustomUrl(project.link!),
                icon: Icon(project.linkIcon ?? Icons.open_in_new, size: 18),
                label: Text(project.buttonText),
                style: ElevatedButton.styleFrom(
                  backgroundColor: project.colorBase,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
              ),
            if (project.repoLink != null)
              OutlinedButton.icon(
                onPressed: () => launchCustomUrl(project.repoLink!),
                icon: const Icon(FontAwesomeIcons.github, size: 18),
                label: const Text("Código"),
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  side: BorderSide(color: Colors.white.withOpacity(0.3)),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
