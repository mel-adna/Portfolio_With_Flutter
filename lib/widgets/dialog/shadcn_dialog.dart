import 'package:flutter/material.dart';
import 'dart:ui';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

/// Shows a shadcn/ui-inspired modal dialog
Future<T?> showShadcnDialog<T>({
  required BuildContext context,
  required Widget child,
  bool barrierDismissible = true,
  double? maxWidth,
}) {
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: 'Dismiss',
    barrierColor: Colors.black.withValues(alpha: 0.5),
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, animation, secondaryAnimation) {
      return ShadcnDialog(
        maxWidth: maxWidth,
        child: child,
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      );
      return FadeTransition(
        opacity: curvedAnimation,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.95, end: 1.0).animate(curvedAnimation),
          child: child,
        ),
      );
    },
  );
}

/// A shadcn/ui-inspired dialog component
class ShadcnDialog extends StatelessWidget {
  final Widget child;
  final double? maxWidth;

  const ShadcnDialog({
    super.key,
    required this.child,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Material(
          color: Colors.transparent,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: maxWidth ?? 500,
              maxHeight: MediaQuery.of(context).size.height * 0.9,
            ),
            margin: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.card(context),
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              border: Border.all(color: AppColors.border(context)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

/// Dialog header component
class ShadcnDialogHeader extends StatelessWidget {
  final String title;
  final String? description;
  final VoidCallback? onClose;

  const ShadcnDialogHeader({
    super.key,
    required this.title,
    this.description,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTypography.headingSmall(AppColors.foreground(context)),
                ),
              ),
              if (onClose != null)
                _CloseButton(onTap: onClose!),
            ],
          ),
          if (description != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              description!,
              style: AppTypography.bodySmall(AppColors.mutedForeground(context)),
            ),
          ],
        ],
      ),
    );
  }
}

/// Dialog content component
class ShadcnDialogContent extends StatelessWidget {
  final Widget child;

  const ShadcnDialogContent({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: child,
    );
  }
}

/// Dialog footer component
class ShadcnDialogFooter extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;

  const ShadcnDialogFooter({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.end,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: children
            .map((child) => Padding(
                  padding: const EdgeInsets.only(left: AppSpacing.sm),
                  child: child,
                ))
            .toList(),
      ),
    );
  }
}

/// Close button for dialogs
class _CloseButton extends StatefulWidget {
  final VoidCallback onTap;

  const _CloseButton({required this.onTap});

  @override
  State<_CloseButton> createState() => _CloseButtonState();
}

class _CloseButtonState extends State<_CloseButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(AppSpacing.xs),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.muted(context) : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          ),
          child: Icon(
            Icons.close_rounded,
            size: 18,
            color: AppColors.mutedForeground(context),
          ),
        ),
      ),
    );
  }
}
