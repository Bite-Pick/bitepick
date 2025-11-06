import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/constants.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/price_extension.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/order/presentation/order_pay_screen.controller.dart';
import 'package:magambell/src/features/order/presentation/widget/order_info_item.dart';
import 'package:magambell/src/widgets/agreement_section.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_button.dart';

class OrderPayRoute extends GoRouteData {
  const OrderPayRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const OrderPayScreen();
  }
}

class OrderPayScreen extends ConsumerStatefulWidget {
  const OrderPayScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderPayScreenState();
}

class _OrderPayScreenState extends ConsumerState<OrderPayScreen> {
  bool _allAgreed = false;

  @override
  Widget build(BuildContext context) {
    // Controller에서 주문 정보 가져오기
    final orderInfo = ref.watch(orderPayScreenControllerProvider);

    // TODO: 실제 상품 정보 가져오기 (goodsId로 조회)
    final storeName = '가게명';
    final storeAddress = '경상북도 경산시 백자로 76 3층';
    final pickupTime = '오늘 7:00';
    final double originalPrice = orderInfo.originalPrice;
    final double salePrice = orderInfo.salePrice;
    final double discount = orderInfo.discount;
    final quantity = orderInfo.quantity;
    final totalPrice = orderInfo.totalPrice;

    return BaseScaffold(
      appBar: BaseAppBar(),
      backgroundColor: MgColorScheme.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.h12,
                  // TODO: 픽업시간, 메모 입력 UI 추가
                  _buildOrderItemInfoCard(
                    pickupTime,
                    storeAddress,
                    salePrice,
                    quantity,
                    pickupTime,
                  ).margin(horizontal: MgSizes.md),
                  Divider(thickness: 6).margin(vertical: MgSizes.lg),
                  _buildPaySection().margin(horizontal: MgSizes.md),
                  Divider(thickness: 6).margin(vertical: MgSizes.lg),
                  _buildPriceInfoSection(
                    originalPrice,
                    discount,
                    totalPrice,
                    quantity,
                  ).margin(horizontal: MgSizes.md),
                  Divider(thickness: 6).margin(vertical: MgSizes.lg),
                  _buildAgreementSection().margin(horizontal: MgSizes.md),
                ],
              ),
            ),
          ),
          // 결제 버튼
          MgButton(
            onPressed: () async {
              if (!_allAgreed) {
                context.showFlash(
                  duration: const Duration(milliseconds: 2000),
                  builder: (context, controller) {
                    return FlashBar(
                      controller: controller,
                      content: Text("모든 약관에 동의해 주세요."),
                    );
                  },
                );
                return;
              }
              // TODO: 결제 로직 추가
              context.showFlash(
                duration: const Duration(milliseconds: 2000),
                builder: (context, controller) {
                  return FlashBar(
                    controller: controller,
                    content: Text("결제 기능 구현중"),
                  );
                },
              );
            },
            content: Text('${totalPrice.toPrice()}원 결제하기'),
          ).primary().margin(
            horizontal: MgSizes.md,
            bottom: MgSizes.xxl,
            top: MgSizes.md,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title).md().bold();
  }

  Widget _buildOrderItemInfoCard(
    String storeName,
    String storeAddress,
    double salePrice,
    int quantity,
    String time,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 주문 정보 섹션
        _buildSectionTitle('주문 정보'),
        Gaps.h4,
        Text('픽업 예정 시간을 꼭 지켜서 와주세요').sm().textGray(),
        Gaps.h16,
        _buildOrderItemCard(
          storeName: storeName,
          address: storeAddress,
          discount: 50,
          price: salePrice * quantity,
          count: quantity,
        ),
      ],
    );
  }

  Widget _buildOrderItemCard({
    required String storeName,
    required String address,
    required double discount,
    required double price,
    required int count,
    String time = '오후 7:00',
  }) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$time 픽업 예정')
                .md()
                .bold()
                .margin(vertical: MgSizes.size10, horizontal: MgSizes.md)
                .constrained(width: double.infinity)
                .colored(MgColorScheme.lightest),
            OrderInfoItem(
              imageUrl: mockImage,
              storeName: storeName,
              address: address,
              discount: discount,
              price: price,
              count: count,
              imageSize: 80,
            ).margin(all: MgSizes.md),
          ],
        )
        .margin(all: 2) //
        .clipRRect()
        .decorated(
          border: Border.all(color: MgColorScheme.gray8),
          borderRadius: BorderRadius.circular(MgRadius.md),
        );
  }

  Widget _buildPriceRow(String label, double price) {
    final isDiscount = price < 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label).md().textGray(),
        Text('${price.toPrice()}원').md().textGray(),
      ],
    );
  }

  Widget _buildPaySection() {
    return Column(
      children: [
        // 결제 수단 섹션
        _buildSectionTitle('결제 수단'),
        Gaps.h12,
        // TODO: 결제 수단 선택 UI 추가
      ],
    );
  }

  Widget _buildPriceInfoSection(
    double originalPrice,
    double discountPrice,
    double totalPrice,
    int quantity,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionTitle('총 결제 금액'),
            Text(
              '${totalPrice.toPrice()}원',
            ).lg().bold().textColor(MgColorScheme.subpointRed),
          ],
        ),
        _buildPriceRow(
          '상품 금액',
          originalPrice * quantity,
        ).margin(top: MgSizes.sm, bottom: MgSizes.xs),
        _buildPriceRow('할인 금액', discountPrice * quantity * -1),
      ],
    );
  }

  Widget _buildAgreementSection() {
    return AgreementSection(
      items: const [
        AgreementItem(text: '개인정보 수집 및 이용 동의 (필수)', link: PRIAVCY_POLICY),
        AgreementItem(
          text: '개인정보 제3자 정보 제공 동의 (필수)',
          link: 'https://example.com/third-party', // TODO[asset]:  제3자 정보 제공
        ),
        AgreementItem(
          text: '결제대행 서비스 이용약관 동의 (필수)',
          link:
              'https://example.com/payment-terms', // TODO[asset]:  결제대행 서비스 이용약관
        ),
      ],
      allAgreeText: '주문내용 확인 및 결제 동의',
      onAllAgreedChanged: (allAgreed) {
        setState(() => _allAgreed = allAgreed);
      },
    );
  }
}
