import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:magambell/src/core/config/environment.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';

class KakaoShareUtil {
  /// 지역 오픈 요청 공유
  static Future<void> shareOpenRegionRequest() async {
    final bool isKakaoTalkSharingAvailable = await ShareClient.instance
        .isKakaoTalkSharingAvailable();

    if (isKakaoTalkSharingAvailable) {
      try {
        Uri uri = await ShareClient.instance.shareCustom(
          templateId: Environment.kakaoShareTemplateId,
        );
        await ShareClient.instance.launchKakaoTalk(uri);
        talker.info('카카오톡 공유 완료');
      } catch (error) {
        talker.error('카카오톡 공유 실패 $error');
      }
    } else {
      try {
        Uri shareUrl = await WebSharerClient.instance.makeCustomUrl(
          templateId: Environment.kakaoShareTemplateId,
        );
        await launchBrowserTab(shareUrl, popupOpen: true);
      } catch (error) {
        talker.error('카카오톡 공유 실패 $error');
      }
    }
  }
}
