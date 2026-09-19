import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/features/auth/utils/auth_utils.dart';
import 'package:magambell/src/features/store/data/repositories/store_repository.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/core/theme/mg_theme.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/features/owner/prsentation/widgets/owner_mypage_confirm_dialog.dart';
import 'package:magambell/src/features/goods/presentation/goods_edit_screen.dart';


class OwnerMypageRoute extends GoRouteData {
  const OwnerMypageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const OwnerMypageScreen();
  }
}

class OwnerMypageScreen extends ConsumerStatefulWidget {
  const OwnerMypageScreen({super.key});

  @override
  ConsumerState<OwnerMypageScreen> createState() => _OwnerMypageScreenState();
}

class _OwnerMypageScreenState extends ConsumerState<OwnerMypageScreen> {
  final Set<int> _expandedFaqIndices = {};

  static const List<(String question, String answer)> _faqItems = [
    (
      '주문은 어떻게 받기 시작하나요?',
      '앱 우측 상단의 [영업 중] 버튼을 켜면 고객 예약·결제가 활성화됩니다. 비가 오거나 재고가 남을 것 같은 날엔 미리 켜두시면 선주문을 안정적으로 확보하는 데 도움이 됩니다.',
    ),
    (
      '주문이 들어오면 무엇을 하면 되나요?',
      '[수락] 버튼을 누른 뒤, 픽업 시간에 맞춰 당일 남은 상품을 금액대에 맞게 묶음 포장해 주세요. 손님이 오시면 결제 완료 화면의 연락처가 일치하는지 확인하고 전달하시면 됩니다. 방문 시간은 [주문] 탭의 픽업 시간에서 확인하실 수 있습니다.',
    ),
    (
      '주문을 수락하지 않으면 어떻게 되나요?',
      '매장 상황을 고려해 일정 시간 응답이 없으면 주문은 자동으로 취소됩니다. 픽업 시작 35분 전까지 들어온 예약 주문의 경우, 픽업 시작 30분 전까지 수락하지 않으면 일괄 취소됩니다. 반면 픽업 시작 35분 전 이후부터 픽업 시간 내에 들어온 주문은, 접수 후 5분 이내에 수락하지 않으면 취소됩니다.',
    ),
    (
      '픽업 시간이나 재고 수량을 바꿀 수 있나요?',
      '네. 상단 [판매] 탭 → [상품 관리하기] 에서 당일 픽업 시간과 재고 수량을 언제든 변경할 수 있습니다.\n매일 상품을 하나하나 등록하실 필요는 없고, 준비 가능한 랜덤박스 개수만 선택해 주시면 됩니다.',
    ),
    (
      '재고가 먼저 소진돼 준비를 못 하게 됐어요.',
      '당황하지 마시고 [주문 거절] 을 눌러 주세요. 고객에게 자동 환불 처리되며, \'매장 상황에 따라 품절로 취소될 수 있음\'은 바이트픽이 고객에게 사전 안내하고 있습니다.\n단, [수락] 을 누른 뒤에는 앱에서 직접 취소가 불가능합니다. 부득이한 경우 바로 바이트픽 담당자에게 문의해 주세요.',
    ),
    (
      '정산은 언제, 얼마나 들어오나요?',
      '매월 첫째 영업일에 지난달 거래 내역이 일괄 입금됩니다. (예: 3/1~3/31 → 4/1 입금, 1일이 공휴일이면 다음 영업일)\n바이트픽 중개 수수료는 0원이며, 외부 결제망(PG) 수수료 3.3%만 공제됩니다. (예: 판매 10,000원 → 실수령 9,670원)',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final store = ref.watch(ownerStoreProvider).value;
    final storeName = store?.storeName ?? '';

    return BaseScaffold(
      appBar: BaseAppBar(
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: BaseSvgIcon.left(size: MgSizes.size24, color: NewColorScheme.gray1),
        ).padding(horizontal: MgSizes.md, vertical: MgSizes.sm),
        title: Text(
          '사장님 마이페이지',
          style: context.textTheme.bodyLarge?.copyWith(color: NewColorScheme.gray1),
        ).semibold().center(),
        height: 48,
        backgroundColor: NewColorScheme.gray14,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: MgSizes.size40,
                      height: MgSizes.size40,
                      decoration: BoxDecoration(
                        color: NewColorScheme.gray13,
                        borderRadius: BorderRadius.circular(MgRadius.sm),
                        border: Border.all(width: 0.6, color: NewColorScheme.gray11),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/store_info.png',
                          width: MgSizes.size32,
                          height: MgSizes.size32,
                        ),
                      ),
                    ),
                    Gaps.w8,
                    Text(
                      storeName,
                      style: context.textTheme.headlineMedium?.copyWith(color: NewColorScheme.gray2),
                    ),
                  ],
                ),
                Gaps.h(14),
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 79,
                      decoration: BoxDecoration(
                        color: MgColorScheme.primaryLightest,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(MgRadius.sm),
                          topRight: Radius.circular(MgRadius.sm),
                        ),
                        border: Border(
                          top: BorderSide(width: 1, color: const Color(0xFFFFEE7B)),
                          left: BorderSide(width: 1, color: const Color(0xFFFFEE7B)),
                          right: BorderSide(width: 1, color: const Color(0xFFFFEE7B)),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: MgSizes.md,
                            top: MgSizes.lg + 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '누적 판매 수익',
                                  style: context.textTheme.labelMedium?.copyWith(color: NewColorScheme.gray4),
                                ),
                                Text(
                                  '87,000원', //실제 가게 누적 판매 수익 API 연동 필요
                                  style: context.textTheme.displaySmall?.copyWith(color: NewColorScheme.gray1),
                                ).semibold(),
                              ],
                            ),
                          ),
                          Positioned(
                            right: MgSizes.xl,
                            top: 15,
                            child: Image.asset(
                              'assets/images/sales_revenue.png',
                              width: MgSizes.size64,
                              height: 55,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 41,
                      decoration: const BoxDecoration(
                        color: MgColorScheme.primaryLight,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(MgRadius.sm),
                          bottomRight: Radius.circular(MgRadius.sm),
                        ),
                      ),
                      child: Text(
                        '지금까지 바이트픽으로 번 추가 수익이에요!',
                        style: context.textTheme.labelMedium?.copyWith(color: const Color(0xFFD97706)),
                      ).margin(top: MgSizes.sm, left: MgSizes.md),
                    ),
                  ],
                ),
              ],
            ).margin(top: MgSizes.lg, horizontal: MgSizes.md),
            Gaps.h20,
            Container(
              width: double.infinity,
              height: MgSizes.size10,
              color: NewColorScheme.gray13,
            ),
            Gaps.h12,
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                left: MgSizes.md,
                top: MgSizes.xs,
                bottom: MgSizes.xs,
              ),
              child: Text(
                '가게 관리',
                style: context.textTheme.bodyMedium?.copyWith(color: NewColorScheme.gray6),
              ).semibold(),
            ),
            _buildMenuRow(
              context: context,
              icon: BaseSvgIcon.review(size: MgSizes.size24),
              title: '리뷰 관리',
              onTap: () => Navigator.of(context).pop('review'),
            ),
            _buildMenuRow(
              context: context,
              icon: BaseSvgIcon.storeInfo(size: MgSizes.size24),
              title: '상품 수정',
              onTap: (){
                if (store == null || store.goodsList.isEmpty) return;
                GoodsEditRoute(
                  $extra: {
                    "goods": store.goodsList[0],
                    "goodsImageList": store.goodsImageList,
                  },
                ).push(context);
              },
            ),
            Gaps.h12,
            Container(
              width: double.infinity,
              height: 1,
              color: const Color(0xFFEEEFF4),
            ),
            Gaps.h12,
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                left: MgSizes.md,
                top: MgSizes.xs,
                bottom: MgSizes.xs,
              ),
              child: Text(
                '운영 가이드',
                style: context.textTheme.bodyMedium?.copyWith(color: NewColorScheme.gray6),
              ).semibold(),
            ),
            for (var i = 0; i < _faqItems.length; i++)
              _buildFaqRow(
                context: context, 
                index: i,
                question: _faqItems[i].$1,
                answer: _faqItems[i].$2,
              ),
            Gaps.h12,
            Container(
              width: double.infinity,
              height: 1,
              color: const Color(0xFFEEEFF4),
            ),
            Gaps.h12,
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                left: MgSizes.md,
                top: MgSizes.xs,
                bottom: MgSizes.xs,
              ),
              child: Text(
                '계정 관리',
                style: context.textTheme.bodyMedium?.copyWith(color: NewColorScheme.gray6),
              ).semibold(),
            ),
            _buildMenuRow(
              context: context,
              title: '로그아웃',
              showChevron: false,
              onTap: () => showOwnerMypageConfirmDialog(
                context: context, 
                title: '로그아웃', 
                message: '정말 로그아웃 하시겠어요?', 
                onConfirm: () => logout(ref, context, showAlertDialog: false)),
            ),
            _buildMenuRow(
              context: context,
              title: '회원 탈퇴',
              showChevron: false,
              onTap: () => showOwnerMypageConfirmDialog(
                context: context, 
                title: '회원탈퇴', 
                message: '정말 회원탈퇴 하시겠어요?', 
                onConfirm: () => withDraw(ref, context, showAlertDialog: false),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuRow({
    required BuildContext context,
    Widget? icon,
    required String title, 
    required VoidCallback onTap,
    bool showChevron = true,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        color: NewColorScheme.gray14,
        child: Row(
          children: [
            if (icon != null) ...[icon, Gaps.w8],
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: context.textTheme.bodyLarge?.copyWith(color: NewColorScheme.gray2),
                  ).medium(),
                  if (showChevron) BaseSvgIcon.chevronRightGray(size: MgSizes.size20),
                ],
              ),
            ),
          ],
        ).margin(horizontal: MgSizes.md, vertical: 15)
      ),
    );
  }

  Widget _buildFaqRow({
    required BuildContext context,
    required int index,
    required String question,
    required String answer,
  }) {
    final isExpanded = _expandedFaqIndices.contains(index);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isExpanded) {
            _expandedFaqIndices.remove(index);
          } else {
            _expandedFaqIndices.add(index);
          }
        });
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isExpanded ? NewColorScheme.gray13 : NewColorScheme.gray14,
          border: isExpanded
              ? Border.symmetric(
              horizontal: BorderSide(width: 0.6, color: NewColorScheme.gray11),
            )
          : null,
        ),
      padding: isExpanded
          ? const EdgeInsets.only(top: MgSizes.md, right: MgSizes.md, bottom: MgSizes.xxl, left: MgSizes.md)
          : EdgeInsets.symmetric(horizontal: MgSizes.md, vertical: 15),
      child: isExpanded
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        question,
                        style: context.textTheme.bodyLarge?.copyWith(color: NewColorScheme.gray2),
                      ).semibold(),
                    ),
                    BaseSvgIcon.upNew(size: MgSizes.size20),
                  ],
                ),
                Gaps.h4,
                Container (
                  padding: const EdgeInsets.all(MgSizes.xs),
                  child: Text(
                    answer,
                    style: context.textTheme.labelMedium?.copyWith(fontSize: 13, letterSpacing: 13 * -0.025, color: NewColorScheme.gray4,),
                  ),
                ),
                Gaps.h8,
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildFeedbackChip(
                        context: context,
                        icon: BaseSvgIcon.satisfiedService(size: 14),
                        text: '이해하기 쉬워요',
                        width: 114,
                      ),
                      Gaps.w8,
                      _buildFeedbackChip(
                        context: context,
                        icon: BaseSvgIcon.unsatisfiedService(size: 14),
                        text: '추가 설명이 필요해요',
                        width: 137,
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    question,
                    style: context.textTheme.bodyLarge?.copyWith(color: NewColorScheme.gray2),
                  ).medium(),
                ),
                BaseSvgIcon.chevronDownGray(size: MgSizes.size20),
              ],
            ),
      ),
    );
  }
}

Widget _buildFeedbackChip({
  required BuildContext context,
  required Widget icon,
  required String text,
  required double width,
}) {
  return Container(
    width: width,
    height: MgSizes.xxxl,
    decoration: BoxDecoration(
      color: NewColorScheme.gray14,
      borderRadius: BorderRadius.circular(MgRadius.full),
      border: Border.all(width: 1, color: NewColorScheme.gray9),
    ),
    child: Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          Gaps.w4,
          Text(
            text,
            style: context.textTheme.bodySmall?.copyWith(color: NewColorScheme.gray4),
          ),
        ],
      ),
    ),
  );
}