import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

/// A shadcn/ui-inspired input field component
class ShadcnInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? placeholder;
  final String? helperText;
  final String? errorText;
  final bool obscureText;
  final TextInputType keyboardType;
  final int maxLines;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;

  const ShadcnInput({
    super.key,
    this.controller,
    this.label,
    this.placeholder,
    this.helperText,
    this.errorText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.enabled = true,
    this.onChanged,
    this.onEditingComplete,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
  });

  @override
  State<ShadcnInput> createState() => _ShadcnInputState();
}

class _ShadcnInputState extends State<ShadcnInput> {
  bool _isFocused = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() => _isFocused = _focusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: AppTypography.label(AppColors.foreground(context)),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        // Input field
        AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(
              color: hasError
                  ? AppColors.destructive(context)
                  : _isFocused
                      ? AppColors.ring(context)
                      : AppColors.border(context),
              width: _isFocused ? 2 : 1,
            ),
            color: widget.enabled
                ? Colors.transparent
                : AppColors.muted(context).withValues(alpha: 0.5),
          ),
          child: Row(
            children: [
              // Prefix icon
              if (widget.prefixIcon != null)
                Padding(
                  padding: const EdgeInsets.only(left: AppSpacing.md),
                  child: Icon(
                    widget.prefixIcon,
                    size: 18,
                    color: AppColors.mutedForeground(context),
                  ),
                ),
              // Text field
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  obscureText: widget.obscureText,
                  keyboardType: widget.keyboardType,
                  maxLines: widget.maxLines,
                  enabled: widget.enabled,
                  onChanged: widget.onChanged,
                  onEditingComplete: widget.onEditingComplete,
                  style: AppTypography.bodyMedium(AppColors.foreground(context)),
                  cursorColor: AppColors.accent(context),
                  decoration: InputDecoration(
                    hintText: widget.placeholder,
                    hintStyle: AppTypography.bodyMedium(
                      AppColors.mutedForeground(context),
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: widget.prefixIcon != null
                          ? AppSpacing.sm
                          : AppSpacing.md,
                      vertical: widget.maxLines > 1
                          ? AppSpacing.md
                          : AppSpacing.sm,
                    ),
                  ),
                ),
              ),
              // Suffix icon
              if (widget.suffixIcon != null)
                Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.md),
                  child: GestureDetector(
                    onTap: widget.onSuffixTap,
                    child: Icon(
                      widget.suffixIcon,
                      size: 18,
                      color: AppColors.mutedForeground(context),
                    ),
                  ),
                ),
            ],
          ),
        ),
        // Helper/Error text
        if (widget.errorText != null || widget.helperText != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            widget.errorText ?? widget.helperText!,
            style: AppTypography.caption(
              hasError
                  ? AppColors.destructive(context)
                  : AppColors.mutedForeground(context),
            ),
          ),
        ],
      ],
    );
  }
}

/// A textarea variant of the input
class ShadcnTextarea extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? placeholder;
  final String? helperText;
  final String? errorText;
  final int minLines;
  final int maxLines;
  final bool enabled;
  final ValueChanged<String>? onChanged;

  const ShadcnTextarea({
    super.key,
    this.controller,
    this.label,
    this.placeholder,
    this.helperText,
    this.errorText,
    this.minLines = 3,
    this.maxLines = 6,
    this.enabled = true,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ShadcnInput(
      controller: controller,
      label: label,
      placeholder: placeholder,
      helperText: helperText,
      errorText: errorText,
      maxLines: maxLines,
      enabled: enabled,
      onChanged: onChanged,
    );
  }
}
