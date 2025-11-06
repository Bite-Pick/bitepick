import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/features/auth/domain/entities/auth_provider_type.dart';

part 'social_auth_result.freezed.dart';

@freezed
class SocialAuthResult with _$SocialAuthResult {
  const factory SocialAuthResult({
    required AuthProviderType providerType,
    required String authCode, // Access Token
    String? email,
    String? name,
  }) = _SocialAuthResult;
}
