import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magambell/src/constants/mg_sizes.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';

class MgCheckbox extends StatefulWidget {
  const MgCheckbox({
    super.key,
    this.initialValue,
    this.onChanged,
    this.size = 20,
    this.borderColor = MgColorScheme.gray7,
    this.checkedColor = MgColorScheme.primary,
    this.uncheckedColor = MgColorScheme.gray11,
    this.borderRadius = MgRadius.xs,
    this.borderWidth = 1,
  });

  final bool? initialValue;
  final Function(bool)? onChanged;
  final double size;
  final Color borderColor;
  final Color checkedColor;
  final Color uncheckedColor;
  final double borderRadius;
  final double borderWidth;

  @override
  State<MgCheckbox> createState() => _MgCheckboxState();
}

class _MgCheckboxState extends State<MgCheckbox> {
  late bool _checked;

  @override
  void initState() {
    super.initState();
    _checked = widget.initialValue ?? false;
  }

  @override
  void didUpdateWidget(MgCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != null && widget.initialValue != _checked) {
      _checked = widget.initialValue!;
    }
  }

  void _handleTap() {
    if (widget.initialValue == null) {
      setState(() => _checked = !_checked);
    }
    widget.onChanged?.call(!_checked);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: _CheckboxContainer(
        checked: _checked,
        size: widget.size,
        borderColor: widget.borderColor,
        checkedColor: widget.checkedColor,
        uncheckedColor: widget.uncheckedColor,
        borderRadius: widget.borderRadius,
        borderWidth: widget.borderWidth,
      ),
    );
  }
}

class _CheckboxContainer extends StatelessWidget {
  const _CheckboxContainer({
    required this.checked,
    required this.size,
    required this.borderColor,
    required this.checkedColor,
    required this.uncheckedColor,
    required this.borderRadius,
    required this.borderWidth,
  });

  final bool checked;
  final double size;
  final Color borderColor;
  final Color checkedColor;
  final Color uncheckedColor;
  final double borderRadius;
  final double borderWidth;

  factory _CheckboxContainer.checked({
    required double size,
    required Color checkedColor,
    required double borderRadius,
  }) {
    return _CheckboxContainer(
      checked: true,
      size: size,
      borderColor: Colors.transparent,
      checkedColor: checkedColor,
      uncheckedColor: Colors.transparent,
      borderRadius: borderRadius,
      borderWidth: 0,
    );
  }

  factory _CheckboxContainer.unchecked({
    required double size,
    required Color borderColor,
    required Color uncheckedColor,
    required double borderRadius,
    required double borderWidth,
  }) {
    return _CheckboxContainer(
      checked: false,
      size: size,
      borderColor: borderColor,
      checkedColor: Colors.transparent,
      uncheckedColor: uncheckedColor,
      borderRadius: borderRadius,
      borderWidth: borderWidth,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: _buildDecoration(),
      child: checked ? BaseSvgIcon.check(color: MgColorScheme.gray11) : null,
    );
  }

  BoxDecoration _buildDecoration() {
    return switch (checked) {
      true => BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: checkedColor,
      ),
      false => BoxDecoration(
        border: Border.all(color: borderColor, width: borderWidth),
        borderRadius: BorderRadius.circular(borderRadius),
        color: uncheckedColor,
      ),
    };
  }
}
