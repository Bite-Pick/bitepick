import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';
import 'package:magambell/src/widgets/mg_alert_dialog.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:magambell/src/widgets/mg_tooltip.dart';

class HomeUnsupportedAreaView extends ConsumerWidget {
  const HomeUnsupportedAreaView({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.buttonText,
    this.buttonPrefixIconUrl,
    required this.tooltipText,
    required this.onPressed,
  });

  final String title;
  final String subtitle;
  final String imageUrl;
  final String buttonText;
  final String tooltipText;
  final VoidCallback onPressed;
  final String? buttonPrefixIconUrl;

  factory HomeUnsupportedAreaView.share({VoidCallback? onPressed}) {
    return HomeUnsupportedAreaView(
      title: "내 지역 오픈요청이\n완료되었어요",
      subtitle: "빨리 소식 들고올게요",
      imageUrl: R.ASSETS_IMAGES_CHARACTER_SUCCESS_PNG,
      buttonText: "공유",
      buttonPrefixIconUrl: R.ASSETS_IMAGES_CHARACTER_SUCCESS_PNG,
      onPressed:
          onPressed ??
          () {
            // TODO[open]: 카카오 공유 기능
          },
      tooltipText: "오픈 요청이 많은 지역부터 열려요",
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MgAlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Gaps.h40,
          Text(subtitle).bold().md().textGray(),
          Gaps.h8,
          Text(title).bold().xl().center(),
          Image.asset(
            imageUrl,
            height: 188.h,
          ).margin(top: MgSizes.md, bottom: MgSizes.xxxl),
        ],
      ),
      actions: Row(
        children: [
          Expanded(
            child: MgButton(
              onPressed: () {
                context.pop();
              },
              content: Text("확인"),
              borderColor: MgColorScheme.primary,
            ),
          ),
          Gaps.w8,
          Expanded(
            child: MgTooltip(
              item: Text(tooltipText).xs().white(),
              defaultVisible: true,
              closable: false,
              itemAlignment: Alignment.topCenter,
              child: MgButton(
                onPressed: () {
                  context.pop();
                  // TODO: 카카오 공유 배포후 테스트 필요
                  onPressed();
                
                },
                content: Text("공유"),
              ).primary(),
            ),
          ),
        ],
      ).margin(top: MgSizes.size32, bottom: MgSizes.md),
    );
  }

}
