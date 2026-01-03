/// ReactiveForm의 Validator 에러를 한글 메시지로 변환하는 유틸리티 클래스
class MgValidationMessage {
  /// FormControl의 에러 맵을 받아서 적절한 한글 에러 메시지를 반환
  ///
  /// [errors]: FormControl.errors
  /// [customMessages]: 필드별 커스텀 에러 메시지 (선택)
  ///
  /// 지원하는 Validator:
  /// - required: "필수 입력 항목입니다"
  /// - pattern: "올바른 형식이 아닙니다"
  /// - min: "최소 {값} 이상 입력해주세요"
  /// - max: "최대 {값} 이하로 입력해주세요"
  /// - minLength: "최소 {값}자 이상 입력해주세요"
  /// - maxLength: "최대 {값}자 이하로 입력해주세요"
  static String getErrorMessage(
    Map<String, dynamic> errors, {
    Map<String, String>? customMessages,
  }) {
    if (errors.isEmpty) return '';

    final errorKey = errors.keys.first;

    // 커스텀 메시지가 있으면 우선 사용
    if (customMessages?.containsKey(errorKey) == true) {
      return customMessages![errorKey]!;
    }

    // 기본 에러 메시지
    switch (errorKey) {
      case 'required':
        return '필수 입력 항목입니다';

      case 'pattern':
        return '올바른 형식이 아닙니다';

      case 'min':
        final min = errors['min']?['min'];
        if (min != null) {
          return '최소 $min 이상 입력해주세요';
        }
        return '최소값 이상 입력해주세요';

      case 'max':
        final max = errors['max']?['max'];
        if (max != null) {
          return '최대 $max 이하로 입력해주세요';
        }
        return '최대값 이하로 입력해주세요';

      case 'minLength':
        final requiredLength = errors['minLength']?['requiredLength'];
        if (requiredLength != null) {
          return '최소 $requiredLength자 이상 입력해주세요';
        }
        return '최소 길이 이상 입력해주세요';

      case 'maxLength':
        final requiredLength = errors['maxLength']?['requiredLength'];
        if (requiredLength != null) {
          return '최대 $requiredLength자 이하로 입력해주세요';
        }
        return '최대 길이 이하로 입력해주세요';

      case 'email':
        return '올바른 이메일 형식이 아닙니다';

      default:
        // 알 수 없는 에러는 키를 그대로 반환
        return errorKey;
    }
  }
}
