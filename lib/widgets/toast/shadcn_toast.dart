import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

/// Toast variant types
enum ShadcnToastVariant {
  success,
  error,
  warning,
  info,
}

/// A shadcn/ui-inspired toast notification
class ShadcnToast extends StatelessWidget {
  final String message;
  final String? description;
  final ShadcnToastVariant variant;
  final VoidCallback? onDismiss;

  const ShadcnToast({
    super.key,
    required this.message,
    this.description,
    this.variant = ShadcnToastVariant.success,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final colors = _getColors(context);

    return Container(
      constraints: const BoxConstraints(maxWidth: 360),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card(context),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.border(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.xs),
            decoration: BoxDecoration(
              color: colors['background']!.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: Icon(
              colors['icon'] as IconData,
              size: 16,
              color: colors['background'],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  style: AppTypography.bodySmall(AppColors.foreground(context))
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                if (description != null) ...[
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    description!,
                    style: AppTypography.caption(AppColors.mutedForeground(context)),
                  ),
                ],
              ],
            ),
          ),
          if (onDismiss != null)
            GestureDetector(
              onTap: onDismiss,
              child: Icon(
                Icons.close_rounded,
                size: 16,
                color: AppColors.mutedForeground(context),
              ),
            ),
        ],
      ),
    );
  }

  Map<String, dynamic> _getColors(BuildContext context) {
    switch (variant) {
      case ShadcnToastVariant.success:
        return {
          'background': const Color(0xFF22C55E),
          'icon': Icons.check_rounded,
        };
      case ShadcnToastVariant.error:
        return {
          'background': AppColors.destructive(context),
          'icon': Icons.close_rounded,
        };
      case ShadcnToastVariant.warning:
        return {
          'background': const Color(0xFFF59E0B),
          'icon': Icons.warning_rounded,
        };
      case ShadcnToastVariant.info:
        return {
          'background': AppColors.accent(context),
          'icon': Icons.info_rounded,
        };
    }
  }

  /// Shows a toast notification
  static void show(
    BuildContext context, {
    required String message,
    String? description,
    ShadcnToastVariant variant = ShadcnToastVariant.success,
    Duration duration = const Duration(seconds: 4),
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;
    
    entry = OverlayEntry(
      builder: (context) => _AnimatedToast(
        message: message,
        description: description,
        variant: variant,
        onDismiss: () => entry.remove(),
        duration: duration,
      ),
    );

    overlay.insert(entry);
  }
}

/// Animated toast wrapper
class _AnimatedToast extends StatefulWidget {
  final String message;
  final String? description;
  final ShadcnToastVariant variant;
  final VoidCallback onDismiss;
  final Duration duration;

  const _AnimatedToast({
    required this.message,
    this.description,
    required this.variant,
    required this.onDismiss,
    required this.duration,
  });

  @override
  State<_AnimatedToast> createState() => _AnimatedToastState();
}

class _AnimatedToastState extends State<_AnimatedToast>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();

    Future.delayed(widget.duration, () {
      if (mounted) {
        _dismiss();
      }
    });
  }

  void _dismiss() {
    _controller.reverse().then((_) {
      if (mounted) {
        widget.onDismiss();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: AppSpacing.lg,
      right: AppSpacing.lg,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ShadcnToast(
            message: widget.message,
            description: widget.description,
            variant: widget.variant,
            onDismiss: _dismiss,
          ),
        ),
      ),
    );
  }
}
