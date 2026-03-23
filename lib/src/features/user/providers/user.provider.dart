import 'package:magambell/src/features/notification/domain/push_notification.dart';
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
      if (user != null) {
        PushNotification.subscribeToRoleTopic(user.userRole.value);
      }
      return user;
    } catch (e) {
      // 에러를 그대로 throw하여 router에서 처리
      rethrow;
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
