enum AuthProviderType {
  naver('NAVER'),
  kakao('KAKAO'),
  apple('APPLE');

  const AuthProviderType(this.value);

  final String value;
}

// enum UserRole = 'GUEST' | 'OWNER';