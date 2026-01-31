import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/core/utils/url_laucher.dart';
import 'package:portfolio/core/theme/theme_data.dart';
import 'package:portfolio/data/mock_data.dart';
import 'package:portfolio/features/portfolio/widgets/header.dart';
import 'package:portfolio/features/portfolio/widgets/projects_grid.dart';
import 'package:portfolio/features/portfolio/widgets/section_title.dart';
import 'package:portfolio/features/portfolio/widgets/status_counter.dart';
import 'package:portfolio/features/portfolio/widgets/trajectory_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final trajectoryKey = GlobalKey();
  final projectsKey = GlobalKey();
  final academicKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const FloatingActionButton(
        onPressed: toggleTheme,
        child: Icon(Icons.brightness_6),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 800;
          return CustomScrollView(
            slivers: [
              header(
                isDesktop,
                context,
                onNavTrajectory: () => _scrollTo(trajectoryKey),
                onNavProjects: () => _scrollTo(projectsKey),
              ),
              statusCounter(
                context,
                '1',
                'Sistema Web\nem Produção',
                Icons.public,
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 40)),
              sectionTitle(
                context,
                "Minha Trajetória",
                "Experiência profissional.",
                key: trajectoryKey,
              ),
              const TrajectorySection(experiences: experiences),
              const SliverToBoxAdapter(child: SizedBox(height: 40)),
              const SliverToBoxAdapter(child: SizedBox(height: 40)),
              sectionTitle(
                context,
                "Minha Trajetória",
                "Experiência acadêmica.",
                key: academicKey,
              ),
              const TrajectorySection(experiences: academicBackground),
              const SliverToBoxAdapter(child: SizedBox(height: 40)),
              sectionTitle(
                context,
                "Em Produção & Beta",
                "O foco é entregar valor real.",
                key: projectsKey,
              ),
              projectsGrid(
                context,
                isDesktop,
                productionProjects,
                constraints,
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 40)),
              sectionTitle(
                context,
                "Em Desenvolvimento",
                "Explorando arquiteturas e desafios técnicos.",
              ),
              projectsGrid(
                context,
                isDesktop,
                developmentProjects,
                constraints,
              ),
              _buildFooter(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(30),
        color: Colors.grey.shade900,
        alignment: Alignment.center,
        child: Column(
          children: [
            const SelectableText(
              "Vamos construir algo juntos?",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () =>
                      launchCustomUrl("https://github.com/seu-user"),
                  icon:
                      const Icon(FontAwesomeIcons.github, color: Colors.white),
                ),
                IconButton(
                  onPressed: () => launchCustomUrl("mailto:seuemail@gmail.com"),
                  icon: const Icon(Icons.email, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const SelectableText(
              "Feito com Flutter Web.",
              style: TextStyle(color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }
}
