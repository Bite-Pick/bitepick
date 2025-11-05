import 'package:reactive_forms/reactive_forms.dart';

/// FormGroup 확장 메서드
extension FormGroupExtension on FormGroup {
  /// FormGroup을 깊은 복사
  FormGroup copyWith([
    Map<String, AbstractControl<Object?>>? overrideControls,
  ]) {
    final FormGroup newFormGroup = FormGroup({});
    final Map<String, AbstractControl<dynamic>> newControls = {};

    void deepCopy(Map<String, AbstractControl<Object?>> controls) {
      controls.forEach((key, control) {
        if (control is FormGroup) {
          newControls[key] = control.copyWith();
        } else if (control is FormArray) {
          newControls[key] = control.copyWith();
        } else {
          newControls[key] = FormControl(value: value[key]);
        }
      });
    }

    deepCopy(controls);
    if (overrideControls != null) deepCopy(overrideControls);

    newFormGroup.addAll(newControls);
    return newFormGroup;
  }
}

/// FormArray 확장 메서드
extension FormArrayExtension on FormArray {
  /// FormArray를 깊은 복사
  FormArray copyWith([List<AbstractControl<dynamic>>? overrideControls]) {
    final List<AbstractControl<dynamic>> newControls = [];

    void deepCopy(controls) {
      for (var control in controls) {
        if (control is FormGroup) {
          newControls.add(control.copyWith());
        } else if (control is FormArray) {
          newControls.add(control.copyWith());
        } else {
          newControls.add(FormControl(value: control.value));
        }
      }
    }

    overrideControls != null ? deepCopy(overrideControls) : deepCopy(controls);

    return FormArray(newControls);
  }
}

/// FormControl 확장 메서드
extension FormControlExtensions on AbstractControl {
  /// 값이 존재하는지 확인
  bool get hasValue {
    final val = value;
    if (val == null) return false;
    if (val is String) return val.isNotEmpty;
    if (val is List) return val.isNotEmpty;
    return true;
  }
}
