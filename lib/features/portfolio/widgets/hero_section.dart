import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/core/utils/url_laucher.dart'; // Make sure this path is correct or I need to fix the typo in filename later
import 'package:portfolio/core/constants/strings.dart'; // Assuming this exists based on header.dart

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Responsive layout: Use LayoutBuilder to determine constraints
    return SliverToBoxAdapter(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 900;
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 100 : 24,
              vertical: isDesktop ? 80 : 40,
            ),
            decoration: BoxDecoration(
              // Modern gradient background
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).colorScheme.surface,
                  Theme.of(context).colorScheme.primary.withOpacity(0.05),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isDesktop) const SizedBox(height: 60), // Space for fixed navbar
                _buildGreeting(context).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2),
                const SizedBox(height: 16),
                _buildTitle(context, isDesktop).animate().fadeIn(delay: 200.ms, duration: 600.ms).slideX(begin: -0.2),
                const SizedBox(height: 24),
                _buildDescription(context, isDesktop).animate().fadeIn(delay: 400.ms, duration: 600.ms),
                const SizedBox(height: 40),
                _buildActions(context).animate().fadeIn(delay: 600.ms, duration: 600.ms).slideY(begin: 0.2),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildGreeting(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
      ),
      child: Text(
        "👋 Olá, bem-vindo(a) ao meu portfólio",
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context, bool isDesktop) {
    return Text(
      // Using generic text if strings["headerTitle"] is not available or handled elsewhere
      strings["headerTitle"] ?? "Transformando ideias\nem realidade digital",
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
        fontSize: isDesktop ? 72 : 48,
        fontWeight: FontWeight.w800,
        height: 1.1,
        letterSpacing: -1.5,
        color: Theme.of(context).textTheme.displayLarge?.color,
      ),
    );
  }

  Widget _buildDescription(BuildContext context, bool isDesktop) {
    return SizedBox(
      width: isDesktop ? 600 : double.infinity,
      child: Text(
        strings["headerSubtitle"] ?? "Desenvolvedor Mobile & Web focado em criar experiências excepcionais com Flutter.",
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontSize: isDesktop ? 24 : 18,
              fontWeight: FontWeight.w400,
              height: 1.5,
              color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
            ),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        ElevatedButton.icon(
          onPressed: () => launchCustomUrl("https://linkedin.com/in/seu-perfil"),
          icon: const Icon(FontAwesomeIcons.linkedin),
          label: const Text("LinkedIn"),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        OutlinedButton.icon(
          onPressed: () => launchCustomUrl("https://github.com/seu-user"),
          icon: const Icon(FontAwesomeIcons.github),
          label: const Text("GitHub"),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            side: BorderSide(color: Theme.of(context).colorScheme.outline),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
