import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/core/network/api_exception.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';
import 'package:magambell/src/features/order/data/repositories/order_repository.dart';
import 'package:magambell/src/features/order/domain/entities/order_form.dart';
import 'package:magambell/src/features/order/domain/entities/payment_method.dart';
import 'package:magambell/src/widgets/toast_presentor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_pay_screen.controller.freezed.dart';
part 'order_pay_screen.controller.g.dart';

@freezed
class OrderInfo with _$OrderInfo {
  const OrderInfo._();

  const factory OrderInfo({
    required String storeId,
    required String goodsId,
    required String storeAddress,
    required String storeName,
    required int quantity,
    required int totalPrice,
    required int salePrice,
    required int originalPrice,
    required String pickupTime,
    @Default(false) bool isSubmitting,
    String? merchantUid,
    String? error,
  }) = _OrderInfo;

  int get discount => originalPrice - salePrice;
}

@Riverpod(keepAlive: true)
class OrderPayScreenController extends _$OrderPayScreenController {
  @override
  OrderInfo build() {
    return OrderInfo(
      storeId: '',
      goodsId: '',
      storeAddress: '',
      quantity: 0,
      totalPrice: 0,
      salePrice: 0,
      originalPrice: 0,
      pickupTime: 'DateTime.now()',
      storeName: '',
    );
  }

  void setOrderInfo({
    String? storeId,
    String? storeName,
    String? storeAddress,
    int? quantity,
    int? totalPrice,
    int? salePrice,
    int? originalPrice,
    String? pickupTime,
    String? goodsId,
  }) {
    state = state.copyWith(
      storeId: storeId ?? state.storeId,
      goodsId: goodsId ?? state.goodsId,
      storeName: storeName ?? state.storeName,
      storeAddress: storeAddress ?? state.storeAddress,
      quantity: quantity ?? state.quantity,
      totalPrice: totalPrice ?? state.totalPrice,
      salePrice: salePrice ?? state.salePrice,
      originalPrice: originalPrice ?? state.originalPrice,
      pickupTime: pickupTime ?? state.pickupTime,
    );
  }

  void updateQuantity(int quantity) {
    state = state.copyWith(
      quantity: quantity,
      totalPrice: state.salePrice * quantity,
    );
  }

  // 결제전 주문등록
  Future<String?> submitOrder() async {
    try {
      state = state.copyWith(isSubmitting: true, error: null);

      // API 호출
      final response = await ref
          .read(orderRepositoryProvider)
          .createOrder(
            quantity: state.quantity,
            goodsId: state.goodsId,
            // paymentMethod: PaymentMethod.easyPay, // NOTE: 사용자 선택 값으로 변경
            // paymentsCompany: PaymentCompany.toss, // NOTE: 사용자 선택 값으로 변경
            pickupTime: state.pickupTime,
            totalPrice: state.totalPrice,
            // request: memo,
          );

      // merchantUid 저장
      state = state.copyWith(
        merchantUid: response.merchantUid,
        isSubmitting: false,
      );

      talker.info('주문 등록 성공: ${response.merchantUid}');
      return response.merchantUid; // ✔︎ 성공 → merchantUid 반환
    } on InvalidPickupTimeException catch (e) {
      talker.error('픽업 시간 오류: $e');
      state = state.copyWith(isSubmitting: false, error: e.toString());

      final context = GlobalVariable.navigatorKey.currentContext;
      if (context != null) {
        ToastPresentor.error(context, e.message);
      }

      return null; // ✔︎ 실패 → null 반환
    } catch (e) {
      talker.error('주문 등록 실패: $e');
      state = state.copyWith(isSubmitting: false, error: e.toString());

      final context = GlobalVariable.navigatorKey.currentContext;
      if (context != null) {
        ToastPresentor.error(context, '주문 등록에 실패했습니다. 다시 시도해주세요.');
      }

      return null; // ✔︎ 실패 → null 반환
    }
  }
}
