import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magambell/src/widgets/mg_textfield.dart';
import 'package:reactive_forms/reactive_forms.dart';

class MgReactiveTextField<T> extends ReactiveFormField<T, T> {
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
         builder: (ReactiveFormFieldState<T, T> field) {
           final state = field as _MgReactiveTextFieldState<T>;

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
             prefixIcon: prefixIcon ?? SizedBox.shrink(),
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
  ReactiveFormFieldState<T, T> createState() =>
      _MgReactiveTextFieldState<T>();
}

class _MgReactiveTextFieldState<T> extends ReactiveFormFieldState<T, T> {
  final TextEditingController _textEditingController = TextEditingController();
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
    _textEditingController.text = _valueToString(value);
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
    final effectiveValue = _valueToString(value);
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

  String _valueToString(T? value) {
    if (value == null) return '';
    return value.toString();
  }

  @override
  ControlValueAccessor<T, T> selectValueAccessor() {
    return _TextEditingControllerValueAccessor<T>(_textEditingController);
  }
}

class _TextEditingControllerValueAccessor<T>
    extends ControlValueAccessor<T, T> {
  _TextEditingControllerValueAccessor(this._textEditingController) {
    _textEditingController.addListener(_onTextChanged);
  }

  final TextEditingController _textEditingController;

  void _onTextChanged() {
    final text = _textEditingController.text;
    final convertedValue = _stringToValue(text);

    if (control?.value != convertedValue) {
      control?.updateValue(convertedValue);
    }
  }

  T? _stringToValue(String text) {
    if (text.isEmpty) return null;

    // String 타입
    if (T == String) return text as T;

    // int 타입
    if (T == int) {
      final intValue = int.tryParse(text);
      return intValue as T?;
    }

    // double 타입
    if (T == double) {
      final doubleValue = double.tryParse(text);
      return doubleValue as T?;
    }

    // 기본적으로 String으로 처리
    return text as T;
  }

  @override
  T? modelToViewValue(T? modelValue) => modelValue;

  @override
  T? viewToModelValue(T? viewValue) => viewValue;

  @override
  void dispose() {
    _textEditingController.removeListener(_onTextChanged);
    super.dispose();
  }
}
