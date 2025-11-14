import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/goods/presentation/widgets/step_view_wrapper.dart';

class Step5TagsView extends ConsumerWidget {
  const Step5TagsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StoreRegisterViewWrapper(
      children: [
        // 등록 완료 안내
        Center(
          child: Column(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: MgColorScheme.primary.withOpacity(0.1),
                ),
                child: Icon(
                  Icons.check_circle_outline,
                  size: 48,
                  color: MgColorScheme.primary,
                ),
              ),
              Gaps.h24,
              Text('입력하신 내용을 확인해주세요').lg().bold(),
              Gaps.h8,
              Text('등록하기 버튼을 누르면 바이트백이 등록됩니다').sm().textGray(),
            ],
          ),
        ),

        Gaps.h32,

        // 바이트백 정보 요약
        _buildSummarySection(
          title: '바이트백 설명',
          content: '크로와상, 바게트, 식빵 세트', // TODO: 실제 데이터로 교체
        ),

        Gaps.h16,

        _buildSummarySection(
          title: '가격 정보',
          content: '원가: 10,000원\n할인율: 30%\n판매가: 7,000원', // TODO: 실제 데이터로 교체
        ),

        Gaps.h16,

        _buildSummarySection(
          title: '재고 수량',
          content: '15개', // TODO: 실제 데이터로 교체
        ),

        Gaps.h16,

        _buildSummarySection(
          title: '판매 기간',
          content: '2025.01.15 09:00 ~ 2025.01.15 18:00', // TODO: 실제 데이터로 교체
        ),

        Gaps.h32,

        // 주의사항
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: MgColorScheme.gray1.withOpacity(0.5),
            borderRadius: BorderRadius.circular(MgRadius.md),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: MgColorScheme.gray6,
                    size: 20,
                  ),
                  Gaps.w8,
                  Text('주의사항').sm().bold(),
                ],
              ),
              Gaps.h8,
              Text('• 등록 후에도 수정이 가능합니다').sm().textGray(),
              Gaps.h4,
              Text('• 판매 시작 전까지는 취소할 수 있습니다').sm().textGray(),
              Gaps.h4,
              Text('• 재고가 모두 판매되면 자동으로 판매가 종료됩니다').sm().textGray(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummarySection({
    required String title,
    required String content,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: MgColorScheme.gray3),
        borderRadius: BorderRadius.circular(MgRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title).sm().bold().textColor(MgColorScheme.gray6),
          Gaps.h8,
          Text(content).md(),
        ],
      ),
    );
  }
}
