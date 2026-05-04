import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/constants.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/order/presentation/order_pay_screen.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/mg_button.dart';

class OrderCautionRoute extends GoRouteData {
  const OrderCautionRoute({required this.storeId});

  final String storeId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return OrderCautionScreen(storeId: storeId);
  }
}

class OrderCautionScreen extends StatefulWidget {
  const OrderCautionScreen({super.key, required this.storeId});

  final String storeId;

  @override
  State<OrderCautionScreen> createState() => _OrderCautionScreenState();
}

class _OrderCautionScreenState extends State<OrderCautionScreen> {
  bool _isChecked = false;
  final Set<int> _expandedItems = {};

  static const _cautionItems = [
    _CautionItem(
      prefix: '예약은 픽업 시작 ',
      highlight: '35분 전',
      suffix: '에 확정돼요',
      subtitle: '재고가 소진되면 예약이 자동 취소될 수 있어요.\n다만 픽업 시간에 가까운 주문은 빠르게 확정해 드려요!',
    ),
    _CautionItem(
      title: '주문 수락 알림을 받은 후 출발해 주세요',
      subtitle: '헛걸음하시지 않게 알림 후 출발해 주세요.',
    ),
    _CautionItem(
      title: '매일 구성이 달라지는 랜덤박스예요',
      subtitle: '서비스 특성상 메뉴를 미리 고르거나 요구할 수 없어요.',
    ),
    _CautionItem(
      title: '매장 방문 시 주문 내역을 보여주세요',
      subtitle: '주문 내역 화면을 보여주시면 빠르게 빵을 수령할 수 있어요.',
    ),
  ];

