import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';
import 'package:magambell/src/features/order/data/repositories/order_repository.dart';
import 'package:magambell/src/features/order/domain/entities/payment_method.dart';
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
    required String merchantUid,
    required int amount,
  }) {
    return PortOnePaymentState(merchantUid: merchantUid, amount: amount);
  }

  /// ✔︎ 1) data 생성 함수
  PaymentData buildPaymentData() {
    return PaymentData(
      pg: PaymentCompany.toss.displayName,
      payMethod: PaymentMethod.easyPay.displayName,
      merchantUid: state.merchantUid,
      amount: state.amount,
      appScheme: "magambell",
      buyerTel: '', // TODO: 왜 필요한지..?
    );
  }

  /// ✔︎ 2) callback 처리
  Future<void> handlePaymentCallback(
    BuildContext context,
    Map<String, String> result,
  ) async {
    talker.info("결제 결과: $result");

    if (state.isProcessing) return;
    state = state.copyWith(isProcessing: true);

    try {
      final success = result["imp_success"] == "true";
      final impUid = result["imp_uid"];

      if (!success || impUid == null) {
        talker.error("결제 실패: $result");

        ToastPresentor.error(context, result["error_msg"] ?? "결제 실패");

        context.pop();
        return;
      }

      talker.info("결제 서버 검증 시작");

      await ref
          .read(orderRepositoryProvider)
          .completePayment(impUid: impUid, merchantUid: state.merchantUid);

      ToastPresentor.success(context, "결제가 완료되었습니다.");
      // TODO: 검토 필요
      MainRoute().go(context);
    } catch (e, st) {
      talker.error("결제 오류: $e\n$st");
      ToastPresentor.error(context, "결제 검증 실패");
      context.pop();
    } finally {
      state = state.copyWith(isProcessing: false);
    }
  }
}
