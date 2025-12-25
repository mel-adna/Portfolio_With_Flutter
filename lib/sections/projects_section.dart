import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_typography.dart';
import '../core/utils/responsive.dart';
import '../data/projects_data.dart';
import '../widgets/buttons/shadcn_button.dart';
import '../widgets/cards/shadcn_card.dart';
import '../widgets/badge/shadcn_badge.dart';
import '../widgets/tabs/shadcn_tabs.dart';
import '../widgets/dialog/shadcn_dialog.dart';

/// Projects section with responsive grid
class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: Responsive.sectionPadding(context),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: Responsive.contentMaxWidth(context),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section header
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Featured Projects',
                    style: AppTypography.headingLarge(
                      AppColors.foreground(context),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'A selection of projects that showcase my skills and experience',
                    style: AppTypography.bodyMedium(
                      AppColors.mutedForeground(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),

              // Project tabs
              ShadcnTabs(
                tabs: [
                  ShadcnTab(
                    label: 'All',
                    icon: Icons.apps_rounded,
                    content: _ProjectGrid(projects: projectsData),
                  ),
                  ShadcnTab(
                    label: 'Mobile',
                    icon: Icons.phone_android_rounded,
                    content: _ProjectGrid(
                      projects: projectsData
                          .where((p) => p.category == ProjectCategory.mobile)
                          .toList(),
                    ),
                  ),
                  ShadcnTab(
                    label: 'Web',
                    icon: Icons.web_rounded,
                    content: _ProjectGrid(
                      projects: projectsData
                          .where((p) => p.category == ProjectCategory.web)
                          .toList(),
                    ),
                  ),
                  ShadcnTab(
                    label: 'Packages',
                    icon: Icons.inventory_2_rounded,
                    content: _ProjectGrid(
                      projects: projectsData
                          .where((p) => p.category == ProjectCategory.package)
                          .toList(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Grid of project cards
class _ProjectGrid extends StatelessWidget {
  final List<Project> projects;

  const _ProjectGrid({required this.projects});

  @override
  Widget build(BuildContext context) {
    if (projects.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          child: Text(
            'No projects in this category yet.',
            style: AppTypography.bodyMedium(AppColors.mutedForeground(context)),
          ),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = Responsive.gridColumns(context);

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: AppSpacing.md,
            mainAxisSpacing: AppSpacing.md,
            mainAxisExtent: Responsive.value(
              context,
              mobile: 360, // Increased for larger images
              tablet: 380,
              desktop: 400,
            ),
          ),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            return _ProjectCard(project: projects[index]);
          },
        );
      },
    );
  }
}

/// Individual project card
class _ProjectCard extends StatelessWidget {
  final Project project;

  const _ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return ShadcnCard(
      hoverable: true,
      onTap: () => _showProjectDetails(context),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project image or placeholder
          Container(
            height: 140, // Increased height for better screenshot visibility
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.card(context), // Fallback color
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              border: Border.all(
                color: AppColors.border(context).withValues(alpha: 0.5),
              ),
            ),
            clipBehavior: Clip.antiAlias, // Clip image to border radius
            child: project.imageUrl != null
                ? Image.asset(
                    project.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          _getCategoryIcon(),
                          size: 48,
                          color: AppColors.mutedForeground(context),
                        ),
                      );
                    },
                  )
                : Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.accent(context).withValues(alpha: 0.2),
                          AppColors.accent(context).withValues(alpha: 0.05),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        _getCategoryIcon(),
                        size: 48,
                        color: AppColors.accent(context),
                      ),
                    ),
                  ),
          ),
          const SizedBox(
            height: AppSpacing.md,
          ), // More breathing room after image
          // Title
          Text(
            project.title,
            style: AppTypography.headingSmall(AppColors.foreground(context)),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.xxs),

          // Description
          Expanded(
            child: Text(
              project.description,
              style: AppTypography.bodySmall(
                AppColors.mutedForeground(context),
              ),
              maxLines: 3, // Increased to allow more text if space allows
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: AppSpacing.sm), // Tighter spacing for safety
          // Tech badges
          SizedBox(
            height: 24,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: project.technologies.take(3).length,
              separatorBuilder: (context, index) =>
                  const SizedBox(width: AppSpacing.xs),
              itemBuilder: (context, index) {
                final tech = project.technologies[index];
                return ShadcnBadge(
                  text: tech,
                  variant: ShadcnBadgeVariant.accent,
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.xs),

          // Action buttons
          Row(
            children: [
              if (project.githubUrl != null)
                ShadcnButton(
                  text: 'GitHub',
                  icon: FontAwesomeIcons.github,
                  variant: ShadcnButtonVariant.ghost,
                  size: ShadcnButtonSize.sm,
                  onPressed: () => _launchUrl(project.githubUrl!),
                ),
              if (project.demoUrl != null) ...[
                const SizedBox(width: AppSpacing.sm),
                ShadcnButton(
                  text: 'Demo',
                  icon: FontAwesomeIcons.globe,
                  variant: ShadcnButtonVariant.ghost,
                  size: ShadcnButtonSize.sm,
                  onPressed: () => _launchUrl(project.demoUrl!),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon() {
    switch (project.category) {
      case ProjectCategory.mobile:
        return Icons.phone_android_rounded;
      case ProjectCategory.web:
        return Icons.web_rounded;
      case ProjectCategory.package:
        return Icons.inventory_2_rounded;
    }
  }

  void _showProjectDetails(BuildContext context) {
    showShadcnDialog(
      context: context,
      maxWidth: 600,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShadcnDialogHeader(
            title: project.title,
            description: project.description,
            onClose: () => Navigator.of(context).pop(),
          ),
          ShadcnDialogContent(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Full description
                Text(
                  project.fullDescription ?? project.description,
                  style: AppTypography.bodyMedium(
                    AppColors.mutedForeground(context),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),

                // Technologies
                Text(
                  'Technologies Used',
                  style: AppTypography.label(AppColors.foreground(context)),
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: project.technologies.map((tech) {
                    return ShadcnBadge(
                      text: tech,
                      variant: ShadcnBadgeVariant.accent,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          ShadcnDialogFooter(
            children: [
              if (project.githubUrl != null)
                ShadcnButton(
                  text: 'View on GitHub',
                  icon: Icons.code_rounded,
                  variant: ShadcnButtonVariant.outline,
                  onPressed: () => _launchUrl(project.githubUrl!),
                ),
              if (project.demoUrl != null)
                ShadcnButton(
                  text: 'View Demo',
                  icon: Icons.open_in_new_rounded,
                  variant: ShadcnButtonVariant.primary,
                  onPressed: () => _launchUrl(project.demoUrl!),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
