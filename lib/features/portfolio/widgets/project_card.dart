import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/core/utils/url_laucher.dart';
import 'package:portfolio/data/models/project_model.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Imagem do Projeto (Placeholder)
          Container(
            height: 160,
            width: double.infinity,
            color: project.colorBase.withValues(alpha: 0.2),
            // Use Image.asset(project.imageAsset) quando tiver imagens
            child: Icon(project.icon, size: 64, color: project.colorBase),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 2. Badge de Status
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: project.colorBase,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    project.statusText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // 3. Título e Descrição
                SelectableText(
                  project.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                SelectableText(
                  project.description,
                  maxLines: 3,
                  style: TextStyle(color: Colors.grey.shade700),
                ),
                const SizedBox(height: 12),

                // 4. Tags de Tecnologia
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: project.techStack
                      .map(
                        (tech) => Chip(
                          label: Text(
                            tech,
                            style: const TextStyle(fontSize: 11),
                          ),
                          backgroundColor: Colors.grey.shade100,
                          padding: EdgeInsets.zero,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          const Spacer(),
          // 5. Botão de Ação (Se houver link)
          if (project.link != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton.tonalIcon(
                  onPressed: () => launchCustomUrl(project.link!),
                  icon: Icon(project.linkIcon),
                  label: Text(project.buttonText),
                  style: FilledButton.styleFrom(
                    backgroundColor: project.colorBase.withOpacity(0.1),
                    foregroundColor: project.colorBase,
                  ),
                ),
              ),
            ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0, curve: Curves.easeOut);
  }
}
