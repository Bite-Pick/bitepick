import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

// NOTE: AI GENERATE 검토 필요(네이밍, 로직)
class MapLauncher {
  static const String NAVER_MAP_IOS_STORE_URL =
      'https://apps.apple.com/kr/app/id311867728';
  static const String NAVER_MAP_ANDROID_STORE_URL =
      'https://play.google.com/store/apps/details?id=com.nhn.android.nmap';
  static const String KAKAO_MAP_IOS_STORE_URL =
      'https://apps.apple.com/kr/app/id304608425';
  static const String KAKAO_MAP_ANDROID_STORE_URL =
      'https://play.google.com/store/apps/details?id=net.daum.android.map';

  /// 네이버 지도로 길찾기
  static Future<void> openNaverMapRoute({
    required double latitude,
    required double longitude,
    required String destinationName,
    required String appPackageName,
  }) async {
    final url =
        "nmap://route/walk?dlat=$latitude&dlng=$longitude&dname=$destinationName&appname=$appPackageName";

    await _tryLaunchUrl(
      url,
      iosStoreUrl: NAVER_MAP_IOS_STORE_URL,
      androidStoreUrl: NAVER_MAP_ANDROID_STORE_URL,
    );
  }

  /// 카카오맵으로 길찾기
  static Future<void> openKakaoMapRoute({
    required double latitude,
    required double longitude,
  }) async {
    final url = "kakaomap://route?ep=$latitude,$longitude";

    await _tryLaunchUrl(
      url,
      iosStoreUrl: KAKAO_MAP_IOS_STORE_URL,
      androidStoreUrl: KAKAO_MAP_ANDROID_STORE_URL,
    );
  }

  /// URL 실행 시도, 실패시 스토어로 이동
  static Future<void> _tryLaunchUrl(
    String url, {
    required String androidStoreUrl,
    required String iosStoreUrl,
  }) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // 앱이 설치되지 않은 경우 스토어로 이동
      final storeUrl = Platform.isAndroid ? androidStoreUrl : iosStoreUrl;
      final storeUri = Uri.parse(storeUrl);
      await launchUrl(storeUri, mode: LaunchMode.externalApplication);
    }
  }
}
