/// JSON 관련 유틸리티 함수 모음
class JsonUtils {

  static Map<String, dynamic> removeEmpty(Map<String, dynamic> map) {
    final result = <String, dynamic>{};

    map.forEach((key, value) {
      if (value == null) return;
      if (value is String && value.isEmpty) return;
      if (value is List && value.isEmpty) return;
      if (value is Map && value.isEmpty) return;

      if (value is Map<String, dynamic>) {
        final cleaned = removeEmpty(value);
        if (cleaned.isNotEmpty) {
          result[key] = cleaned;
        }
        return;
      }

      result[key] = value;
    });

    return result;
  }


  static Map<String, dynamic> removeNull(Map<String, dynamic> map) {
    final result = <String, dynamic>{};

    map.forEach((key, value) {
      if (value != null) {
        // 중첩된 Map인 경우 재귀적으로 처리
        if (value is Map<String, dynamic>) {
          result[key] = removeNull(value);
        } else {
          result[key] = value;
        }
      }
    });

    return result;
  }

  static Map<String, dynamic> removeValues(
    Map<String, dynamic> map,
    List<dynamic> valuesToRemove,
  ) {
    final result = <String, dynamic>{};

    map.forEach((key, value) {
      if (!valuesToRemove.contains(value)) {
        result[key] = value;
      }
    });

    return result;
  }

  /// Map에서 특정 키들을 제거
  ///
  /// 사용 예시:
  /// ```dart
  /// final data = {"name": "홍길동", "password": "1234", "age": 25};
  /// final cleaned = JsonUtils.removeKeys(data, ["password"]);
  /// // 결과: {"name": "홍길동", "age": 25}
  /// ```
  static Map<String, dynamic> removeKeys(
    Map<String, dynamic> map,
    List<String> keysToRemove,
  ) {
    final result = <String, dynamic>{};

    map.forEach((key, value) {
      if (!keysToRemove.contains(key)) {
        result[key] = value;
      }
    });

    return result;
  }
}
