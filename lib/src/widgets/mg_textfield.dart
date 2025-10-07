import 'package:flutter/material.dart';
import 'package:magambell/src/constants/mg_sizes.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';

class MgTextField extends StatefulWidget {
  const MgTextField({
    super.key,
    this.label,
    this.error,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.hintText,
    this.maxLines = 1,
    this.textInputAction,
    this.inputStyle,
    this.boxDecoration,
  });

  final String? label;
  final String? error;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final String? hintText;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final TextStyle? inputStyle;
  final BoxDecoration? boxDecoration;

  @override
  State<MgTextField> createState() => _MgTextFieldState();
}

class _MgTextFieldState extends State<MgTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  static const double spacingSm = MgSizes.xs;
  static const double spacingMd = MgSizes.sm;
  static const double fontSizeMd = MgSizes.md;
  static const double fontSizeSm = MgSizes.sm;
  static const double borderRadiusMd = MgSizes.size10;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() => _isFocused = _focusNode.hasFocus);
  }

  Color get _borderColor {
    if (!widget.enabled) return Colors.transparent;

    if (widget.error != null && widget.error!.isNotEmpty) {
      return MgColorScheme.subpointRed;
    }
    // TODO: focus 되었을 때 색상 논의
    return _isFocused ? MgColorScheme.primary : MgColorScheme.gray7;
  }

  double get _borderWidth {
    if (widget.error != null && widget.error!.isNotEmpty) {
      return 1.0;
    }
    return _isFocused ? 1.0 : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: spacingMd),
      decoration: widget.boxDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.label != null && widget.label!.isNotEmpty) ...[
            Text(
              widget.label!,
            ).bold().md().padding(left: MgSizes.md, bottom: MgSizes.size10),
          ],

          SizedBox(
            height: 50,
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
              keyboardType: widget.keyboardType,
              obscureText: widget.obscureText,
              enabled: widget.enabled,
              maxLines: widget.maxLines,
              textInputAction: widget.textInputAction,
              style:
                  widget.inputStyle ??
                  const TextStyle(
                    fontSize: fontSizeMd,
                    color: // TextInput
                        MgColorScheme.text,
                  ),
              decoration: InputDecoration(
                hintText: widget.hintText,
                filled: true,
                fillColor: MgColorScheme.gray11,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: spacingMd,
                  vertical: spacingSm,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadiusMd),
                  borderSide: BorderSide(
                    color: _borderColor,
                    width: _borderWidth,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadiusMd),
                  borderSide: BorderSide(
                    color: _borderColor,
                    width: _borderWidth,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadiusMd),
                  borderSide: BorderSide(color: _borderColor, width: 1.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadiusMd),
                  borderSide: const BorderSide(
                    color: MgColorScheme.subpointRed,
                    width: 1.0,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadiusMd),
                  borderSide: const BorderSide(
                    color: MgColorScheme.subpointRed,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),

          // Error Message
          if (widget.error != null && widget.error!.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 4),
              child: Text(
                widget.error!,
                style: const TextStyle(
                  color: MgColorScheme.subpointRed,
                  fontSize: fontSizeSm,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
