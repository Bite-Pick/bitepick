import 'package:flutter/material.dart';
import 'package:magambell/src/widgets/mg_textfield.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// 전화번호 전용 ReactiveTextField
/// - UI에는 하이픈(-)이 자동으로 추가됨 (예: 010-1234-5678)
/// - Form 값에는 숫자만 저장됨 (예: 01012345678)
class MgReactivePhoneTextField extends ReactiveFormField<String, String> {
  MgReactivePhoneTextField({
    super.key,
    super.formControlName,
    this.hintText = '숫자만 입력',
    this.enabled = true,
    this.textInputAction,
    this.inputStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.onSubmitted,
  }) : super(
         builder: (ReactiveFormFieldState<String, String> field) {
           final state = field as _MgReactivePhoneTextFieldState;

           return MgTextField(
             controller: state._textEditingController,
             focusNode: state._focusNode,
             hintText: hintText,
             enabled: enabled,
             keyboardType: TextInputType.phone,
             maxLines: 1,
             textInputAction: textInputAction,
             inputStyle: inputStyle,
             prefixIcon: prefixIcon ?? const SizedBox.shrink(),
             suffixIcon: suffixIcon,
             onSubmitted: onSubmitted,
           );
         },
       );

  final String? hintText;
  final bool enabled;
  final TextInputAction? textInputAction;
  final TextStyle? inputStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onSubmitted;

  @override
  ReactiveFormFieldState<String, String> createState() =>
      _MgReactivePhoneTextFieldState();
}

class _MgReactivePhoneTextFieldState
    extends ReactiveFormFieldState<String, String> {
  final TextEditingController _textEditingController = TextEditingController();
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _textEditingController.text = formatPhoneNumber(value ?? '');
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void onControlValueChanged(dynamic value) {
    final formattedValue = formatPhoneNumber(value ?? '');
    if (_textEditingController.text != formattedValue) {
      _textEditingController.value = _textEditingController.value.copyWith(
        text: formattedValue,
        selection: TextSelection.collapsed(offset: formattedValue.length),
      );
    }
    super.onControlValueChanged(value);
  }

  /// 전화번호 포맷팅 (010-1234-5678 형식)
  static String formatPhoneNumber(String value) {
    // 숫자만 추출
    final digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), '');

    if (digitsOnly.isEmpty) return '';

    // 포맷팅 로직
    if (digitsOnly.length <= 3) {
      return digitsOnly;
    } else if (digitsOnly.length <= 7) {
      return '${digitsOnly.substring(0, 3)}-${digitsOnly.substring(3)}';
    } else if (digitsOnly.length <= 11) {
      return '${digitsOnly.substring(0, 3)}-${digitsOnly.substring(3, 7)}-${digitsOnly.substring(7)}';
    } else {
      // 11자리 초과는 잘라냄
      return '${digitsOnly.substring(0, 3)}-${digitsOnly.substring(3, 7)}-${digitsOnly.substring(7, 11)}';
    }
  }

  @override
  ControlValueAccessor<String, String> selectValueAccessor() {
    return _PhoneNumberValueAccessor(_textEditingController);
  }
}

/// 전화번호 ValueAccessor
/// - View에는 포맷된 번호 표시 (010-1234-5678)
/// - Model(Form)에는 숫자만 저장 (01012345678)
class _PhoneNumberValueAccessor extends ControlValueAccessor<String, String> {
  _PhoneNumberValueAccessor(this._textEditingController) {
    _textEditingController.addListener(_onTextChanged);
  }

  final TextEditingController _textEditingController;

  void _onTextChanged() {
    final text = _textEditingController.text;
    // 숫자만 추출하여 form에 저장
    final digitsOnly = text.replaceAll(RegExp(r'[^0-9]'), '');

    // 11자리 제한
    final limitedDigits = digitsOnly.length > 11
        ? digitsOnly.substring(0, 11)
        : digitsOnly;

    if (control?.value != limitedDigits) {
      control?.updateValue(limitedDigits.isEmpty ? null : limitedDigits);
    }

    // UI 업데이트 (포맷팅 적용)
    final formatted = formatPhoneNumber(limitedDigits);
    if (_textEditingController.text != formatted) {
      final cursorPosition = _textEditingController.selection.baseOffset;
      _textEditingController.value = _textEditingController.value.copyWith(
        text: formatted,
        selection: TextSelection.collapsed(
          offset: formatted.length.clamp(0, formatted.length),
        ),
      );
    }
  }

  @override
  String? modelToViewValue(String? modelValue) {
    return formatPhoneNumber(modelValue ?? '');
  }

  @override
  String? viewToModelValue(String? viewValue) {
    // View -> Model: 숫자만 추출
    if (viewValue == null || viewValue.isEmpty) return null;
    final digitsOnly = viewValue.replaceAll(RegExp(r'[^0-9]'), '');
    return digitsOnly.isEmpty ? null : digitsOnly;
  }

  @override
  void dispose() {
    _textEditingController.removeListener(_onTextChanged);
    super.dispose();
  }
}

// TODO: 추후 utiil로 이동
String formatPhoneNumber(String value) {
  if (value.isEmpty) return '';

  if (value.length <= 3) {
    return value;
  } else if (value.length <= 7) {
    return '${value.substring(0, 3)}-${value.substring(3)}';
  } else {
    return '${value.substring(0, 3)}-${value.substring(3, 7)}-${value.substring(7)}';
  }
}
