import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/constants/constants.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/price_extension.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/goods/presentation/widgets/time_picker_bottomsheet.dart';
import 'package:magambell/src/features/order/presentation/order_pay_screen.controller.dart';
import 'package:magambell/src/features/order/presentation/portone_payment_screen.dart';
import 'package:magambell/src/features/order/presentation/widget/order_info_item.dart';
import 'package:magambell/src/widgets/agreement_section.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:magambell/src/widgets/toast_presentor.dart';

class OrderPayRoute extends GoRouteData {
  const OrderPayRoute({required this.storeId});

  final String storeId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return OrderPayScreen(storeId: storeId);
  }
}

class OrderPayScreen extends ConsumerStatefulWidget {
  const OrderPayScreen({super.key, required this.storeId});

  final String storeId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderPayScreenState();
}

class _OrderPayScreenState extends ConsumerState<OrderPayScreen> {
  bool _allAgreed = false;

  @override
  Widget build(BuildContext context) {
    // Controller에서 주문 정보 가져오기
    final orderInfo = ref.watch(
      orderPayScreenControllerProvider(widget.storeId),
    );

    // TODO: 실제 상품 정보 가져오기 (goodsId로 조회)
    final int originalPrice = orderInfo.originalPrice;
    final int salePrice = orderInfo.salePrice;
    final int discount = orderInfo.discount;
    final quantity = orderInfo.quantity;
    final totalPrice = orderInfo.totalPrice;
    final storeAddress = orderInfo.storeAddress;
    final pickupTime = orderInfo.pickupTime;
    final storeName = orderInfo.storeName;
    final startTime = orderInfo.startTime;
    final endTime = orderInfo.endTime;

    return BaseScaffold(
      appBar: BaseAppBar(title: Text('주문서')),
      backgroundColor: MgColorScheme.gray11,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(thickness: 1, color: MgColorScheme.gray10).margin(bottom: MgSizes.xl),
                  _buildOrderItemInfoCard().margin(horizontal: MgSizes.md),
                  _buildOrderItemCard(
                    storeName: storeName,
                    address: storeAddress,
                    discount: ((originalPrice - salePrice) / originalPrice * 100).round(),
                    price: salePrice * quantity,
                    count: quantity,
                  ).margin(horizontal: MgSizes.md),

                  Divider(
                    thickness: 6,
                    color: MgColorScheme.gray10,
                  ).margin(vertical: MgSizes.xxl),
                  _buildPickupSection(
                    pickupTime: pickupTime,
                    startTime: startTime,
                    endTime: endTime,
                  ).margin(horizontal: MgSizes.md),

                  Divider(
                    thickness: 6,
                    color: MgColorScheme.gray10,
                  ).margin(vertical: MgSizes.xxl),
                  // NOTE: 결제 수단이 1개밖에 없어서 임시 주석 처리
                  // _buildPaySection().margin(horizontal: MgSizes.md),
                  // Divider(thickness: 6).margin(vertical: MgSizes.lg),
                  _buildPriceInfoSection(
                    originalPrice,
                    discount,
                    totalPrice,
                    quantity,
                  ).margin(horizontal: MgSizes.md),
                  Divider(
                    thickness: 6,
                    color: MgColorScheme.gray10,
                  ).margin(vertical: MgSizes.xxl),
                  _buildAgreementSection().margin(horizontal: MgSizes.md),
                  Divider(
                    thickness: 2,
                    color: MgColorScheme.gray10,
                  ).margin(vertical: MgSizes.xxl),
                  _buildNoticeCard().margin(horizontal: MgSizes.md),
                ],
              ),
            ),
          ),
          // 결제 버튼
          MgButton(
            onPressed: orderInfo.isSubmitting
                ? null
                : () async {
                    if (!_allAgreed) {
                      ToastPresentor.error(context, "모든 약관에 동의해 주세요");
                      return;
                    }
                    if (pickupTime == null) {
                      ToastPresentor.error(context, "픽업 시간을 설정해 주세요");
                      return;
                    }

                    // 주문 등록 (결제 전)
                    final paymentId = await ref
                        .read(
                          orderPayScreenControllerProvider(
                            widget.storeId,
                          ).notifier,
                        )
                        .submitOrder();

                    if (paymentId == null) {
                      ToastPresentor.error(context, '주문 정보를 불러오는데 실패했습니다.');
                      return;
                    }

                    // 결제 화면으로 이동 (V2 SDK)
                    PortOnePaymentRoute(
                      storeId: widget.storeId,
                      paymentId: paymentId,
                      amount: totalPrice,
                    ).push(context);
                  },
            content: orderInfo.isSubmitting
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text('${totalPrice.toPrice()}원 결제하기'),
          ).primary().margin(
            horizontal: MgSizes.md,
            bottom: MgSizes.xxl,
            top: MgSizes.md,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) => Text(title).md().bold();

  Widget _buildOrderItemInfoCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 주문 정보 섹션
        _buildSectionTitle('주문 정보'),
        Gaps.h16,
      ],
    );
  }

  Widget _buildOrderItemCard({
    required String storeName,
    required String address,
    required int discount,
    required int price,
    required int count,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: MgColorScheme.gray8),
        borderRadius: BorderRadius.circular(MgRadius.md),
      ),
      child: OrderInfoItem(
        imageUrl: mockImage,
        storeName: storeName,
        address: address,
        discount: discount,
        price: price,
        count: count,
        imageSize: 80,
      ).margin(all: MgSizes.md),
    );
  }

  Widget _buildPickupSection({
    required String? pickupTime,
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildSectionTitle('픽업 시간'),
          ],
        ),
        Gaps.h12,
        GestureDetector(
          onTap: () async {
            final selectedTime = await showTimeSelector(startTime, endTime);
            if (selectedTime != null) {
              ref
                  .read(orderPayScreenControllerProvider(widget.storeId).notifier)
                  .updatePickupTime(selectedTime.toIso8601String());
            }
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: MgColorScheme.gray8),
              borderRadius: BorderRadius.circular(MgRadius.md),
            ),
            child: Row(
              children: [
                BaseSvgIcon.filledTime(size: 18),
                Gaps.w8,
                Expanded(
                  child: pickupTime == null
                      ? Text('픽업 시간을 선택해주세요.')
                      : Text(TimePickerBottomSheet.formatSelectedTime(DateTime.tryParse(pickupTime) ?? DateTime.now())).bold().textColor(const Color(0xFF3385FF)),
                ),
                BaseSvgIcon.right(),
              ],
            ).padding(horizontal: MgSizes.md, vertical: MgSizes.sm),
          ),
        ),
      ],
    );
  }

  Future<DateTime?> showTimeSelector(
    DateTime startTime,
    DateTime endTime,
    // DateTime initialTime,
  ) async {
    DateTime? _time;
    await TimePickerBottomSheet.show(
      context,
      // initialTime: initialTime,
      startTime: startTime,
      endTime: endTime,
      onTimeSelected: (selected, error) {
        if (error != null) {
          // 이론상 disabled라 안 들어오지만, 안전망으로 남겨둘 수 있음
          ToastPresentor.error(context, error);
          return;
        }

        // 정상 처리
        _time = selected;
      },
      // onSelectionChanged: (selected, errorMessage) {
      //   if (errorMessage != null) ToastPresentor.error(context, errorMessage);
      // },
    );
    return _time;
  }

  Widget _buildPriceRow(String label, int price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label).textGray(),
        Text('${price.toPrice()}원').textGray(),
      ],
    );
  }

  Widget _buildPaySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 결제 수단 섹션
        _buildSectionTitle('결제 수단'),
        Gaps.h12,
        // TODO: 버튼이 아니라 선택되어있는 것처럼 보여야할 듯
        MgButton(
          onPressed: () {},
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                R.ASSETS_IMAGES_TOSS_PAYMENTS_PNG,
                height: MgSizes.lg,
              ),
              Gaps.w8,
              Text("토스페이").bold().md(),
            ],
          ),
          borderColor: MgColorScheme.gray8,
        ),
      ],
    );
  }

  Widget _buildPriceInfoSection(
    int originalPrice,
    int discountPrice,
    int totalPrice,
    int quantity,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionTitle('총 결제 금액'),
            Text('${totalPrice.toPrice()}원').lg().bold(),
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

  Widget _buildNoticeCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F8),
        borderRadius: BorderRadius.circular(MgRadius.md),
      ),
      padding: EdgeInsets.all(MgSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('예약이 확정되면 알려드릴게요!').bold(),
          Gaps.h4,
          Text(
            '픽업 예정 시간에 맞춰 매장을 방문해주세요',
          ).sm().textColor(const Color(0xFF989BA2)),
        ],
      ),
    );
  }

  Widget _buildAgreementSection() {
    return AgreementSection(
      items: const [
        AgreementItem(text: '개인정보 수집 및 이용 동의 (필수)', link: PRIAVCY_POLICY),
        AgreementItem(text: '개인정보 제3자 정보 제공 동의 (필수)', link: GUEST_SERVICE_TERM),
        // AgreementItem(text: '결제대행 서비스 이용약관 동의 (필수)', link: link)
      ],
      allAgreeText: '주문내용 확인 및 결제 동의',
      onAllAgreedChanged: (allAgreed) {
        setState(() => _allAgreed = allAgreed);
      },
    );
  }
}
