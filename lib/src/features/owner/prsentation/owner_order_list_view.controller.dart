import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/features/order/data/repositories/order_repository.dart';
import 'package:magambell/src/features/order/domain/entities/order_owner.dart';
import 'package:magambell/src/features/order/domain/entities/order_owner_status.dart';
import 'package:magambell/src/features/order/domain/entities/order_reject_reason.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'owner_order_list_view.controller.freezed.dart';
part 'owner_order_list_view.controller.g.dart';

@freezed
class OwnerOrderListState with _$OwnerOrderListState {
  const factory OwnerOrderListState({
    @Default([]) List<OrderOwner> orders,
    @Default(false) bool isLoading,
    OrderOwnerStatus? selectedStatus,
    @Default({}) Map<OrderOwnerStatus?, int> statusCounts,
    String? error,
  }) = _OwnerOrderListState;
}

@riverpod
class OwnerOrderListController extends _$OwnerOrderListController {
  @override
  Future<OwnerOrderListState> build() async {
    final orders = await ref.read(orderRepositoryProvider).getStoreOrders();

    final counts = _calculateStatusCounts(orders);

    return OwnerOrderListState(
      orders: orders,
      isLoading: false,
      statusCounts: counts,
    );
  }

  Future<void> _loadOrders() async {
    state = await AsyncValue.guard(() async {
      final currentState = state.requireValue;
      final orginOrders = await ref
          .read(orderRepositoryProvider)
          .getStoreOrders();
      final orders = currentState.selectedStatus == null
          ? orginOrders
          : orginOrders
                .where(
                  (order) => order.orderStatus == currentState.selectedStatus,
                )
                .toList();

      return currentState.copyWith(orders: orders, isLoading: false);
    });
  }

  Map<OrderOwnerStatus?, int> _calculateStatusCounts(List<OrderOwner> orders) {
    return {
      null: orders.length,
      OrderOwnerStatus.PAID: orders
          .where((order) => order.orderStatus == OrderOwnerStatus.PAID)
          .length,
      OrderOwnerStatus.ACCEPTED: orders
          .where((order) => order.orderStatus == OrderOwnerStatus.ACCEPTED)
          .length,
      OrderOwnerStatus.COMPLETED: orders
          .where((order) => order.orderStatus == OrderOwnerStatus.COMPLETED)
          .length,
    };
  }

  Future<void> changeStatus(OrderOwnerStatus? status) async {
    final currentState = state.requireValue;
    if (currentState.selectedStatus == status) return;

    state = AsyncValue.data(
      currentState.copyWith(selectedStatus: status, isLoading: true),
    );
    await _loadOrders();
  }

  Future<void> refresh() async {
    await _loadOrders();
    final currentState = state.requireValue;
    final counts = _calculateStatusCounts(currentState.orders);
    state = AsyncValue.data(currentState.copyWith(statusCounts: counts));
  }

  Future<void> rejectOrder(
    String orderId, {
    OrderRejectReason? rejectReason,
  }) async {
    try {
      await ref
          .read(orderRepositoryProvider)
          .rejectOrder(orderId, rejectReason: rejectReason);
      await refresh();
    } catch (e) {
      final currentState = state.requireValue;
      state = AsyncValue.data(currentState.copyWith(error: e.toString()));
      rethrow;
    }
  }

  Future<void> approveOrder(String orderId) async {
    try {
      await ref.read(orderRepositoryProvider).approveOrder(orderId);
      await refresh();
    } catch (e) {
      final currentState = state.requireValue;
      state = AsyncValue.data(currentState.copyWith(error: e.toString()));
      rethrow;
    }
  }

  Future<void> completeOrder(String orderId) async {
    try {
      await ref.read(orderRepositoryProvider).completeOrder(orderId);
      await refresh();
    } catch (e) {
      final currentState = state.requireValue;
      state = AsyncValue.data(currentState.copyWith(error: e.toString()));
      rethrow;
    }
  }

  Future<void> cancelOrder(String orderId) async {
    try {
      await ref.read(orderRepositoryProvider).cancelOrder(orderId);
      await refresh();
    } catch (e) {
      final currentState = state.requireValue;
      state = AsyncValue.data(currentState.copyWith(error: e.toString()));
      rethrow;
    }
  }
}
