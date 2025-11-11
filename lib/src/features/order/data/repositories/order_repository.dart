import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/network/api_client.dart';
import 'package:magambell/src/features/order/domain/entities/order_owner.dart';
import 'package:magambell/src/features/order/domain/entities/order_guest_status.dart';
import 'package:magambell/src/features/order/domain/entities/order_owner_status.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_repository.g.dart';

class OrderRepository {
  final Ref ref;
  late final Dio _dio;

  OrderRepository(this.ref) {
    _dio = ref.read(apiClientProvider);
  }

  ///
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

    final data = res.data['data'] as Map<String, dynamic>?;
    if (res.data['status'] != 'OK' || data == null) return [];

    final list = data['content'] as List? ?? [];

    return list
        .map((json) => OrderOwner.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<bool> rejectOrder(String orderId, {String? rejectReason}) async {
    final res = await _dio.post(
      '/v1/order/reject/$orderId',
      data: rejectReason != null ? {'rejectReason': rejectReason} : null,
    );
    final data = res.data['data'] as String?;
    if (res.data['status'] != 'OK' || data == null) return false;
    return true;
  }

  Future<bool> approveOrder(String orderId) async {
    final res = await _dio.post('/v1/order/approve/$orderId');
    final data = res.data['data'] as String?;
    if (res.data['status'] != 'OK' || data == null) return false;
    return true;
  }

  Future<bool> completeOrder(String orderId) async {
    final res = await _dio.post('/v1/order/completed/$orderId');
    final data = res.data['data'] as String?;
    if (res.data['status'] != 'OK' || data == null) return false;
    return true;
  }

  Future<bool> cancelOrder(String orderId) async {
    final res = await _dio.post('/v1/order/cancel/$orderId');
    final data = res.data['data'] as String?;
    if (res.data['status'] != 'OK' || data == null) return false;
    return true;
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
