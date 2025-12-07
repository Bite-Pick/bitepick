import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/core/config/environment.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/features/order/presentation/portone_payment_screen.controller.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:portone_flutter/iamport_payment.dart' show IamportPayment;

class PortOnePaymentRoute extends GoRouteData {
  const PortOnePaymentRoute({
    required this.merchantUid,
    required this.amount,
  });

  final String merchantUid;
  final int amount;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PortOnePaymentScreen(
      merchantUid: merchantUid,
      amount: amount,
    );
  }
}

class PortOnePaymentScreen extends ConsumerStatefulWidget {
  const PortOnePaymentScreen({
    super.key,
    required this.merchantUid,
    required this.amount,
  });

  final String merchantUid;
  final int amount;

  @override
  ConsumerState<PortOnePaymentScreen> createState() =>
      _PortOnePaymentScreenState();
}

class _PortOnePaymentScreenState extends ConsumerState<PortOnePaymentScreen> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final provider = portOnePaymentScreenControllerProvider(
      merchantUid: widget.merchantUid,
      amount: widget.amount,
    );

    final controller = ref.read(provider.notifier);
    // final state = ref.watch(provider);
    return BaseScaffold(
      appBar: BaseAppBar(title: const Text('결제')),
      body: _isProcessing
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('결제 처리 중...'),
                ],
              ),
            )
          : IamportPayment(
              initialChild: Container(
                color: MgColorScheme.white,
                child: const Center(child: CircularProgressIndicator()),
              ),
              userCode: Environment.portoneIMPCode,
              data: controller.buildPaymentData(),
              callback: (result) =>
                  controller.handlePaymentCallback(context, result),
            ),
    );
  }
}
