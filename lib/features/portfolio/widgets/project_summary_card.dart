import 'package:flutter/material.dart';
import 'package:portfolio/data/models/project_model.dart';

class ProjectSummaryCard extends StatelessWidget {
  final ProjectModel project;

  const ProjectSummaryCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: project.colorBase.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              project.icon,
              size: 32,
              color: project.colorBase,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            project.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            project.statusText,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.white54,
                  letterSpacing: 1.2,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
