import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_typography.dart';
import '../core/utils/responsive.dart';
import '../widgets/cards/shadcn_card.dart';

/// About Me section
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

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
              _SectionHeader(
                title: 'About Me',
                subtitle: 'Get to know my background and what drives me',
              ),
              const SizedBox(height: AppSpacing.xl),

              // Content
              ResponsiveBuilder(
                mobile: _MobileLayout(),
                desktop: _DesktopLayout(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ProfileImage(),
        const SizedBox(height: AppSpacing.xl),
        _AboutContent(),
      ],
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Profile image on the left - larger on desktop
        _ProfileImage(),
        const SizedBox(width: AppSpacing.xxl),
        // About content takes most space
        Expanded(flex: 3, child: _AboutContent()),
        const SizedBox(width: AppSpacing.xl),
        // Stats on the right - compact
        SizedBox(width: 180, child: _StatsCard()),
      ],
    );
  }
}

class _ProfileImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = Responsive.value(
      context,
      mobile: 180.0,
      tablet: 240.0,
      desktop: 300.0,
    );

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        border: Border.all(
          color: AppColors.accent(context).withValues(alpha: 0.3),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent(context).withValues(alpha: 0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.radiusXl - 2),
        child: Image.asset(
          'assets/images/profile.png',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // Fallback if image fails to load
            return Container(
              color: AppColors.accent(context).withValues(alpha: 0.1),
              child: Center(
                child: Text(
                  'ME',
                  style: AppTypography.displayMedium(AppColors.accent(context)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AboutContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShadcnCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello, I\'m Mohamed!',
            style: AppTypography.headingMedium(AppColors.foreground(context)),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            '''I'm a Flutter Developer from Morocco, passionate about building beautiful and functional mobile applications. I specialize in creating cross-platform apps using Flutter and Dart, with a strong focus on clean code and great user experiences.

My main stack includes Flutter, Dart, and Firebase. I enjoy turning ideas into reality through well-crafted mobile applications that users love to use.

I'm constantly learning and improving my skills, staying up-to-date with the latest Flutter developments and best practices. I believe in writing clean, maintainable code and following established architectural patterns.

I'm currently open to new opportunities and excited to work on challenging projects that push my skills further.''',
            style: AppTypography.bodyMedium(AppColors.mutedForeground(context)),
          ),
          const SizedBox(height: AppSpacing.lg),
          _HighlightRow(),
        ],
      ),
    );
  }
}

class _HighlightRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.xl,
      runSpacing: AppSpacing.md,
      children: const [
        _Highlight(icon: Icons.location_on_rounded, label: 'Based in Morocco'),
        _Highlight(
          icon: Icons.code_rounded,
          label: 'Flutter • Dart • Firebase',
        ),
        _Highlight(icon: Icons.work_rounded, label: 'Open to Work'),
      ],
    );
  }
}

class _Highlight extends StatelessWidget {
  final IconData icon;
  final String label;

  const _Highlight({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: AppColors.accent(context)),
        const SizedBox(width: AppSpacing.sm),
        Text(
          label,
          style: AppTypography.bodySmall(
            AppColors.foreground(context),
          ).copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class _StatsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShadcnCard(
      child: Column(
        children: const [
          _StatItem(value: 'Flutter', label: 'Primary Framework'),
          SizedBox(height: AppSpacing.lg),
          _StatItem(value: 'Dart', label: 'Main Language'),
          SizedBox(height: AppSpacing.lg),
          _StatItem(value: 'Firebase', label: 'Backend Service'),
          SizedBox(height: AppSpacing.lg),
          _StatItem(value: 'Morocco', label: 'Location'),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.headingSmall(AppColors.accent(context)),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: AppTypography.caption(AppColors.mutedForeground(context)),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;

  const _SectionHeader({required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.headingLarge(AppColors.foreground(context)),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(
            subtitle!,
            style: AppTypography.bodyMedium(AppColors.mutedForeground(context)),
          ),
        ],
      ],
    );
  }
}
