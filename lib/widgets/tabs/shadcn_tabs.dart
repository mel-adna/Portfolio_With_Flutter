import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

/// A shadcn/ui-inspired tabs component
class ShadcnTabs extends StatefulWidget {
  final List<ShadcnTab> tabs;
  final int initialIndex;
  final ValueChanged<int>? onTabChanged;

  const ShadcnTabs({
    super.key,
    required this.tabs,
    this.initialIndex = 0,
    this.onTabChanged,
  });

  @override
  State<ShadcnTabs> createState() => _ShadcnTabsState();
}

class _ShadcnTabsState extends State<ShadcnTabs> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tab bar
        Container(
          decoration: BoxDecoration(
            color: AppColors.muted(context),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          padding: const EdgeInsets.all(AppSpacing.xs),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: widget.tabs.asMap().entries.map((entry) {
              final index = entry.key;
              final tab = entry.value;
              final isSelected = index == _selectedIndex;

              return _TabItem(
                label: tab.label,
                icon: tab.icon,
                isSelected: isSelected,
                onTap: () {
                  setState(() => _selectedIndex = index);
                  widget.onTabChanged?.call(index);
                },
              );
            }).toList(),
          ),
        ),
        // Tab content
        const SizedBox(height: AppSpacing.lg),
        widget.tabs[_selectedIndex].content,
      ],
    );
  }
}

/// Individual tab item
class _TabItem extends StatefulWidget {
  final String label;
  final IconData? icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabItem({
    required this.label,
    this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_TabItem> createState() => _TabItemState();
}

class _TabItemState extends State<_TabItem> {
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
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? AppColors.background(context)
                : _isHovered
                    ? AppColors.background(context).withValues(alpha: 0.5)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            boxShadow: widget.isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  size: 16,
                  color: widget.isSelected
                      ? AppColors.foreground(context)
                      : AppColors.mutedForeground(context),
                ),
                const SizedBox(width: AppSpacing.xs),
              ],
              Text(
                widget.label,
                style: AppTypography.button(
                  widget.isSelected
                      ? AppColors.foreground(context)
                      : AppColors.mutedForeground(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Tab data model
class ShadcnTab {
  final String label;
  final IconData? icon;
  final Widget content;

  const ShadcnTab({
    required this.label,
    this.icon,
    required this.content,
  });
}
