// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$apiClientHash() => r'219eeb6b6a02551d69a9374d0a1a7d878b75b887';

/// API 클라이언트 Provider
///
/// Environment의 baseApiUrl을 사용하여 Dio 인스턴스를 생성합니다.
/// - 개발/운영 환경에 따라 자동으로 Base URL이 설정됩니다.
/// - 인증, 에러 처리, 로깅 등의 인터셉터가 적용됩니다.
///
/// Copied from [apiClient].
@ProviderFor(apiClient)
final apiClientProvider = Provider<Dio>.internal(
  apiClient,
  name: r'apiClientProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$apiClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ApiClientRef = ProviderRef<Dio>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
