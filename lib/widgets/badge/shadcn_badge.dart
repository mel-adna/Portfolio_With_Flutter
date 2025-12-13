import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

/// Badge variant types
enum ShadcnBadgeVariant {
  primary,
  secondary,
  outline,
  accent,
}

/// A shadcn/ui-inspired badge component for tech stack tags
class ShadcnBadge extends StatelessWidget {
  final String text;
  final ShadcnBadgeVariant variant;
  final IconData? icon;

  const ShadcnBadge({
    super.key,
    required this.text,
    this.variant = ShadcnBadgeVariant.secondary,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = _getColors(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: colors['background'],
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        border: variant == ShadcnBadgeVariant.outline
            ? Border.all(color: AppColors.border(context))
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 12,
              color: colors['foreground'],
            ),
            const SizedBox(width: AppSpacing.xs),
          ],
          Text(
            text,
            style: AppTypography.caption(colors['foreground']!),
          ),
        ],
      ),
    );
  }

  Map<String, Color> _getColors(BuildContext context) {
    switch (variant) {
      case ShadcnBadgeVariant.primary:
        return {
          'background': AppColors.primary(context),
          'foreground': AppColors.primaryForeground(context),
        };
      case ShadcnBadgeVariant.secondary:
        return {
          'background': AppColors.muted(context),
          'foreground': AppColors.mutedForeground(context),
        };
      case ShadcnBadgeVariant.outline:
        return {
          'background': Colors.transparent,
          'foreground': AppColors.foreground(context),
        };
      case ShadcnBadgeVariant.accent:
        return {
          'background': AppColors.accent(context).withValues(alpha: 0.15),
          'foreground': AppColors.accent(context),
        };
    }
  }
}

/// A container for multiple badges with wrap layout
class ShadcnBadgeGroup extends StatelessWidget {
  final List<String> badges;
  final ShadcnBadgeVariant variant;
  final double spacing;

  const ShadcnBadgeGroup({
    super.key,
    required this.badges,
    this.variant = ShadcnBadgeVariant.secondary,
    this.spacing = AppSpacing.sm,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: badges
          .map((badge) => ShadcnBadge(text: badge, variant: variant))
          .toList(),
    );
  }
}
