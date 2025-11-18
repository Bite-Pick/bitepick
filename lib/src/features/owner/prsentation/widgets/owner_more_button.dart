import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/utils/inquiry_button.dart';
import 'package:magambell/src/features/auth/utils/auth_utils.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';

class OwnerMoreButton extends ConsumerWidget {
  const OwnerMoreButton({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<(String, String)> menus = [
      ('logout', '로그아웃'),
      ('support', '고객센터'),
      ('withdraw', '회원탈퇴'),
    ];
    return PopupMenuButton<String>(
      icon: BaseSvgIcon.moreVertical(),
      onSelected: (value) {
        return switch (value) {
          'logout' => logout(ref, context), // TODO: dialog로 묻기
          'support' => InquiryButton.showInquiryBottomSheet(context),
          'withdraw' => withDraw(ref, context),
          _ => null,
        };
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      offset: const Offset(0, 36), // 클릭 위치로부터 아래로 띄움
      itemBuilder: (context) => [
        for (final (value, label) in menus) ...[
          PopupMenuItem<String>(
            value: value,
            child: Center(child: Text(label)),
          ),
          if (value != menus.last.$1) const PopupMenuDivider(),
        ],
      ],
    );
  }
}
