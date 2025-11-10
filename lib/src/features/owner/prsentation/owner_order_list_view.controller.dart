import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/features/order/data/repositories/order_repository.dart';
import 'package:magambell/src/features/order/domain/entities/order_owner.dart';
import 'package:magambell/src/features/order/domain/entities/order_guest_status.dart';
import 'package:magambell/src/features/order/domain/entities/order_owner_status.dart';
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
    // TODO: API 호출로 변경
    // final repository = ref.read(orderRepositoryProvider);
    // final orders = await repository.getStoreOrders(
    //   page: 1,
    //   size: 10,
    // );

    // 임시로 mock 데이터 사용
    await Future.delayed(Duration(milliseconds: 500));

    final orders = mockOrderOwners;
    final counts = _calculateStatusCounts();

    return OwnerOrderListState(
      orders: orders,
      isLoading: false,
      statusCounts: counts,
    );
  }

  Future<void> _loadOrders() async {
    state = await AsyncValue.guard(() async {
      final currentState = state.requireValue;

      // TODO: API 호출로 변경
      // final repository = ref.read(orderRepositoryProvider);
      // final orders = await repository.getStoreOrders(
      //   page: 1,
      //   size: 10,
      //   orderStatus: currentState.selectedStatus,
      // );

      // 임시로 mock 데이터 사용
      await Future.delayed(Duration(milliseconds: 500));

      final orders = currentState.selectedStatus == null
          ? mockOrderOwners
          : mockOrderOwners
                .where(
                  (order) => order.orderStatus == currentState.selectedStatus,
                )
                .toList();

      return currentState.copyWith(orders: orders, isLoading: false);
    });
  }

  Map<OrderOwnerStatus?, int> _calculateStatusCounts() {
    // TODO: API 호출로 각 상태별 카운트 가져오기
    // 임시로 mock 데이터 기반 카운트
    return {
      null: mockOrderOwners.length,
      OrderOwnerStatus.paid: mockOrderOwners
          .where((order) => order.orderStatus == OrderOwnerStatus.paid)
          .length,
      OrderOwnerStatus.accepted: mockOrderOwners
          .where((order) => order.orderStatus == OrderOwnerStatus.accepted)
          .length,
      OrderOwnerStatus.completed: mockOrderOwners
          .where((order) => order.orderStatus == OrderOwnerStatus.completed)
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
    final counts = _calculateStatusCounts();
    state = AsyncValue.data(currentState.copyWith(statusCounts: counts));
  }

  Future<void> rejectOrder(String orderId) async {
    try {
      await ref.read(orderRepositoryProvider).rejectOrder(orderId);
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
}
