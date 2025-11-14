import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:magambell/src/widgets/mg_text_rich.dart';

class OrderAcceptDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const OrderAcceptDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(MgRadius.md),
      ),
      child: Container(
        width: 300,
        padding: EdgeInsets.all(MgSizes.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gaps.h8,
            // TODO: 주문수락 dialog icon 교체
            Icon(Icons.notifications, size: 80, color: Colors.amber),
            Gaps.h16,
            // 제목
            Text('주문 수락이 완료되었어요').lg().bold(),
            Gaps.h4,
            MgTextRich(
              text: '바이트백이 준비가 되면 ',
              children: [
                TextSpan(text: '준비 완료').bold(),
                TextSpan(text: '버튼을 눌러 손님에게 알려주세요'),
              ],
            ).sm().textGray().center(),
            Gaps.h32,

            // 확인 버튼
            MgButton(
              onPressed: () {
                context.pop();
                onConfirm();
              },
              content: Text('확인'),
            ).primary(),
          ],
        ),
      ),
    );
  }
}