  static const _accordionTitles = ['예약 및 방문 안내', '예약 취소 및 환불 안내'];

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(height: 56),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  _buildTitle(),
                  const SizedBox(height: 32),
                  _buildCautionList(),
                  Gaps.h24,
                  Container(
                    height: 10,
                    width: double.infinity,
                    color: NewColorScheme.gray12,
                  ),
                  Gaps.h24,
                  _buildPrivacyCheckbox(),
                  Gaps.h24,
                  _buildAccordionSection(),
                ],
              ),
            ),
          ),
          _buildBottomButton(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return SizedBox(
      height: 36.h,
      width: double.infinity,
      child: Text(
        '꼭 확인해주세요!',
      ).fontSize(24).bold().height(1.5).margin(horizontal: MgSizes.md),
    );
  }

  Widget _buildCautionList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MgSizes.md),
      child: Column(
        children: List.generate(_cautionItems.length, (i) {
          return _buildCautionItem(
            number: i + 1,
            item: _cautionItems[i],
            isLast: i == _cautionItems.length - 1,
          );
        }),
      ),
    );
  }

  Widget _buildCautionItem({
    required int number,
    required _CautionItem item,
    required bool isLast,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Color(0xFF2C2D30),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text('$number').xs().bold().white(),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F4F5),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
            ],
          ),
          Gaps.w12,
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildItemTitle(item),
                  Gaps.h4,
                  Text(item.subtitle).sm().textGray().height(1.5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemTitle(_CautionItem item) {
    if (item.highlight != null) {
      return RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: MgFontSize.md,
            fontWeight: FontWeight.w700,
            fontFamily: MgFontFamily.bold,
            color: NewColorScheme.gray1,
            height: 1.5,
          ),
          children: [
            if (item.prefix != null) TextSpan(text: item.prefix),
            TextSpan(
              text: item.highlight,
              style: const TextStyle(color: MgColorScheme.primaryHeavy),
            ),
            if (item.suffix != null) TextSpan(text: item.suffix),
          ],
        ),
      );
    }
    return Text(item.title!).md().bold();
  }

  Widget _buildPrivacyCheckbox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MgSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: Checkbox(
                  value: _isChecked,
                  onChanged: (v) => setState(() => _isChecked = v ?? false),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                  activeColor: MgColorScheme.primary,
                  checkColor: MgColorScheme.gray1,
                  side: const BorderSide(color: NewColorScheme.gray5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              Gaps.w8,
              GestureDetector(
                onTap: () => launchUrl(
                  Uri.parse(PRIAVCY_POLICY),
                  mode: LaunchMode.externalApplication,
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(width: 0.7)),
                  ),
                  child: Text('(필수) 개인정보 제 3자 제공 동의').sm().semibold(),
                ),
              ),
            ],
          ),
          Gaps.h8,
          const Text(
            '예약 안내를 위해 매장에 번호가 전달되며, 재고에 따라 먼저 연락드릴 수 있어요.',
            style: TextStyle(
              fontSize: 13,
              color: NewColorScheme.gray6,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccordionSection() {
    return Container(
      width: double.infinity,
      color: NewColorScheme.gray13,
      padding: const EdgeInsets.only(bottom: 160),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 유의사항 섹션 헤더 (height: 60)
          SizedBox(
            height: 60,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: MgSizes.xl),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('유의사항').md().bold(),
              ),
            ),
          ),
          // 아코디언 아이템
          ...List.generate(_accordionTitles.length, (i) {
            return _buildAccordionItem(
              index: i,
              title: _accordionTitles[i],
              isExpanded: _expandedItems.contains(i),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildAccordionItem({
    required int index,
    required String title,
    required bool isExpanded,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: () => setState(() {
            if (isExpanded) {
              _expandedItems.remove(index);
            } else {
              _expandedItems.add(index);
            }
          }),
          child: SizedBox(
            height: 60,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: MgSizes.xl),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title).sm().medium(),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: NewColorScheme.gray5,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          child: isExpanded
              ? SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      MgSizes.xl,
                      0,
                      MgSizes.xl,
                      MgSizes.xl,
                    ),
                    child: _buildAccordionContent(index),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildAccordionContent(int index) {
    if (index == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBulletRich(
            prefix: '예약은 픽업 시작 시간 기준 ',
            bold: '35분 전',
            suffix: '에 확정돼요. (픽업 임박 주문은 5분 내로 빠르게 확정해 드려요!)',
          ),
          Gaps.h8,
          _buildBullet('매장의 실시간 남은 빵 상황에 따라 부득이하게 예약이 취소될 수 있어요.'),
          Gaps.h8,
          _buildBullet('예약이 확정되면 헛걸음하시지 않도록, 꼭 픽업 시간에 맞춰 매장에 방문해 주세요.'),
          Gaps.h8,
          _buildBullet('지정된 픽업 시간 이전이나 이후에 방문하시면 제품 수령이 어려울 수 있어요.'),
        ],
      );
    }
    // index == 1: 예약 취소 및 환불 안내
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBullet('예약이 확정되면 \'픽업 대기\' 상태로 바뀌고, 푸시 알림을 보내드려요.'),
        Gaps.h8,
        _buildBulletRich(
          prefix: '예약이 ',
          bold: '확정되기 전',
          suffix: '에는 앱에서 자유롭게 취소할 수 있고, 결제 금액은 100% 환불돼요.',
        ),
        Gaps.h8,
        _buildBulletRich(
          prefix: '예약이 ',
          bold: '확정된 이후',
          suffix: '에는 매장에서 이미 포장을 준비하고 있으므로 취소 및 환불이 어려워요.',
        ),
        Gaps.h8,
        _buildBullet('고객님의 사정으로 픽업 시간에 늦거나 제품을 수령하지 못하신 경우에도 취소 및 환불이 불가능해요.'),
      ],
    );
  }

  Widget _buildBullet(String text) {
    const style = TextStyle(
      fontSize: MgFontSize.xs,
      color: NewColorScheme.gray5,
      height: 1.6,
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('• ', style: style),
        Expanded(child: Text(text, style: style)),
      ],
    );
  }

  Widget _buildBulletRich({
    required String prefix,
    required String bold,
    required String suffix,
  }) {
    const style = TextStyle(
      fontSize: MgFontSize.xs,
      color: NewColorScheme.gray5,
      height: 1.6,
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('• ', style: style),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: style,
              children: [
                TextSpan(text: prefix),
                TextSpan(
                  text: bold,
                  style: const TextStyle(
                    fontSize: MgFontSize.xs,
                    fontWeight: FontWeight.w700,
                    fontFamily: MgFontFamily.bold,
                    color: NewColorScheme.gray5,
                    height: 1.6,
                  ),
                ),
                TextSpan(text: suffix),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButton() {
    return MgButton(
      onPressed: _isChecked
          ? () async {
              await OrderPayRoute(storeId: widget.storeId).push(context);
            }
          : null,
      content: Text('결제하기'),
      fullWidth: true,
    ).primary().margin(
      horizontal: MgSizes.md,
      top: MgSizes.md,
      bottom: MgSizes.xxl,
    );
  }
}

class _CautionItem {
  const _CautionItem({
    this.title,
    this.prefix,
    this.highlight,
    this.suffix,
    required this.subtitle,
  });

  final String? title;
  final String? prefix;
  final String? highlight;
  final String? suffix;
  final String subtitle;
}
