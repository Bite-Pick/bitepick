import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/widgets/mg_textfield.dart';

class Step2PriceInfo extends ConsumerStatefulWidget {
  const Step2PriceInfo({super.key});

  @override
  ConsumerState<Step2PriceInfo> createState() => _Step2PriceInfoState();
}

class _Step2PriceInfoState extends ConsumerState<Step2PriceInfo> {
  final TextEditingController _originalPriceController =
      TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  int _calculatedPrice = 0;

  @override
  void dispose() {
    _originalPriceController.dispose();
    _discountController.dispose();
    super.dispose();
  }

  void _calculateSalePrice() {
    final originalPrice = int.tryParse(_originalPriceController.text) ?? 0;
    final discount = int.tryParse(_discountController.text) ?? 0;
    setState(() {
      _calculatedPrice = originalPrice - (originalPrice * discount ~/ 100);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: MgSizes.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 원가
          Text('원가').md().bold(),
          Gaps.h8,
          Text('마감백의 정상 가격을 입력해주세요').sm().textGray(),
          Gaps.h16,
          MgTextField(),
          Gaps.h32,

          // 할인율
          Text('할인율').md().bold(),
          Gaps.h8,
          Text('할인율을 입력해주세요').sm().textGray(),
          Gaps.h16,
          MgTextField(),

          Gaps.h32,

          // 판매가 (계산된 값)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: MgColorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(MgRadius.md),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('판매가').md().bold(),
                Text(
                  '$_calculatedPrice원',
                ).lg().bold().textColor(MgColorScheme.primary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
