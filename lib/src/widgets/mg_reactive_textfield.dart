import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magambell/src/widgets/mg_textfield.dart';
import 'package:reactive_forms/reactive_forms.dart';

class MgReactiveTextField extends ReactiveFormField<String, String> {
  MgReactiveTextField({
    super.key,
    super.formControlName,
    this.hintText,
    this.obscureText = false,
    this.enabled = true,
    this.keyboardType,
    this.maxLines = 1,
    this.textInputAction,
    this.inputStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.onSubmitted,
  }) : super(
         builder: (ReactiveFormFieldState<String, String> field) {
           final state = field as _MgReactiveTextFieldState;

           return MgTextField(
             controller: state._textEditingController,
             focusNode: state._focusNode,
             hintText: hintText,
             obscureText: obscureText,
             enabled: enabled,
             keyboardType: keyboardType,
             maxLines: maxLines,
             textInputAction: textInputAction,
             inputStyle: inputStyle,
             prefixIcon: prefixIcon,
             suffixIcon: suffixIcon,
             onSubmitted: onSubmitted,
           );
         },
       );

  final String? hintText;
  final bool obscureText;
  final bool enabled;
  final TextInputType? keyboardType;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final TextStyle? inputStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onSubmitted;

  @override
  ReactiveFormFieldState<String, String> createState() =>
      _MgReactiveTextFieldState();
}

class _MgReactiveTextFieldState extends ReactiveFormFieldState<String, String> {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
    _textEditingController = TextEditingController(text: value ?? '');
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void onControlValueChanged(dynamic value) {
    final effectiveValue = value ?? '';
    if (_textEditingController.text != effectiveValue) {
      _textEditingController.value = _textEditingController.value.copyWith(
        text: effectiveValue,
        selection: TextSelection.collapsed(offset: effectiveValue.length),
      );
    }
    super.onControlValueChanged(value);
  }

  void _onFocusChange() {
    setState(() => _isFocused = _focusNode.hasFocus);
  }

  @override
  ControlValueAccessor<String, String> selectValueAccessor() {
    return _TextEditingControllerValueAccessor(_textEditingController);
  }
}

class _TextEditingControllerValueAccessor
    extends ControlValueAccessor<String, String> {
  _TextEditingControllerValueAccessor(this._textEditingController) {
    _textEditingController.addListener(_onTextChanged);
  }

  final TextEditingController _textEditingController;

  void _onTextChanged() {
    if (control?.value != _textEditingController.text) {
      control?.updateValue(_textEditingController.text);
    }
  }

  @override
  String? modelToViewValue(String? modelValue) => modelValue;

  @override
  String? viewToModelValue(String? viewValue) => viewValue;

  @override
  void dispose() {
    _textEditingController.removeListener(_onTextChanged);
    super.dispose();
  }
}
