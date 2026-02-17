import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/strings.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/core/utils/url_laucher.dart';
import 'package:portfolio/data/models/project_model.dart';
import 'package:portfolio/features/portfolio/pages/project_details_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProjectShowcaseItem extends StatefulWidget {
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
  State<ProjectShowcaseItem> createState() => _ProjectShowcaseItemState();
}

class _ProjectShowcaseItemState extends State<ProjectShowcaseItem> {
  final PageController _pageController = PageController();
  bool _isHovering = false;
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentIndex < widget.project.galleryAssets.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
      );
    } else {
      // Loop back to start
      _pageController.animateToPage(
        0,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
      );
    } else {
      // Loop to end
      _pageController.animateToPage(
        widget.project.galleryAssets.length - 1,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isDesktop) {
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
                color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
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
      height: 650, // Fixed height to accommodate content
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
                    color: widget.project.colorBase.withValues(alpha: 0.05),
                    blurRadius: 40,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
            ),
          ),
          Row(
            textDirection:
                widget.isReversed ? TextDirection.rtl : TextDirection.ltr,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Visual Side (Large)
              Expanded(
                flex: 6,
                child: ClipRRect(
                  borderRadius: BorderRadius.horizontal(
                    left: widget.isReversed
                        ? Radius.zero
                        : const Radius.circular(32),
                    right: widget.isReversed
                        ? const Radius.circular(32)
                        : Radius.zero,
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
    if (widget.project.galleryAssets.isNotEmpty) {
      return MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: widget.project.galleryAssets.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Image.asset(
                  widget.project.galleryAssets[index],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      padding: const EdgeInsets.all(20),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.broken_image,
                                size: 48,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withValues(alpha: 0.38)),
                            const SizedBox(height: 16),
                            Text(
                              "${AppStrings.showcaseImageNotFound}\n${widget.project.galleryAssets[index]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withValues(alpha: 0.38)),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              AppStrings.showcaseImageInstructions,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withValues(alpha: 0.38),
                                  fontSize: 10),
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
                      Colors.black.withValues(alpha: 0.3),
                    ],
                  ),
                ),
              ),
            ),
            // Page Indicator
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: widget.project.galleryAssets.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: widget.project.colorBase,
                    dotColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
                    dotHeight: 8,
                    dotWidth: 8,
                    expansionFactor: 3,
                  ),
                  onDotClicked: (index) {
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOutCubic,
                    );
                  },
                ),
              ),
            ),
            // Navigation Arrows (Desktop Only)
            if (widget.project.galleryAssets.length > 1) ...[
              // Previous Button
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                left: _isHovering ? 20 : -60, // Slide in from left
                top: 0,
                bottom: 0,
                child: Center(
                  child: _buildNavButton(
                    icon: Icons.arrow_back_ios_rounded,
                    onPressed: _previousPage,
                  ),
                ),
              ),
              // Next Button
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                right: _isHovering ? 20 : -60, // Slide in from right
                top: 0,
                bottom: 0,
                child: Center(
                  child: _buildNavButton(
                    icon: Icons.arrow_forward_ios_rounded,
                    onPressed: _nextPage,
                  ),
                ),
              ),
            ],
          ],
        ),
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
            widget.project.colorBase.withValues(alpha: 0.2),
            widget.project.colorBase.withValues(alpha: 0.05),
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
                color: widget.project.colorBase.withValues(alpha: 0.1),
              ),
            ),
          ),
          // Main Icon/Image Center
          Center(
            child: Icon(
              widget.project.icon,
              size: 80,
              color: widget.project.colorBase.withValues(alpha: 0.8),
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
                    Colors.black.withValues(alpha: 0.1),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(
      {required IconData icon, required VoidCallback onPressed}) {
    return Material(
      color: Colors.black.withValues(alpha: 0.4),
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
        ),
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
            color: widget.project.colorBase.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: widget.project.colorBase.withValues(alpha: 0.3)),
          ),
          child: Text(
            widget.project.statusText.toUpperCase(),
            style: TextStyle(
              color: widget.project.colorBase,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Title
        SelectableText(
          widget.project.title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                height: 1.1,
              ),
        ),
        const SizedBox(height: 16),
        // Description
        SelectableText(
          widget.project.description,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.7),
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
          children: widget.project.techStack.map((tech) {
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
            if (widget.project.link != null)
              ElevatedButton.icon(
                onPressed: () => launchCustomUrl(widget.project.link!),
                icon: Icon(widget.project.linkIcon ?? Icons.open_in_new,
                    size: 18),
                label: Text(widget.project.buttonText),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.project.colorBase,
                  foregroundColor: widget.project.colorBase.computeLuminance() > 0.5
                      ? Colors.black
                      : Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
              ),
            if (widget.project.repoLink != null)
              OutlinedButton.icon(
                onPressed: () => launchCustomUrl(widget.project.repoLink!),
                icon: const Icon(FontAwesomeIcons.github, size: 18),
                label: const Text(AppStrings.showcaseCode),
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  side: BorderSide(
                      color: Theme.of(context).dividerColor.withValues(alpha: 0.3)),
                ),
              ),
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        ProjectDetailsPage(project: widget.project),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_forward, size: 18),
              label: const Text(AppStrings.showcaseDetails),
              style: TextButton.styleFrom(
                foregroundColor:
                    Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.7),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
