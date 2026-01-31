import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/data/models/experience_model.dart';

class TrajectorySection extends StatelessWidget {
  final List<ExperienceModel> experiences;

  const TrajectorySection({super.key, required this.experiences});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: experiences.length,
              itemBuilder: (context, index) {
                final exp = experiences[index];
                final isLast = index == experiences.length - 1;

                return Stack(
                  children: [
                    // Line (Only if not last)
                    if (!isLast)
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 7, // Center of the 16px dot
                        child: Container(
                          width: 2,
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                        ),
                      ),
                    
                    // Dot
                    Container(
                      margin: const EdgeInsets.only(top: 4), // Align with text top roughly
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          width: 3,
                        ),
                      ),
                    ),

                    // Content
                    Padding(
                      padding: const EdgeInsets.only(left: 32.0, bottom: 32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exp.dateRange,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            exp.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            exp.organization,
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.8),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            exp.description,
                            style: TextStyle(
                              color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ).animate().fadeIn(delay: (index * 200).ms).slideX();
              },
            ),
          ],
        ),
      ),
    );
  }
}
