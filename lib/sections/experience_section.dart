import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_typography.dart';
import '../core/utils/responsive.dart';
import '../data/experience_data.dart';
import '../widgets/cards/shadcn_card.dart';
import '../widgets/badge/shadcn_badge.dart';
import '../widgets/accordion/shadcn_accordion.dart';

/// Experience section with timeline
class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: Responsive.sectionPadding(context),
      color: AppColors.muted(context).withValues(alpha: 0.3),
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
                    'Work Experience',
                    style: AppTypography.headingLarge(
                      AppColors.foreground(context),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'My professional journey and career highlights',
                    style: AppTypography.bodyMedium(
                      AppColors.mutedForeground(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),

              // Experience timeline
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: experienceData.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: AppSpacing.md),
                itemBuilder: (context, index) {
                  final experience = experienceData[index];
                  final isFirst = index == 0;
                  final isLast = index == experienceData.length - 1;

                  return _ExperienceCard(
                    experience: experience,
                    isFirst: isFirst,
                    isLast: isLast,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Individual experience card with timeline indicator
class _ExperienceCard extends StatelessWidget {
  final Experience experience;
  final bool isFirst;
  final bool isLast;

  const _ExperienceCard({
    required this.experience,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline indicator (hidden on mobile)
        if (!isMobile) ...[
          SizedBox(
            width: 60,
            child: Column(
              children: [
                if (!isFirst)
                  Container(
                    width: 2,
                    height: 20,
                    color: AppColors.border(context),
                  ),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: isFirst
                        ? AppColors.accent(context)
                        : AppColors.border(context),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: isFirst
                          ? AppColors.accent(context)
                          : AppColors.border(context),
                      width: 2,
                    ),
                  ),
                ),
                if (!isLast)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Container(
                      width: 2,
                      height: 200, // Approximate height
                      color: AppColors.border(context),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
        ],

        // Experience card
        Expanded(
          child: ShadcnCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Company logo placeholder
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.accent(context).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusMd,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          experience.company[0],
                          style: AppTypography.headingSmall(
                            AppColors.accent(context),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            experience.role,
                            style: AppTypography.headingSmall(
                              AppColors.foreground(context),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xxs),
                          Text(
                            experience.company,
                            style: AppTypography.bodyMedium(
                              AppColors.mutedForeground(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),

                // Duration and location
                Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.xs,
                  children: [
                    _MetaItem(
                      icon: Icons.calendar_today_rounded,
                      text: experience.duration,
                    ),
                    _MetaItem(
                      icon: Icons.location_on_rounded,
                      text: experience.location,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),

                // Description
                Text(
                  experience.description,
                  style: AppTypography.bodyMedium(
                    AppColors.mutedForeground(context),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // Responsibilities accordion
                ShadcnAccordion(
                  items: [
                    ShadcnAccordionItem(
                      title: 'Key Responsibilities & Achievements',
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: experience.responsibilities.map((r) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: AppSpacing.sm,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.check_circle_rounded,
                                  size: 16,
                                  color: AppColors.accent(context),
                                ),
                                const SizedBox(width: AppSpacing.sm),
                                Expanded(
                                  child: Text(
                                    r,
                                    style: AppTypography.bodySmall(
                                      AppColors.mutedForeground(context),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),

                // Technologies
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xs,
                  children: experience.technologies.map((tech) {
                    return ShadcnBadge(
                      text: tech,
                      variant: ShadcnBadgeVariant.accent,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Meta item with icon and text
class _MetaItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _MetaItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.mutedForeground(context)),
        const SizedBox(width: AppSpacing.xs),
        Text(
          text,
          style: AppTypography.caption(AppColors.mutedForeground(context)),
        ),
      ],
    );
  }
}
