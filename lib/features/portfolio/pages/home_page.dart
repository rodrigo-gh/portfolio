import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/core/utils/url_laucher.dart';
import 'package:portfolio/core/theme/theme_data.dart';
import 'package:portfolio/data/mock_data.dart';
import 'package:portfolio/features/portfolio/widgets/header.dart';
import 'package:portfolio/features/portfolio/widgets/project_showcase_item.dart';
import 'package:portfolio/features/portfolio/widgets/project_summary_card.dart';
import 'package:portfolio/features/portfolio/widgets/section_title.dart';
import 'package:portfolio/features/portfolio/widgets/trajectory_section.dart';

import 'package:portfolio/features/portfolio/widgets/hero_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final trajectoryKey = GlobalKey();
  final projectsKey = GlobalKey();
  final academicKey = GlobalKey();
  
  // Create a list of keys for each project
  late List<GlobalKey> projectKeys;

  @override
  void initState() {
    super.initState();
    // Initialize keys based on total number of projects
    final totalProjects = productionProjects.length + developmentProjects.length;
    projectKeys = List.generate(totalProjects, (_) => GlobalKey());
  }

  void _scrollTo(GlobalKey key) {
    if (key.currentContext == null) return;
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      alignment: 0.1, // Align slightly below the top to show some margin
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
          final allProjects = [...productionProjects, ...developmentProjects];

          return CustomScrollView(
            slivers: [
              header(
                isDesktop,
                context,
                onNavTrajectory: () => _scrollTo(trajectoryKey),
                onNavProjects: () => _scrollTo(projectsKey),
              ),
              const HeroSection(),
              const SliverToBoxAdapter(child: SizedBox(height: 40)),
              
              // 1. SUMMARY SECTION
              sectionTitle(
                context,
                "Visão Geral",
                "Todos os projetos em um relance.",
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isDesktop ? 3 : 1,
                    childAspectRatio: 1.2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return ProjectSummaryCard(
                        project: allProjects[index],
                        onTap: () => _scrollTo(projectKeys[index]),
                      );
                    },
                    childCount: allProjects.length,
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 60)),

              // 2. TRAJECTORY SECTION
              sectionTitle(
                context,
                "Minha Trajetória",
                "Experiência profissional e acadêmica.",
                key: trajectoryKey,
              ),
              TrajectorySection(
                professionalExperiences: experiences,
                academicExperiences: academicBackground,
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 60)),

              // 3. DETAILED SECTION
              sectionTitle(
                context,
                "Exploração Detalhada",
                "Mergulhe nos detalhes de cada projeto.",
                key: projectsKey,
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
              
             
              SliverToBoxAdapter(
                child: Column(
                  children: List.generate(allProjects.length, (index) {
                    return Container(
                      key: projectKeys[index], // Assign the key here
                      child: ProjectShowcaseItem(
                        project: allProjects[index],
                        isDesktop: isDesktop,
                        isReversed: index % 2 != 0,
                      ),
                    );
                  }),
                ),
              ),
              
              const SliverToBoxAdapter(child: SizedBox(height: 40)),
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
        padding: const EdgeInsets.all(40),
        color: Colors.grey.shade900,
        alignment: Alignment.center,
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/images/profile_placeholder.png'),
            ),
             const SizedBox(height: 20),
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
