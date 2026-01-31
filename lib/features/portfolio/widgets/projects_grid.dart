import 'package:flutter/material.dart';
import 'package:portfolio/features/portfolio/widgets/project_card.dart';
import 'package:portfolio/data/models/project_model.dart';

Widget projectsGrid(
  BuildContext context,
  bool isDesktop,
  List<ProjectModel> projects,
  BoxConstraints constraints,
) {
  // No desktop mostra 2 ou 3 por linha, no mobile 1.
  int crossAxisCount = isDesktop ? (constraints.maxWidth > 1100 ? 3 : 2) : 1;
  double childAspectRatio;
  if (constraints.maxWidth > 1100) {
    childAspectRatio = 0.9;
  } else if (isDesktop) {
    // Tablet / Small Desktop (2 columns)
    // Cards are narrower here, so we need more vertical space
    childAspectRatio = 0.7;
  } else {
    // Mobile (1 column)
    childAspectRatio = 0.65;
  }

  return SliverPadding(
    padding: const EdgeInsets.all(24.0),
    sliver: SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
      ),
      delegate: SliverChildBuilderDelegate((context, index) {
        return ProjectCard(project: projects[index]);
      }, childCount: projects.length),
    ),
  );
}
