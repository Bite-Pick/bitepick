import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';

class Step3QuantityInfo extends ConsumerStatefulWidget {
  const Step3QuantityInfo({super.key});

  @override
  ConsumerState<Step3QuantityInfo> createState() => _Step3QuantityInfoState();
}

class _Step3QuantityInfoState extends ConsumerState<Step3QuantityInfo> {
  final TextEditingController _quantityController = TextEditingController();
  int _quantity = 0;

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
      _quantityController.text = _quantity.toString();
    });
  }

  void _decrementQuantity() {
    if (_quantity > 0) {
      setState(() {
        _quantity--;
        _quantityController.text = _quantity.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: MgSizes.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 재고 수량
          Text('재고 수량').md().bold(),
          Gaps.h8,
          Text('판매할 마감백의 수량을 입력해주세요').sm().textGray(),
          Gaps.h24,

          // 수량 선택 UI
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              border: Border.all(color: MgColorScheme.gray3),
              borderRadius: BorderRadius.circular(MgRadius.md),
            ),
            child: Column(
              children: [
                Text('$_quantity').md().bold(),
                Gaps.h24,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // - 버튼
                    IconButton(
                      onPressed: _decrementQuantity,
                      icon: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: MgColorScheme.gray2,
                        ),
                        child: Icon(Icons.remove, color: MgColorScheme.text),
                      ),
                    ),
                    Gaps.w24,
                    // 직접 입력
                    SizedBox(
                      width: 120,
                      child: TextField(
                        controller: _quantityController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (value) {
                          setState(() {
                            _quantity = int.tryParse(value) ?? 0;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: '0',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(MgRadius.md),
                            borderSide: BorderSide(color: MgColorScheme.gray3),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(MgRadius.md),
                            borderSide: BorderSide(color: MgColorScheme.gray3),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(MgRadius.md),
                            borderSide: BorderSide(
                              color: MgColorScheme.primary,
                              width: 2,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                    Gaps.w24,
                    // + 버튼
                    IconButton(
                      onPressed: _incrementQuantity,
                      icon: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: MgColorScheme.primary,
                        ),
                        child: Icon(Icons.add, color: MgColorScheme.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Gaps.h24,

          // 안내 메시지
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: MgColorScheme.gray1.withOpacity(0.5),
              borderRadius: BorderRadius.circular(MgRadius.md),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: MgColorScheme.gray6, size: 20),
                Gaps.w12,
                Expanded(
                  child: Text(
                    '재고 수량은 나중에도 수정할 수 있습니다',
                  ).sm().textColor(MgColorScheme.gray6),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
