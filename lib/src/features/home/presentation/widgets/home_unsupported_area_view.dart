import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:magambell/src/widgets/mg_text_rich.dart';
import 'package:magambell/src/widgets/mg_tooltip.dart';

class HomeUnsupportedAreaView extends ConsumerWidget {
  const HomeUnsupportedAreaView({
    super.key,
    required this.title,
    required this.titleHighlight,
    required this.subtitle,
    required this.imageUrl,
    required this.buttonText,
    this.buttonPrefixIconUrl,
    required this.tooltipText,
    required this.onPressed,
  });

  final String title;
  final String titleHighlight;
  final String subtitle;
  final String imageUrl;
  final String buttonText;
  final String tooltipText;
  final VoidCallback onPressed;
  final String? buttonPrefixIconUrl;

  factory HomeUnsupportedAreaView.openRequest({VoidCallback? onPressed}) {
    return HomeUnsupportedAreaView(
      title: "오픈 요청하고\n",
      titleHighlight: "마감빵 저렴하게 먹어요!",
      subtitle: "아직 준비 중인 지역이에요",
      imageUrl: R.ASSETS_IMAGES_HOME_OPEN_BEFORE_PNG,
      buttonText: "오픈 요청하기",
      onPressed:
          onPressed ??
          () {
            // TODO[open]: 오픈 요청 API 호출
          },
      tooltipText:
          "지금 n명이 오픈요청중이에요!", // TODO[open]: n명이 너무 작으면 안보이도록 설계하는건 어떤지?
    );
  }
  factory HomeUnsupportedAreaView.share({VoidCallback? onPressed}) {
    return HomeUnsupportedAreaView(
      title: "내 지역 오픈요청이",
      titleHighlight: "완료되었어요!",
      subtitle: "빨리 소식 들고올게요",
      imageUrl: R.ASSETS_IMAGES_HOME_OPEN_AFTER_PNG,
      buttonText: "카카오톡으로 공유하기",
      buttonPrefixIconUrl: R.ASSETS_ICONS_SVG_FILLED_KAKAO_SVG,
      onPressed:
          onPressed ??
          () {
            // TODO[open]: 카카오 공유 기능
          },
      tooltipText: "오픈 요청이 많은 지역부터 열려요!",
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        children: [
          Gaps.h64,
          Text(subtitle).bold().md().textColor(MgColorScheme.gray4),
          Gaps.h8,
          MgTextRich(
            text: title,
            children: [TextSpan(text: titleHighlight)],
          ).bold().xl().center(),
          Gaps.h16,
          Image.asset(imageUrl, height: MgSizes.size240.h),
          Gaps.h32,
          MgTooltip(
            item: Text(tooltipText).xs().white(),
            defaultVisible: true,
            closable: false,
            itemAlignment: Alignment.topCenter,
            // offset: const Offset(0, -8),
            child: MgButton(
              content: buttonPrefixIconUrl != null
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BaseSvgIcon(assetName: buttonPrefixIconUrl!),
                        Gaps.w6,
                        Text(buttonText),
                      ],
                    )
                  : Text(buttonText),
              onPressed: onPressed,
            ).primary().margin(horizontal: MgSizes.size56.w),
          ),
          Gaps.h16,
          Text("지역이 오픈되면 알려드릴게요!").sm().textGray(),
        ],
      ),
    );
  }
}
