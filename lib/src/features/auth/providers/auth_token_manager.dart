import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:magambell/src/features/auth/domain/entities/auth_tokens.dart';

part 'auth_token_manager.g.dart';

@Riverpod(keepAlive: true)
class AuthTokenManager extends _$AuthTokenManager {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  @override
  Future<AuthTokens?> build() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString(_accessTokenKey);
    final refreshToken = prefs.getString(_refreshTokenKey);

    if (accessToken == null || refreshToken == null) {
      return null;
    }

    return AuthTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  /// 토큰 저장
  Future<void> saveTokens(AuthTokens tokens) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, tokens.accessToken);
    await prefs.setString(_refreshTokenKey, tokens.refreshToken);

    state = AsyncValue.data(tokens);
    print('✅ Tokens saved');
  }

  /// 토큰 삭제
  Future<void> deleteTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_refreshTokenKey);

    state = const AsyncValue.data(null);
    print('🗑️ Tokens deleted');
  }

  /// 현재 저장된 토큰 조회
  AuthTokens? getTokens() {
    return state.value;
  }

  /// Access Token만 조회
  String? getAccessToken() {
    return state.value?.accessToken;
  }

  /// Refresh Token만 조회
  String? getRefreshToken() {
    return state.value?.refreshToken;
  }
}
