import 'package:flutter/material.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/widgets/mg_bottomsheet.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:url_launcher/url_launcher.dart';

/// 카카오채널 문의 버튼
///
/// Usage:
/// ```dart
/// InquiryButton()
/// ```
class InquiryButton extends StatelessWidget {
  const InquiryButton({super.key});

  static const String kakaoChannelUrl = 'http://pf.kakao.com/_UmqJn';

  @override
  Widget build(BuildContext context) {
    return MgButton(
      onPressed: () async => _showInquiryBottomSheet(context),
      content: Text("문의하기").regular().textGray().sm(),
    );
  }

  void _showInquiryBottomSheet(BuildContext context) {
    MgBottomsheet.show(context, (context, bottomState) {
      return MgBottomsheet(
        Column(
          children: [
            Text('문의').md().bold().margin(vertical: MgSizes.xl),
            _buildInquiryItem(context),
          ],
        ).margin(all: MgSizes.md),
      );
    }, height: 250);
  }

  Widget _buildInquiryItem(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.of(context).pop();
        await _openKakaoChannel();
      },
      child: Row(
        children: [
          ClipOval(
            child: Image.asset(R.ASSETS_IMAGES_KAKAO_CHANNEL_PNG),
          ).constrained(height: MgSizes.size24),
          Gaps.w12,
          Expanded(child: Text('바이트픽 카카오채널 문의').md()),
        ],
      ).margin(all: MgSizes.lg),
    );
  }

  Future<void> _openKakaoChannel() async {
    final uri = Uri.parse(kakaoChannelUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
