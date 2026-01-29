import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/features/order/presentation/portone_payment_screen.controller.dart';
import 'package:portone_flutter_v2/portone_flutter_v2.dart';

class PortOnePaymentRoute extends GoRouteData {
  const PortOnePaymentRoute({
    required this.storeId,
    required this.paymentId,
    required this.amount,
  });

  final String storeId;
  final String paymentId;
  final int amount;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PortOnePaymentScreen(
      storeId: storeId,
      paymentId: paymentId,
      amount: amount,
    );
  }
}

class PortOnePaymentScreen extends ConsumerWidget {
  const PortOnePaymentScreen({
    super.key,
    required this.storeId,
    required this.paymentId,
    required this.amount,
  });

  final String storeId;
  final String paymentId;
  final int amount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = portOnePaymentScreenControllerProvider(
      storeId: storeId,
      paymentId: paymentId,
      amount: amount,
    );

    final controller = ref.read(provider.notifier);

    return PortonePayment(
      data: controller.buildPaymentRequest(),
      callback: (response) {
        // V2: PaymentResponse에서 에러 여부 확인
        if (response.code != null) {
          // 에러가 있는 경우
          controller.handlePaymentError(
            context,
            Exception('${response.code}: ${response.message}'),
            null,
          );
        } else {
          // 성공
          controller.handlePaymentSuccess(context, response);
        }
      },
      onError: (error, stackTrace) {
        controller.handlePaymentError(context, error, stackTrace);
      },
      initialChild: Container(
        color: MgColorScheme.gray11,
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
