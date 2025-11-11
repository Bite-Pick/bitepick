import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/features/auth/domain/entities/auth_provider_type.dart';

part 'user.freezed.dart';
part 'user.g.dart';

enum UserRole {
  @JsonValue('CUSTOMER')
  customer,
  @JsonValue('OWNER')
  owner,
  @JsonValue('ADMIN')
  admin,
}

enum ApprovedStatus {
  @JsonValue('APPROVED')
  approved,
  @JsonValue('REJECTED')
  rejected,
  @JsonValue('WAITING')
  waiting,
}

@freezed
class User with _$User {
  const factory User({
    required String email,
    required String nickName,
    required UserRole userRole,
    required AuthProviderType providerType,
    ApprovedStatus? approved,
    String? goodsId,
  }) = _User;
  const User._();
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
