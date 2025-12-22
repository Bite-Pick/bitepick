import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/extensions/datetime_extension.dart';
import 'package:magambell/src/core/network/api_client.dart';
import 'package:magambell/src/core/network/api_exception.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';
import 'package:magambell/src/features/order/data/dtos/order_detail.dto.dart';
import 'package:magambell/src/features/order/data/dtos/order_list.dto.dart';
import 'package:magambell/src/features/order/domain/entities/order_form.dart';
import 'package:magambell/src/features/order/domain/entities/order_owner.dart';
import 'package:magambell/src/features/order/domain/entities/order_owner_status.dart';
import 'package:magambell/src/features/order/domain/entities/order_reject_reason.dart';
import 'package:magambell/src/features/order/data/dtos/order_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_repository.g.dart';

class OrderRepository {
  final Ref ref;
  late final Dio _dio;

  OrderRepository(this.ref) {
    _dio = ref.read(apiClientProvider);
  }

  Future<List<OrderOwner>> getStoreOrders({
    int page = 1,
    int size = 10,
    OrderOwnerStatus? orderStatus,
  }) async {
    final res = await _dio.get(
      '/v1/order/store',
      queryParameters: {
        'page': page,
        'size': size,
        if (orderStatus != null) 'orderStatus': orderStatus.name.toUpperCase(),
      },
    );

    final list = res.data['data']['orderStoreList'] as List<dynamic>?;
    if (res.data['status'] != 'OK' || list == null) return [];

    return list
        .map((json) => OrderOwner.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<OrderListDTO>> getUserOrders({
    int page = 1,
    int size = 10,
  }) async {
    final res = await _dio.get(
      '/v1/order',
      queryParameters: {'page': page, 'size': size},
    );
    if (res.data['status'] != 'OK') return [];

    final list = res.data['data']['orderListDTOList'] as List<dynamic>?;
    if (res.data['status'] != 'OK' || list == null) return [];

    return list
        .map((json) => OrderListDTO.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<OrderDetailDTO?> getUserOrderDetail(String orderId) async {
    final res = await _dio.get('/v1/order/$orderId');
    final data = res.data['data'] as Map<String, dynamic>?;
    if (res.data['status'] != 'OK' || data == null) return null;
    return OrderDetailDTO.fromJson(data);
  }

  Future<bool> rejectOrder(
    String orderId, {
    OrderRejectReason? rejectReason,
  }) async {
    final res = await _dio.patch(
      '/v1/order/reject/$orderId',
      data: rejectReason != null ? {'rejectReason': rejectReason.code} : null,
    );
    final data = res.data['data'] as String?;
    if (res.data['status'] != 'OK' || data == null) return false;
    return true;
  }

  Future<bool> approveOrder(String orderId) async {
    final res = await _dio.patch('/v1/order/approve/$orderId');
    final data = res.data['data'] as String?;
    if (res.data['status'] != 'OK' || data == null) return false;
    return true;
  }

  Future<bool> completeOrder(String orderId) async {
    final res = await _dio.patch('/v1/order/completed/$orderId');
    final data = res.data['data'] as String?;
    if (res.data['status'] != 'OK' || data == null) return false;
    return true;
  }

  Future<bool> cancelOrder(String orderId) async {
    final res = await _dio.patch('/v1/order/cancel/$orderId');
    final data = res.data['data'] as String?;
    if (res.data['status'] != 'OK' || data == null) return false;
    return true;
  }

  /// 주문 생성 (결제 전)
  Future<OrderResponse> createOrder({
    required int quantity,
    required String goodsId,
    required String pickupTime, // HH:mm 형식
    required int totalPrice,
  }) async {
    try {
      final res = await _dio.post(
        '/v1/order',
        data: {
          'quantity': quantity,
          'goodsId': goodsId,
          'pickupTime': pickupTime,
          'totalPrice': totalPrice,
        },
      );

      final data = res.data['data'] as Map<String, dynamic>?;
      if (res.data['status'] != 'OK' || data == null) {
        throw Exception('Failed to create order');
      }

      return OrderResponse.fromJson(data);
    } on DioException catch (e) {
      // INVALID_PICKUP_TIME 에러 처리
      if (e.response?.data != null &&
          e.response?.data['code'] == 'INVALID_PICKUP_TIME') {
        throw InvalidPickupTimeException();
      }
      rethrow;
    }
  }

  /// 결제 완료 처리
  /// [paymentId]는 주문 생성 시 받은 merchantUid (PortOne에서 반환)
  Future<bool> completePayment({required String paymentId}) async {
    try {
      final res = await _dio.post(
        '/v1/payment/complete',
        data: {'paymentId': paymentId},
      );

      if (res.data['status'] != 'OK') {
        throw Exception('Payment verification failed');
      }

      return true;
    } catch (e) {
      talker.error('결제 완료 처리 실패: $e');
      rethrow;
    }
  }
}

@riverpod
OrderRepository orderRepository(Ref ref) {
  return OrderRepository(ref);
}

@riverpod
Future<List<OrderOwner>> storeOrders(
  Ref ref, {
  int page = 1,
  int size = 10,
  OrderOwnerStatus? orderStatus,
}) async {
  return ref
      .read(orderRepositoryProvider)
      .getStoreOrders(page: page, size: size, orderStatus: orderStatus);
}

@riverpod
Future<List<OrderListDTO>> userOrders(
  Ref ref, {
  int page = 1,
  int size = 10,
}) async {
  return ref
      .read(orderRepositoryProvider)
      .getUserOrders(page: page, size: size);
}

@riverpod
Future<OrderDetailDTO?> userOrderDetail(
  Ref ref, {
  required String orderId,
}) async {
  return ref.read(orderRepositoryProvider).getUserOrderDetail(orderId);
}
