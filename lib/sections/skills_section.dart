import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_typography.dart';
import '../core/utils/responsive.dart';
import '../data/skills_data.dart';
import '../widgets/cards/shadcn_card.dart';
import '../widgets/badge/shadcn_badge.dart';

/// Skills & Expertise section
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

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
                    'Skills & Expertise',
                    style: AppTypography.headingLarge(
                      AppColors.foreground(context),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Technologies and tools I work with daily',
                    style: AppTypography.bodyMedium(
                      AppColors.mutedForeground(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),

              // Skills grid
              LayoutBuilder(
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
                        mobile: 200, // Fixed height for mobile
                        tablet: 220, // Fixed height for tablet
                        desktop: 240, // Fixed height for desktop
                      ),
                    ),
                    itemCount: skillsData.length,
                    itemBuilder: (context, index) {
                      final category = skillsData[index];
                      return _SkillCategoryCard(category: category);
                    },
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

/// Individual skill category card
class _SkillCategoryCard extends StatelessWidget {
  final SkillCategory category;

  const _SkillCategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return ShadcnCard(
      hoverable: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.accent(context).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                child: Icon(
                  category.icon,
                  size: 20,
                  color: AppColors.accent(context),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.name,
                      style: AppTypography.bodyMedium(
                        AppColors.foreground(context),
                      ).copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      category.description,
                      style: AppTypography.caption(
                        AppColors.mutedForeground(context),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // Skills badges
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: category.skills.map((skill) {
                  return ShadcnBadge(
                    text: skill.name,
                    variant: ShadcnBadgeVariant.secondary,
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
