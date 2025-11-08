import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

enum UserRole {
  @JsonValue('GUEST')
  guest,
  @JsonValue('OWNER')
  owner,
  @JsonValue('ADMIN')
  admin,
}

enum ProviderType {
  @JsonValue('KAKAO')
  kakao,
  @JsonValue('NAVER')
  naver,
  @JsonValue('GOOGLE')
  google,
  @JsonValue('APPLE')
  apple,
}

enum ApprovedStatus {
  @JsonValue('APPROVED')
  approved,
  @JsonValue('PENDING')
  pending,
  @JsonValue('REJECTED')
  rejected,
}

@freezed
class User with _$User {
  const factory User({
    required String email,
    required String nickName,
    required UserRole userRole,
    required ProviderType providerType,
    required ApprovedStatus approved,
    String? goodsId,
  }) = _User;
  const User._();
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
