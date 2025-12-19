import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_typography.dart';
import '../core/utils/responsive.dart';
import '../sections/hero_section.dart';
import '../sections/about_section.dart';
import '../sections/skills_section.dart';
import '../sections/projects_section.dart';
import '../sections/experience_section.dart';
import '../sections/contact_section.dart';

/// Main home page containing all portfolio sections
class HomePage extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const HomePage({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  // Section keys for scrolling
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToAbout() => _scrollToKey(_aboutKey);
  void _scrollToSkills() => _scrollToKey(_skillsKey);
  void _scrollToProjects() => _scrollToKey(_projectsKey);
  void _scrollToExperience() => _scrollToKey(_experienceKey);
  void _scrollToContact() => _scrollToKey(_contactKey);

  void _scrollToKey(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // Navigation bar
          SliverToBoxAdapter(
            child: _NavigationBar(
              onThemeToggle: widget.onThemeToggle,
              isDarkMode: widget.isDarkMode,
              onAbout: _scrollToAbout,
              onSkills: _scrollToSkills,
              onProjects: _scrollToProjects,
              onExperience: _scrollToExperience,
              onContact: _scrollToContact,
            ),
          ),

          // Hero section
          SliverToBoxAdapter(
            child: HeroSection(
              onViewProjects: _scrollToProjects,
              onContact: _scrollToContact,
            ),
          ),

          // About section
          SliverToBoxAdapter(
            child: Container(key: _aboutKey, child: const AboutSection()),
          ),

          // Spacing
          SliverToBoxAdapter(
            child: SizedBox(
              height: Responsive.value(
                context,
                mobile: AppSpacing.sectionVerticalSpacingMobile,
                desktop: AppSpacing.sectionVerticalSpacing,
              ),
            ),
          ),

          // Skills section
          SliverToBoxAdapter(
            child: Container(key: _skillsKey, child: const SkillsSection()),
          ),

          // Spacing
          SliverToBoxAdapter(
            child: SizedBox(
              height: Responsive.value(
                context,
                mobile: AppSpacing.sectionVerticalSpacingMobile,
                desktop: AppSpacing.sectionVerticalSpacing,
              ),
            ),
          ),

          // Projects section
          SliverToBoxAdapter(
            child: Container(key: _projectsKey, child: const ProjectsSection()),
          ),

          // Spacing
          SliverToBoxAdapter(
            child: SizedBox(
              height: Responsive.value(
                context,
                mobile: AppSpacing.sectionVerticalSpacingMobile,
                desktop: AppSpacing.sectionVerticalSpacing,
              ),
            ),
          ),

          // Experience section
          SliverToBoxAdapter(
            child: Container(
              key: _experienceKey,
              child: const ExperienceSection(),
            ),
          ),

          // Spacing
          SliverToBoxAdapter(
            child: SizedBox(
              height: Responsive.value(
                context,
                mobile: AppSpacing.sectionVerticalSpacingMobile,
                desktop: AppSpacing.sectionVerticalSpacing,
              ),
            ),
          ),

          // Contact section
          SliverToBoxAdapter(
            child: Container(key: _contactKey, child: const ContactSection()),
          ),

          // Footer
          const SliverToBoxAdapter(child: _Footer()),
        ],
      ),
    );
  }
}

/// Navigation bar
class _NavigationBar extends StatelessWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;
  final VoidCallback? onAbout;
  final VoidCallback? onSkills;
  final VoidCallback? onProjects;
  final VoidCallback? onExperience;
  final VoidCallback? onContact;

  const _NavigationBar({
    required this.onThemeToggle,
    required this.isDarkMode,
    this.onAbout,
    this.onSkills,
    this.onProjects,
    this.onExperience,
    this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.value(
          context,
          mobile: 16,
          tablet: 32,
          desktop: 64,
        ),
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.background(context).withValues(alpha: 0.8),
        border: Border(
          bottom: BorderSide(color: AppColors.border(context), width: 1),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: Responsive.contentMaxWidth(context),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.accent(context),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    ),
                    child: Center(
                      child: Text(
                        'M',
                        style: AppTypography.bodyMedium(
                          Colors.white,
                        ).copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  if (Responsive.isDesktop(context)) ...[
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      'Mohamed Eladnani',
                      style: AppTypography.bodyMedium(
                        AppColors.foreground(context),
                      ).copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ],
              ),

              // Navigation links (desktop and tablet)
              if (!isMobile)
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _NavLink(text: 'About', onTap: onAbout ?? () {}),
                          _NavLink(text: 'Skills', onTap: onSkills ?? () {}),
                          _NavLink(
                            text: 'Projects',
                            onTap: onProjects ?? () {},
                          ),
                          _NavLink(
                            text: 'Experience',
                            onTap: onExperience ?? () {},
                          ),
                          _NavLink(text: 'Contact', onTap: onContact ?? () {}),
                        ],
                      ),
                    ),
                  ),
                ),

              // Theme toggle
              _ThemeToggle(isDarkMode: isDarkMode, onToggle: onThemeToggle),
            ],
          ),
        ),
      ),
    );
  }
}

/// Navigation link
class _NavLink extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const _NavLink({required this.text, required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.value(
              context,
              mobile: 8,
              tablet: 8,
              desktop: 16,
            ),
          ),
          child: Text(
            widget.text,
            style: AppTypography.bodySmall(
              _isHovered
                  ? AppColors.foreground(context)
                  : AppColors.mutedForeground(context),
            ),
          ),
        ),
      ),
    );
  }
}

/// Theme toggle button
class _ThemeToggle extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggle;

  const _ThemeToggle({required this.isDarkMode, required this.onToggle});

  @override
  State<_ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<_ThemeToggle> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onToggle,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.muted(context) : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(color: AppColors.border(context)),
          ),
          child: Icon(
            widget.isDarkMode
                ? Icons.light_mode_rounded
                : Icons.dark_mode_rounded,
            size: 18,
            color: AppColors.foreground(context),
          ),
        ),
      ),
    );
  }
}

/// Footer section
class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.value(
          context,
          mobile: 24,
          tablet: 48,
          desktop: 64,
        ),
        vertical: AppSpacing.xl,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.border(context), width: 1),
        ),
      ),
      child: Center(
        child: Column(
          children: [
            Text(
              'Built with Flutter & ❤️',
              style: AppTypography.bodySmall(
                AppColors.mutedForeground(context),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '© ${DateTime.now().year} Portfolio. All rights reserved.',
              style: AppTypography.caption(AppColors.mutedForeground(context)),
            ),
          ],
        ),
      ),
    );
  }
}
