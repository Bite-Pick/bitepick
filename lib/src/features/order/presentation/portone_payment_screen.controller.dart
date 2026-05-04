import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/services/analytics_service.dart';
import 'package:magambell/src/core/config/environment.dart';
import 'package:magambell/src/core/navigator/navigator_controller.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';
import 'package:magambell/src/features/order/data/repositories/order_repository.dart';
import 'package:magambell/src/features/order/presentation/order_pay_screen.controller.dart';
import 'package:magambell/src/features/order/presentation/widget/order_complete_bottom_sheet.dart';
import 'package:magambell/src/widgets/toast_presentor.dart';
import 'package:portone_flutter_v2/portone_flutter_v2.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'portone_payment_screen.controller.freezed.dart';
part 'portone_payment_screen.controller.g.dart';

@freezed
class PortOnePaymentState with _$PortOnePaymentState {
  const factory PortOnePaymentState({
    required String storeId,
    required String paymentId,
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
    required String paymentId,
    required int amount,
  }) {
    return PortOnePaymentState(
      storeId: storeId,
      paymentId: paymentId,
      amount: amount,
    );
  }

  /// V2 PaymentRequest 생성
  PaymentRequest buildPaymentRequest() {
    final orderForm = ref.read(orderPayScreenControllerProvider(state.storeId));

    return PaymentRequest(
      storeId: Environment.portoneStoreId,
      paymentId: state.paymentId,
      orderName: '${orderForm.storeName} 바이트백',
      totalAmount: state.amount,
      currency: PaymentCurrency.KRW,
      channelKey: Environment.portoneChannelKey,
      payMethod: PaymentPayMethod.card,
      appScheme: 'bitepick',
      redirectUrl: 'bitepick://payment/complete',
    );
  }

  /// V2 결제 성공 콜백
  Future<void> handlePaymentSuccess(
    BuildContext context,
    PaymentResponse response,
  ) async {
    talker.info("결제 성공: paymentId=${response.paymentId}, txId=${response.transactionId}");

    if (state.isProcessing) return;
    state = state.copyWith(isProcessing: true);

    try {
      talker.info("결제 서버 검증 시작 - paymentId: ${response.paymentId}");

      final res = await ref
          .read(orderRepositoryProvider)
          .completePayment(paymentId: response.paymentId);

      if (!res) {
        talker.error("결제 검증 실패");
        ToastPresentor.error(context, "결제 검증에 실패했습니다");
        ref
            .read(orderPayScreenControllerProvider(state.storeId).notifier)
            .resetMerchantUid();
        context.pop();
        return;
      }

      final orderForm = ref.read(orderPayScreenControllerProvider(state.storeId));
      AnalyticsService().logPurchase(
        transactionId: response.paymentId,
        storeId: state.storeId,
        goodsId: orderForm.goodsId,
        storeName: orderForm.storeName,
        amount: state.amount,
        quantity: orderForm.quantity,
      );

      ref.invalidate(userOrdersProvider());

      // 결제 성공 시 화면 전환
      ref.read(navigatorControllerProvider.notifier).changeTabIndex(1);
      DefaultRoute().go(context);

      // 화면 전환 후 bottomSheet 표시
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final currentContext = GlobalVariable.navigatorKey.currentContext;
        if (currentContext != null) {
          showModalBottomSheet(
            context: currentContext,
            builder: (bottomSheetContext) {
              return OrderCompleteBottomSheet(
                onConfirm: () => Navigator.pop(bottomSheetContext),
              );
            },
          );
        }
      });
    } catch (e, st) {
      talker.error("결제 오류: $e\n$st");
      ToastPresentor.error(context, "결제 검증 실패");
      ref
          .read(orderPayScreenControllerProvider(state.storeId).notifier)
          .resetMerchantUid();
      context.pop();
    } finally {
      state = state.copyWith(isProcessing: false);
    }
  }

  /// V2 결제 에러 콜백
  void handlePaymentError(BuildContext context, Object error, StackTrace? stackTrace) {
    talker.error("결제 에러: $error", error, stackTrace);
    ToastPresentor.error(context, "결제에 실패했습니다");
    ref
        .read(orderPayScreenControllerProvider(state.storeId).notifier)
        .resetMerchantUid();
    context.pop();
  }
}
