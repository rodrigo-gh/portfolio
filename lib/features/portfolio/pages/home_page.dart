import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/theme_data.dart';
import 'package:portfolio/data/mock_data.dart';
import 'package:portfolio/features/portfolio/widgets/header.dart';
import 'package:portfolio/features/portfolio/widgets/project_showcase_item.dart';
import 'package:portfolio/features/portfolio/widgets/project_summary_card.dart';
import 'package:portfolio/features/portfolio/widgets/section_title.dart';
import 'package:portfolio/features/portfolio/widgets/trajectory_section.dart';

import 'package:portfolio/core/constants/strings.dart';
import 'package:portfolio/features/portfolio/widgets/hero_section.dart';
import 'package:portfolio/features/portfolio/widgets/footer.dart';

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
                AppStrings.sectionOverviewTitle,
                AppStrings.sectionOverviewSubtitle,
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
                AppStrings.sectionTrajectoryTitle,
                AppStrings.sectionTrajectorySubtitle,
                key: trajectoryKey,
              ),
              const TrajectorySection(
                professionalExperiences: experiences,
                academicExperiences: academicBackground,
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 60)),

              // 3. DETAILED SECTION
              sectionTitle(
                context,
                AppStrings.sectionDetailedTitle,
                AppStrings.sectionDetailedSubtitle,
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
              const SliverToBoxAdapter(child: Footer()),
            ],
          );
        },
      ),
    );
  }
}
