import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';

class KakaoShareUtil {
  /// 지역 오픈 요청 공유
  static Future<void> shareOpenRegionRequest() async {
    try {
      final template = FeedTemplate(
        content: Content(
          title: '바이트픽',
          description: '새로운 지역 오픈 요청!',
          imageUrl: Uri.parse('https://example.com/image.png'),
          link: Link(
            webUrl: Uri.parse('https://bitepick.com'),
            mobileWebUrl: Uri.parse('https://bitepick.com'),
          ),
        ),
      );
      await ShareClient.instance.shareDefault(template: template);
    } catch (e) {
      talker.error('카카오 공유 실패: $e');
      rethrow;
    }
  }
}
