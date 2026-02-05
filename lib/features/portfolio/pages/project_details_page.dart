import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/core/utils/url_laucher.dart';
import 'package:portfolio/data/models/project_model.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProjectDetailsPage extends StatefulWidget {
  final ProjectModel project;

  const ProjectDetailsPage({super.key, required this.project});

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  late PageController _pageController;
  int _currentIndex = 0;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

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
      _pageController.animateToPage(
        widget.project.galleryAssets.length - 1,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine responsive layout
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;
    
    // Calculate optimal header height: 
    // - On mobile: ~40% of screen or 300px min
    // - On desktop: maintain closer to 16:9 ratio but capped
    double headerHeight = isDesktop 
        ? (size.width * 0.4).clamp(400.0, 700.0) // Responsive height for desktop
        : 350.0;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          // 1. Dynamic AppBar with Interactive Gallery
          SliverAppBar(
            expandedHeight: headerHeight,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            leading: IconButton(
              tooltip: 'Voltar',
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back_ios_new, size: 20),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: _buildCinematicGallery(context),
            ),
          ),

          // 2. Content Body
          SliverToBoxAdapter(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1200),
                margin: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 60 : 20,
                  vertical: 40,
                ),
                child: isDesktop
                    ? _buildDesktopContent(context)
                    : _buildMobileContent(context),
              ),
            ),
          ),
          
          // 3. Footer Spacer
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _buildCinematicGallery(BuildContext context) {
    if (widget.project.galleryAssets.isEmpty) {
      return Container(
        color: widget.project.colorBase.withValues(alpha: 0.1),
        child: Center(
          child: Icon(widget.project.icon, size: 80, color: widget.project.colorBase),
        ),
      );
    }

    final currentImage = widget.project.galleryAssets[_currentIndex];

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Blurred Background (Cinematic Effect)
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: Container(
              key: ValueKey(currentImage),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(currentImage),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withValues(alpha: 0.7), // Keeping black as this is a cinematic background effect
                    BlendMode.darken
                  ),
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),

          // 2. Main Carousel
          PageView.builder(
            controller: _pageController,
            itemCount: widget.project.galleryAssets.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (context, index) {
              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    child: Hero(
                      tag: index == 0 ? 'project_visual_${widget.project.title}' : 'project_visual_${widget.project.title}_$index',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          widget.project.galleryAssets[index],
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          
          // 3. Bottom Gradient for Text Contrast
           Positioned(
             bottom: 0,
             left: 0, 
             right: 0,
             height: 100,
             child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Theme.of(context).scaffoldBackgroundColor,
                  ],
                ),
              ),
            ),
          ),

          // 4. Indicators
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
                  dotColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.54),
                  dotHeight: 6,
                  dotWidth: 6,
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

          // 5. Desktop Navigation Arrows
          if (widget.project.galleryAssets.length > 1) ...[
             AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                left: _isHovering ? 20 : -60,
                top: 0, bottom: 0,
                child: Center(
                  child: _buildNavButton(
                    icon: Icons.arrow_back_ios_rounded,
                    onPressed: _previousPage,
                  ),
                ),
             ),
             AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                right: _isHovering ? 20 : -60,
                top: 0, bottom: 0,
                child: Center(
                  child: _buildNavButton(
                    icon: Icons.arrow_forward_ios_rounded,
                    onPressed: _nextPage,
                  ),
                ),
             ),
          ]
        ],
      ),
    );
  }

  Widget _buildNavButton({required IconData icon, required VoidCallback onPressed}) {
    return Material(
      color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.8), // Using surface for better contrast
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Icon(icon,
              color: Theme.of(context).colorScheme.onSurface,
              size: 28), // Adapting icon color
        ),
      ),
    );
  }

  Widget _buildDesktopContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column: Main Description (65%)
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               _buildHeader(context),
               const SizedBox(height: 40),
               _buildRichTextSection(context, "Sobre o Projeto", widget.project.details ?? widget.project.description),
            ],
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0),
        ),
        
        const SizedBox(width: 80),

        // Right Column: Sidebar (Metadata) (35%)
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSidebarCard(
                context, 
                title: "Tecnologias",
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: widget.project.techStack.map((tech) => Chip(
                    label: Text(tech),
                    backgroundColor: Theme.of(context).cardColor,
                  )).toList(),
                ),
              ),
              const SizedBox(height: 24),
              _buildSidebarCard(
                context, 
                title: "Links",
                child: Column(
                  children: [
                    if (widget.project.link != null)
                      _buildLinkButton(
                        context, 
                        icon: widget.project.linkIcon ?? Icons.public, 
                        label: widget.project.buttonText, 
                        url: widget.project.link!,
                        isPrimary: true,
                        color: widget.project.colorBase,
                      ),
                    if (widget.project.link != null && widget.project.repoLink != null)
                      const SizedBox(height: 12),
                    if (widget.project.repoLink != null)
                      _buildLinkButton(
                        context, 
                        icon: FontAwesomeIcons.github, 
                        label: "Repositório", 
                        url: widget.project.repoLink!,
                        isPrimary: false,
                        color: widget.project.colorBase,
                      ),
                  ],
                ),
              ),
            ],
          ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideX(begin: 0.1, end: 0),
        ),
      ],
    );
  }

  Widget _buildMobileContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(context),
        const SizedBox(height: 32),
        
        // Links Section (Mobile Priority)
        Row(
          children: [
             if (widget.project.link != null)
              Expanded(
                child: _buildLinkButton(
                        context, 
                        icon: widget.project.linkIcon ?? Icons.public, 
                        label: "Acessar", 
                        url: widget.project.link!,
                        isPrimary: true,
                        color: widget.project.colorBase,
                      ),
              ),
            if (widget.project.link != null && widget.project.repoLink != null)
              const SizedBox(width: 16),
            if (widget.project.repoLink != null)
              Expanded(
                child: _buildLinkButton(
                        context, 
                        icon: FontAwesomeIcons.github, 
                        label: "Código", 
                        url: widget.project.repoLink!,
                        isPrimary: false,
                        color: widget.project.colorBase,
                      ),
              ),
          ],
        ),
        const SizedBox(height: 32),

        // Tech Stack
        Text(
          "Tecnologias",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.project.techStack.map((tech) => Chip(
            label: Text(tech, style: const TextStyle(fontSize: 12)),
            backgroundColor: Theme.of(context).cardColor,
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
          )).toList(),
        ),
        const SizedBox(height: 32),

        // Main Content
        _buildRichTextSection(context, "Sobre o Projeto", widget.project.details ?? widget.project.description),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: widget.project.colorBase.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: widget.project.colorBase.withValues(alpha: 0.3)),
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
        SelectableText(
          widget.project.title,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w800,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildRichTextSection(BuildContext context, String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        SelectableText(
          content,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            height: 1.8,
            color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.7),
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildSidebarCard(BuildContext context, {required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.54),
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildLinkButton(
    BuildContext context, {
    required IconData icon, 
    required String label, 
    required String url,
    required bool isPrimary,
    required Color color,
  }) {
    final style = isPrimary 
      ? ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(vertical: 20),
          elevation: 0,
        )
      : OutlinedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.primary,
          side: BorderSide(
              color: Theme.of(context).dividerColor.withValues(alpha: 0.3)),
          padding: const EdgeInsets.symmetric(vertical: 20),
        );

    return SizedBox(
      width: double.infinity,
      child: isPrimary 
        ? ElevatedButton.icon(
            onPressed: () => launchCustomUrl(url),
            icon: Icon(icon, size: 20),
            label: Text(label),
            style: style,
          )
        : OutlinedButton.icon(
             onPressed: () => launchCustomUrl(url),
            icon: Icon(icon, size: 20),
            label: Text(label),
            style: style,
        ),
    );
  }
}
