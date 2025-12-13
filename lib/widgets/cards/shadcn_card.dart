import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

/// A shadcn/ui-inspired card component with subtle elevation and border
class ShadcnCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final bool hoverable;
  final double? width;
  final double? height;

  const ShadcnCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.hoverable = false,
    this.width,
    this.height,
  });

  @override
  State<ShadcnCard> createState() => _ShadcnCardState();
}

class _ShadcnCardState extends State<ShadcnCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: widget.hoverable ? (_) => setState(() => _isHovered = true) : null,
      onExit: widget.hoverable ? (_) => setState(() => _isHovered = false) : null,
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.width,
          height: widget.height,
          padding: widget.padding ?? const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.card(context),
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            border: Border.all(
              color: _isHovered
                  ? AppColors.accent(context).withValues(alpha: 0.5)
                  : AppColors.border(context),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: _isHovered ? 0.08 : 0.04),
                blurRadius: _isHovered ? 8 : 4,
                offset: Offset(0, _isHovered ? 4 : 2),
              ),
            ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

/// Card header component
class ShadcnCardHeader extends StatelessWidget {
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;

  const ShadcnCardHeader({
    super.key,
    this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null) title!,
              if (subtitle != null) ...[
                const SizedBox(height: AppSpacing.xs),
                subtitle!,
              ],
            ],
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

/// Card content component
class ShadcnCardContent extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const ShadcnCardContent({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(top: AppSpacing.md),
      child: child,
    );
  }
}

/// Card footer component
class ShadcnCardFooter extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;

  const ShadcnCardFooter({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: children,
      ),
    );
  }
}
