import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/strings.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/data/models/experience_model.dart';

class TrajectorySection extends StatefulWidget {
  final List<ExperienceModel> professionalExperiences;
  final List<ExperienceModel> academicExperiences;

  const TrajectorySection({
    super.key,
    required this.professionalExperiences,
    required this.academicExperiences,
  });

  @override
  State<TrajectorySection> createState() => _TrajectorySectionState();
}

class _TrajectorySectionState extends State<TrajectorySection> {
  bool _showProfessional = true;

  @override
  Widget build(BuildContext context) {
    // Determine layout based on width
    final isDesktop = MediaQuery.of(context).size.width > 900;
    
    final experiences = _showProfessional
        ? widget.professionalExperiences
        : widget.academicExperiences;

    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 60 : 24, vertical: 20),
        child: isDesktop
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sticky Profile Card
                  Container(
                    width: 300,
                    margin: const EdgeInsets.only(right: 60),
                    child: _buildStickyProfile(context),
                  ),
                  // Timeline
                  Expanded(
                    child: _buildTimeline(context, experiences),
                  ),
                ],
              )
            : Column(
                children: [
                  _buildStickyProfile(context),
                  const SizedBox(height: 40),
                  _buildTimeline(context, experiences),
                ],
              ),
      ),
    );
  }

  Widget _buildStickyProfile(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
                width: 2,
              ),
            ),
            child: const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile_placeholder.png'),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            AppStrings.profileNameShort, 
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            AppStrings.profileRole,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          const Text(
            AppStrings.profileBio,
            textAlign: TextAlign.center,
            style: TextStyle(height: 1.5, color: Colors.white70),
          ),
           const SizedBox(height: 24),
           // Toggle Buttons (Moved inside card for desktop)
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _TrajectoryTab(
                    label: AppStrings.trajectoryCareer,
                    isSelected: _showProfessional,
                    onTap: () => setState(() => _showProfessional = true),
                  ),
                  _TrajectoryTab(
                    label: AppStrings.trajectoryEducation,
                    isSelected: !_showProfessional,
                    onTap: () => setState(() => _showProfessional = false),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTimeline(BuildContext context, List<ExperienceModel> experiences) {
    return AnimatedSwitcher(
      duration: 300.ms,
      child: ListView.builder(
        key: ValueKey<bool>(_showProfessional),
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
                  top: 24,
                  bottom: 0,
                  left: 11,
                  child: Container(
                    width: 2,
                    color: Theme.of(context).dividerColor,
                  ),
                ),

              // Dot
              Container(
                margin: const EdgeInsets.only(top: 4),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.only(left: 48.0, bottom: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        exp.dateRange,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      exp.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      exp.organization,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      exp.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            height: 1.6,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ).animate().fadeIn(delay: (index * 100).ms).slideX(begin: 0.1, curve: Curves.easeOut);
        },
      ),
    );
  }
}

class _TrajectoryTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TrajectoryTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: 200.ms,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
