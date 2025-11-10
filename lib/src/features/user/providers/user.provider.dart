import 'package:magambell/src/features/user/data/repositories/user_repository.dart';
import 'package:magambell/src/features/user/domain/entities/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user.provider.g.dart';

@Riverpod(keepAlive: true)
class UserState extends _$UserState {
  @override
  Future<User?> build() async {
    // 앱 시작시 사용자 정보 로드
    try {
      final user = await ref.read(userRepositoryProvider).getMe();
      return user;
    } catch (e) {
      // API 호출 실패시 null 반환 (로그인하지 않은 상태)
      return null;
    }
  }

  // 유저 정보 설정
  Future<void> setUser(User user) async {
    state = AsyncValue.data(user);
  }

  // 로그아웃
  Future<void> clearUser() async {
    state = const AsyncValue.data(null);
  }

  // 사용자 정보 새로고침
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final user = await ref.read(userRepositoryProvider).getMe();
      return user;
    });
  }
}
