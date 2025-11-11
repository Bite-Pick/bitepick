import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/network/api_client.dart';
import 'package:magambell/src/features/user/domain/entities/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository.g.dart';

class UserRepository {
  final Ref ref;
  late final Dio _dio;
  UserRepository(this.ref) {
    _dio = ref.read(apiClientProvider);
  }

  Future<User?> getMe() async {
    try {
      final res = await _dio.get('/v1/user/me');

      if (res.data['status'] != 'OK') return null;

      final data = res.data['data'];
      if (data == null) return null;

      return User.fromJson(data as Map<String, dynamic>);
    } on DioException catch (e) {
      // STORE_NOT_FOUND 에러는 재throw하여 상위에서 처리
      if (e.response?.data != null) {
        final errorCode = e.response?.data['statusCode'];
        if (errorCode == 'STORE_NOT_FOUND') rethrow;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}

@riverpod
UserRepository userRepository(Ref ref) {
  return UserRepository(ref);
}

@riverpod
Future<User?> currentUser(Ref ref) async {
  return ref.read(userRepositoryProvider).getMe();
}
