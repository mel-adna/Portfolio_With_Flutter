import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

/// A shadcn/ui-inspired accordion component
class ShadcnAccordion extends StatefulWidget {
  final List<ShadcnAccordionItem> items;
  final bool allowMultiple;

  const ShadcnAccordion({
    super.key,
    required this.items,
    this.allowMultiple = false,
  });

  @override
  State<ShadcnAccordion> createState() => _ShadcnAccordionState();
}

class _ShadcnAccordionState extends State<ShadcnAccordion> {
  final Set<int> _expandedIndices = {};

  void _toggleItem(int index) {
    setState(() {
      if (_expandedIndices.contains(index)) {
        _expandedIndices.remove(index);
      } else {
        if (!widget.allowMultiple) {
          _expandedIndices.clear();
        }
        _expandedIndices.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final isExpanded = _expandedIndices.contains(index);
        final isLast = index == widget.items.length - 1;

        return _AccordionItem(
          title: item.title,
          content: item.content,
          isExpanded: isExpanded,
          isLast: isLast,
          onTap: () => _toggleItem(index),
        );
      }).toList(),
    );
  }
}

/// Individual accordion item widget
class _AccordionItem extends StatefulWidget {
  final String title;
  final Widget content;
  final bool isExpanded;
  final bool isLast;
  final VoidCallback onTap;

  const _AccordionItem({
    required this.title,
    required this.content,
    required this.isExpanded,
    required this.isLast,
    required this.onTap,
  });

  @override
  State<_AccordionItem> createState() => _AccordionItemState();
}

class _AccordionItemState extends State<_AccordionItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _expandAnimation;
  late Animation<double> _rotationAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    if (widget.isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(_AccordionItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      if (widget.isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: widget.onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              decoration: BoxDecoration(
                color: _isHovered
                    ? AppColors.muted(context).withValues(alpha: 0.5)
                    : Colors.transparent,
                border: Border(
                  bottom: widget.isLast && !widget.isExpanded
                      ? BorderSide.none
                      : BorderSide(color: AppColors.border(context)),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: AppTypography.bodyMedium(
                        AppColors.foreground(context),
                      ).copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                  RotationTransition(
                    turns: _rotationAnimation,
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 20,
                      color: AppColors.mutedForeground(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Content
        SizeTransition(
          sizeFactor: _expandAnimation,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            decoration: BoxDecoration(
              border: Border(
                bottom: widget.isLast
                    ? BorderSide.none
                    : BorderSide(color: AppColors.border(context)),
              ),
            ),
            child: widget.content,
          ),
        ),
      ],
    );
  }
}

/// Accordion item data model
class ShadcnAccordionItem {
  final String title;
  final Widget content;

  const ShadcnAccordionItem({
    required this.title,
    required this.content,
  });
}
