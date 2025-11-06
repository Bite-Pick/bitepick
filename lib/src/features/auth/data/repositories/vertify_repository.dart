import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/network/api_client.dart';
import 'package:magambell/src/features/auth/domain/entities/auth_provider_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vertify_repository.g.dart';

class VertifyRepository {
  final Dio _dio = ApiClient().dio;

  Future<bool> vertifySocial(
    AuthProviderType authProviderType,
    String authCode,
  ) async {
    final res = await _dio.get(
      '/v1/verify/social',
      queryParameters: {
        'providerType': authProviderType.value,
        'authCode': authCode,
      },
    );

    final data = res.data['data'] as bool?;
    if (res.data['status'] != 'OK' || data == null) return false;
    return true;
  }
}

@riverpod
VertifyRepository vertifyRepository(Ref ref) {
  return VertifyRepository();
}
