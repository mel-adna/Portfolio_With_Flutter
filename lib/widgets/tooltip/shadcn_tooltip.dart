import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

/// A shadcn/ui-inspired tooltip component
class ShadcnTooltip extends StatefulWidget {
  final Widget child;
  final String message;
  final TooltipPosition position;

  const ShadcnTooltip({
    super.key,
    required this.child,
    required this.message,
    this.position = TooltipPosition.top,
  });

  @override
  State<ShadcnTooltip> createState() => _ShadcnTooltipState();
}

class _ShadcnTooltipState extends State<ShadcnTooltip> {
  final OverlayPortalController _controller = OverlayPortalController();
  final LayerLink _layerLink = LayerLink();

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: OverlayPortal(
        controller: _controller,
        overlayChildBuilder: (context) {
          return CompositedTransformFollower(
            link: _layerLink,
            targetAnchor: _getTargetAnchor(),
            followerAnchor: _getFollowerAnchor(),
            offset: _getOffset(),
            child: TapRegion(
              onTapOutside: (_) => _controller.hide(),
              child: _TooltipContent(message: widget.message),
            ),
          );
        },
        child: MouseRegion(
          onEnter: (_) => _controller.show(),
          onExit: (_) => _controller.hide(),
          child: widget.child,
        ),
      ),
    );
  }

  Alignment _getTargetAnchor() {
    switch (widget.position) {
      case TooltipPosition.top:
        return Alignment.topCenter;
      case TooltipPosition.bottom:
        return Alignment.bottomCenter;
      case TooltipPosition.left:
        return Alignment.centerLeft;
      case TooltipPosition.right:
        return Alignment.centerRight;
    }
  }

  Alignment _getFollowerAnchor() {
    switch (widget.position) {
      case TooltipPosition.top:
        return Alignment.bottomCenter;
      case TooltipPosition.bottom:
        return Alignment.topCenter;
      case TooltipPosition.left:
        return Alignment.centerRight;
      case TooltipPosition.right:
        return Alignment.centerLeft;
    }
  }

  Offset _getOffset() {
    switch (widget.position) {
      case TooltipPosition.top:
        return const Offset(0, -8);
      case TooltipPosition.bottom:
        return const Offset(0, 8);
      case TooltipPosition.left:
        return const Offset(-8, 0);
      case TooltipPosition.right:
        return const Offset(8, 0);
    }
  }
}

/// Tooltip content widget
class _TooltipContent extends StatelessWidget {
  final String message;

  const _TooltipContent({required this.message});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: AppColors.foreground(context),
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          message,
          style: AppTypography.caption(AppColors.background(context)),
        ),
      ),
    );
  }
}

/// Tooltip position options
enum TooltipPosition {
  top,
  bottom,
  left,
  right,
}
