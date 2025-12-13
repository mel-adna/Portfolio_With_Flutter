import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

/// Button variant types inspired by shadcn/ui
enum ShadcnButtonVariant {
  primary,
  secondary,
  outline,
  ghost,
  destructive,
}

/// Button size options
enum ShadcnButtonSize {
  sm,
  md,
  lg,
}

/// A shadcn/ui-inspired button component with multiple variants
class ShadcnButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final ShadcnButtonVariant variant;
  final ShadcnButtonSize size;
  final bool isLoading;
  final IconData? icon;
  final bool iconOnly;

  const ShadcnButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = ShadcnButtonVariant.primary,
    this.size = ShadcnButtonSize.md,
    this.isLoading = false,
    this.icon,
    this.iconOnly = false,
  });

  @override
  State<ShadcnButton> createState() => _ShadcnButtonState();
}

class _ShadcnButtonState extends State<ShadcnButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = _getColors(context);
    final height = _getHeight();
    final padding = _getPadding();

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.onPressed != null && !widget.isLoading
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.isLoading ? null : widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: _getBackgroundColor(colors),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: widget.variant == ShadcnButtonVariant.outline
                ? Border.all(color: AppColors.border(context))
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.isLoading) ...[
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(colors['foreground']!),
                  ),
                ),
                if (!widget.iconOnly) const SizedBox(width: AppSpacing.sm),
              ] else if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  size: _getIconSize(),
                  color: colors['foreground'],
                ),
                if (!widget.iconOnly) const SizedBox(width: AppSpacing.sm),
              ],
              if (!widget.iconOnly)
                Text(
                  widget.text,
                  style: AppTypography.button(colors['foreground']!),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, Color> _getColors(BuildContext context) {
    switch (widget.variant) {
      case ShadcnButtonVariant.primary:
        return {
          'background': AppColors.primary(context),
          'foreground': AppColors.primaryForeground(context),
          'hover': AppColors.primary(context).withValues(alpha: 0.9),
        };
      case ShadcnButtonVariant.secondary:
        return {
          'background': AppColors.secondary(context),
          'foreground': AppColors.secondaryForeground(context),
          'hover': AppColors.secondary(context).withValues(alpha: 0.8),
        };
      case ShadcnButtonVariant.outline:
        return {
          'background': Colors.transparent,
          'foreground': AppColors.foreground(context),
          'hover': AppColors.muted(context),
        };
      case ShadcnButtonVariant.ghost:
        return {
          'background': Colors.transparent,
          'foreground': AppColors.foreground(context),
          'hover': AppColors.muted(context),
        };
      case ShadcnButtonVariant.destructive:
        return {
          'background': AppColors.destructive(context),
          'foreground': AppColors.destructiveForeground(context),
          'hover': AppColors.destructive(context).withValues(alpha: 0.9),
        };
    }
  }

  Color _getBackgroundColor(Map<String, Color> colors) {
    if (widget.onPressed == null) {
      return colors['background']!.withValues(alpha: 0.5);
    }
    return _isHovered ? colors['hover']! : colors['background']!;
  }

  double _getHeight() {
    switch (widget.size) {
      case ShadcnButtonSize.sm:
        return AppSpacing.buttonHeightSm;
      case ShadcnButtonSize.md:
        return AppSpacing.buttonHeight;
      case ShadcnButtonSize.lg:
        return AppSpacing.buttonHeightLg;
    }
  }

  EdgeInsets _getPadding() {
    if (widget.iconOnly) {
      return EdgeInsets.all(_getHeight() / 4);
    }
    switch (widget.size) {
      case ShadcnButtonSize.sm:
        return const EdgeInsets.symmetric(horizontal: AppSpacing.sm);
      case ShadcnButtonSize.md:
        return const EdgeInsets.symmetric(horizontal: AppSpacing.md);
      case ShadcnButtonSize.lg:
        return const EdgeInsets.symmetric(horizontal: AppSpacing.lg);
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case ShadcnButtonSize.sm:
        return AppSpacing.iconSizeSm;
      case ShadcnButtonSize.md:
        return AppSpacing.iconSizeMd;
      case ShadcnButtonSize.lg:
        return AppSpacing.iconSizeLg;
    }
  }
}
