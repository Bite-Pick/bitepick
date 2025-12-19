import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/network/api_client.dart';
import 'package:magambell/src/features/splash/domain/entities/app_version_policy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_version_policy_repository.g.dart';

class AppVersionPolicyRepository {
  final Ref ref;
  late final Dio _dio;

  AppVersionPolicyRepository(this.ref) {
    _dio = ref.read(apiClientProvider);
  }

  Future<AppVersionPolicy?> getAppVersionPolicy() async {
    final res = await _dio.post(
      '/v1/admin/app-version-policies',
      data: {
        'platform': Platform.operatingSystem, // TODO: 실제 값 확인 필요
      },
    );
    final data = res.data['data'] as Map<String, dynamic>?;
    if (res.data['status'] != 'OK' || data == null) return null;
    return AppVersionPolicy.fromJson(data);
  }
}

@riverpod
AppVersionPolicyRepository appVersionPolicyRepository(Ref ref) {
  return AppVersionPolicyRepository(ref);
}
