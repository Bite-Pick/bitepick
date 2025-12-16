import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/constants/constants.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/datetime_extension.dart';
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
    final int originalPrice = orderInfo.originalPrice;
    final int salePrice = orderInfo.salePrice;
    final int discount = orderInfo.discount;
    final quantity = orderInfo.quantity;
    final totalPrice = orderInfo.totalPrice;
    final storeAddress = orderInfo.storeAddress;
    final pickupTime = orderInfo.pickupTime;
    final storeName = orderInfo.storeName;

    return BaseScaffold(
      appBar: BaseAppBar(),
      backgroundColor: MgColorScheme.gray11,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.h12,
                  _buildOrderItemInfoCard(
                    storeName,
                    storeAddress,
                    salePrice,
                    quantity,
                    pickupTime,
                    (salePrice * 100 / originalPrice).toInt(),
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
                    final merchantUid = await ref
                        .read(orderPayScreenControllerProvider.notifier)
                        .submitOrder();

                    if (merchantUid == null) {
                      ToastPresentor.error(context, '주문 정보를 불러오는데 실패했습니다.');
                      return;
                    }

                    // 결제 화면으로 이동
                    PortOnePaymentRoute(
                      merchantUid: merchantUid,
                      // orderName: '${widget.storeId} test', // TODO: 실제 orderName 생성
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

  Widget _buildSectionTitle(String title) {
    return Text(title).md().bold();
  }

  Widget _buildOrderItemInfoCard(
    String storeName,
    String storeAddress,
    int salePrice,
    int quantity,
    String? pickupTime,
    int discount,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 주문 정보 섹션
        _buildSectionTitle('주문 정보'),
        Gaps.h4,
        Text('픽업 예정 시간을 꼭 지켜서 와주세요').sm().textGray(),
        Gaps.h16,
        // TODO: 픽업시간 드롭다운 추가
        _buildOrderItemCard(
          storeName: storeName,
          address: storeAddress,
          discount: discount,
          price: salePrice * quantity,
          count: quantity,
          pickupTime: pickupTime,
        ),
      ],
    );
  }

  Widget _buildOrderItemCard({
    required String storeName,
    required String address,
    required int discount,
    required int price,
    required int count,
    String? pickupTime,
  }) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPickupTimeSection(pickupTime),

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

  Widget _buildPickupTimeSection(String? pickupTime) {
    final orderInfo = ref.watch(orderPayScreenControllerProvider);
    final startTime = orderInfo.startTime;
    final endTime = orderInfo.endTime;
    return GestureDetector(
      onTap: () async {
        final selectedTime = await showTimeSelector(startTime, endTime);
        if (selectedTime != null) {
          ref
              .read(orderPayScreenControllerProvider.notifier)
              .updatePickupTime(selectedTime.toIso8601String());
        }
      },
      child: pickupTime == null
          ? Row(
              children: [
                Expanded(child: Text('픽업시간 설정').sm().textGray()),
                BaseSvgIcon.down(),
              ],
            ).padding(horizontal: MgSizes.lg, vertical: MgSizes.sm)
          : Text('${pickupTime.convertTime()} 픽업 예정')
                .md()
                .bold()
                .margin(vertical: MgSizes.size10, horizontal: MgSizes.md)
                .constrained(width: double.infinity)
                .colored(MgColorScheme.primaryLightest),
    );
  }

  Future<DateTime?> showTimeSelector(
    DateTime startTime,
    DateTime endTime,
  ) async {
    DateTime? _time;
    await TimePickerBottomSheet.show(
      context,
      initialTime: DateTime.now(),
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
            Text(
              '${totalPrice.toPrice()}원',
            ).lg().bold().textColor(MgColorScheme.systemError),
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
        AgreementItem(text: '개인정보 제3자 정보 제공 동의 (필수)', link: GUEST_SERVICE_TERM),
      ],
      allAgreeText: '주문내용 확인 및 결제 동의',
      onAllAgreedChanged: (allAgreed) {
        setState(() => _allAgreed = allAgreed);
      },
    );
  }
}
