import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_typography.dart';
import '../core/utils/responsive.dart';
import '../widgets/buttons/shadcn_button.dart';

/// Hero section - the first impression
class HeroSection extends StatelessWidget {
  final VoidCallback? onViewProjects;
  final VoidCallback? onContact;

  const HeroSection({
    super.key,
    this.onViewProjects,
    this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.value(context, mobile: 24, tablet: 48, desktop: 64),
        vertical: Responsive.value(context, mobile: 64, tablet: 96, desktop: 120),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Status badge
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: AppColors.accent(context).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
              border: Border.all(
                color: AppColors.accent(context).withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: const Color(0xFF22C55E),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'Open to opportunities',
                  style: AppTypography.caption(AppColors.accent(context)),
                ),
              ],
            ),
          ),
          SizedBox(height: Responsive.value(context, mobile: 24, tablet: 32, desktop: 40)),
          
          // Name
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Text(
              'Mohamed Eladnani',
              style: Responsive.value(
                context,
                mobile: AppTypography.displaySmall(AppColors.foreground(context)),
                tablet: AppTypography.displayMedium(AppColors.foreground(context)),
                desktop: AppTypography.displayLarge(AppColors.foreground(context)),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          
          // Title
          Text(
            'Flutter Developer',
            style: AppTypography.headingMedium(AppColors.accent(context)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          
          // Subheading
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              'Building beautiful, performant, and scalable mobile applications with Flutter. Based in Morocco, passionate about creating exceptional user experiences.',
              style: AppTypography.bodyLarge(AppColors.mutedForeground(context)),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: Responsive.value(context, mobile: 32, tablet: 40, desktop: 48)),
          
          // CTA Buttons
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            alignment: WrapAlignment.center,
            children: [
              ShadcnButton(
                text: 'View Projects',
                icon: Icons.arrow_forward_rounded,
                variant: ShadcnButtonVariant.primary,
                size: isMobile ? ShadcnButtonSize.md : ShadcnButtonSize.lg,
                onPressed: onViewProjects,
              ),
              ShadcnButton(
                text: 'Contact Me',
                icon: Icons.mail_outline_rounded,
                variant: ShadcnButtonVariant.outline,
                size: isMobile ? ShadcnButtonSize.md : ShadcnButtonSize.lg,
                onPressed: onContact,
              ),
            ],
          ),
          SizedBox(height: Responsive.value(context, mobile: 48, tablet: 64, desktop: 80)),
          
          // Tech stack badges
          _TechStackRow(),
        ],
      ),
    );
  }
}

/// Tech stack row with icons
class _TechStackRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'TECH STACK',
          style: AppTypography.overline(AppColors.mutedForeground(context)),
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.lg,
          runSpacing: AppSpacing.md,
          alignment: WrapAlignment.center,
          children: [
            _TechIcon(label: 'Flutter'),
            _TechIcon(label: 'Dart'),
            _TechIcon(label: 'Firebase'),
          ],
        ),
      ],
    );
  }
}

/// Individual tech icon/label
class _TechIcon extends StatefulWidget {
  final String label;

  const _TechIcon({required this.label});

  @override
  State<_TechIcon> createState() => _TechIconState();
}

class _TechIconState extends State<_TechIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: _isHovered
              ? AppColors.muted(context)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(
            color: _isHovered
                ? AppColors.border(context)
                : Colors.transparent,
          ),
        ),
        child: Text(
          widget.label,
          style: AppTypography.bodySmall(
            _isHovered
                ? AppColors.foreground(context)
                : AppColors.mutedForeground(context),
          ),
        ),
      ),
    );
  }
}
