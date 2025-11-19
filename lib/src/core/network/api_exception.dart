
/// 중복 닉네임 예외
class DuplicateNicknameException implements Exception {
  final String message;
  DuplicateNicknameException([this.message = '이미 사용 중인 닉네임입니다.']);

  @override
  String toString() => message;
}

/// 인증 실패 예외
class AuthenticationException implements Exception {
  final String message;
  final String? errorCode;

  AuthenticationException(this.message, {this.errorCode});

  @override
  String toString() => message;
}

/// 알림 중복 등록 예외
class DuplicateNotificationStoreException implements Exception {
  final String message;
  DuplicateNotificationStoreException([this.message = '이미 알림을 신청했어요.']);

  @override
  String toString() => 'DuplicateNotificationStoreException: $message';
}

/// 잘못된 픽업 시간 예외
class InvalidPickupTimeException implements Exception {
  final String message;
  InvalidPickupTimeException([this.message = '선택한 픽업시간이 유효하지 않습니다. 다시 선택해주세요.']);

  @override
  String toString() => 'InvalidPickupTimeException: $message';
}
