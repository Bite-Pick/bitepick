import 'package:magambell/src/features/user/domain/entities/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user.provider.g.dart';

@Riverpod(keepAlive: true)
class UserState extends _$UserState {
  @override
  User? build() {
    // Mock data - API가 준비되면 실제 API 호출로 대체
    // return null; // 로그인하지 않은 상태

    // Guest 유저 mock data
    // return const UserInfo(
    //   email: 'guest@example.com',
    //   nickName: '게스트',
    //   userRole: UserRole.guest,
    //   providerType: ProviderType.kakao,
    //   approved: ApprovedStatus.approved,
    // );

    // Owner 유저 mock data (테스트용)
    return const User(
      email: 'owner@example.com',
      nickName: '사장님',
      userRole: UserRole.owner,
      providerType: ProviderType.kakao,
      approved: ApprovedStatus.approved,
      goodsId: 'store-123',
    );
  }

  // 유저 정보 설정
  void setUser(User user) {
    state = user;
  }

  // 로그아웃
  void clearUser() {
    state = null;
  }

  // 유저 역할 확인 헬퍼 메서드
  bool get isGuest => state?.userRole == UserRole.guest;
  bool get isOwner => state?.userRole == UserRole.owner;
  bool get isAdmin => state?.userRole == UserRole.admin;
  bool get isLoggedIn => state != null;
}
