import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/core/config/environment.dart';
import 'package:magambell/src/core/navigator/navigator_controller.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';
import 'package:magambell/src/features/order/data/repositories/order_repository.dart';
import 'package:magambell/src/features/order/presentation/order_pay_screen.controller.dart';
import 'package:magambell/src/features/order/presentation/widget/order_complete_bottom_sheet.dart';
import 'package:magambell/src/widgets/mg_bottomsheet.dart';
import 'package:magambell/src/widgets/toast_presentor.dart';
import 'package:portone_flutter/model/payment_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'portone_payment_screen.controller.freezed.dart';
part 'portone_payment_screen.controller.g.dart';

@freezed
class PortOnePaymentState with _$PortOnePaymentState {
  const factory PortOnePaymentState({
    required String storeId,
    required String merchantUid,
    required int amount,
    @Default(false) bool isProcessing,
    String? error,
  }) = _PortOnePaymentState;
}

@riverpod
class PortOnePaymentScreenController extends _$PortOnePaymentScreenController {
  @override
  PortOnePaymentState build({
    required String storeId,
    required String merchantUid,
    required int amount,
  }) {
    return PortOnePaymentState(
      storeId: storeId,
      merchantUid: merchantUid,
      amount: amount,
    );
  }

  /// ✔︎ 1) data 생성 함수
  PaymentData buildPaymentData() {
    final orderForm = ref.read(orderPayScreenControllerProvider(state.storeId));

    return PaymentData(
      pg: Environment.portonePG, // 환경별 MID 포함
      payMethod: 'card', // V1 API: 간편결제도 'card'로 처리
      merchantUid: state.merchantUid,
      amount: state.amount,
      appScheme: "bitepick",
      name: '${orderForm.storeName} 바이트백', // TODO:[payment] id 노출 안되도록 임시 변경
      // '${orderForm.storeId}_${orderForm.storeName}_${orderForm.goodsId}',
      buyerTel: '', // TODO : 현재 mypage 정보 조회 API에서 반환되지 않으므로 추가해야함
      digital: false,
    );
  }

  /// ✔︎ 2) callback 처리
  Future<void> handlePaymentCallback(
    BuildContext context,
    Map<String, String> result,
  ) async {
    talker.info("결제 결과: $result");
    if (result["error_code"] == "F400") {
      ToastPresentor.error(context, "결제를 취소했습니다");
      context.pop(); // TODO: 상품 화면 바깥으로 이동하면 될지?
      return;
    }

    if (state.isProcessing) return;
    state = state.copyWith(isProcessing: true);

    try {
      final impUid = result["imp_uid"];

      if (impUid == null) {
        talker.error("결제 실패: $result");
        ToastPresentor.error(context, result["error_msg"] ?? "결제 실패");
        context.pop();
        return;
      }

      talker.info("결제 서버 검증 시작");

      // PortOne에서 반환받은 paymentId는 우리가 보낸 merchantUid
      await ref
          .read(orderRepositoryProvider)
          .completePayment(paymentId: state.merchantUid);

      ToastPresentor.success(context, "결제가 완료되었습니다.");

      ref.invalidate(userOrdersProvider());
      ref.read(navigatorControllerProvider.notifier).changeTabIndex(1);
      DefaultRoute().go(context);
      // TODO: 에러 수정 필요
      //  showBottomSheet(
      //   context: context,
      //   builder: (context) {
      //     return OrderCompleteBottomSheet();
      //   },
      // );
      
    } catch (e, st) {
      talker.error("결제 오류: $e\n$st");
      ToastPresentor.error(context, "결제 검증 실패");
      context.pop();
    } finally {
      state = state.copyWith(isProcessing: false);
    }
  }
}
