import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/core/utils/shared_preference_store.dart';
import 'package:magambell/src/features/address/data/repositories/region_repository.dart';
import 'package:magambell/src/features/address/domain/entities/address.dart';
import 'package:magambell/src/features/goods/data/dtos/store_list.dto.dart';
import 'package:magambell/src/features/store/data/repositories/store_repository.dart';
import 'package:magambell/src/features/store/domain/sort_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_screen.controller.g.dart';
part 'home_screen.controller.freezed.dart';

@freezed
class HomeScreenControllerState with _$HomeScreenControllerState {
  const factory HomeScreenControllerState({
    required bool onlyAvailable,
    required SortType sortType,
    required Address defaultAddress,
    required List<StoreListDTO> storeGoodsList,
    required List<Address> serviceAddresses,
    @Default(1) int currentPage,
    @Default(false) bool isLoadingMore,
    @Default(true) bool hasMore,
  }) = _HomeScreenControllerState;
}

@riverpod
class HomeScreenController extends _$HomeScreenController {
  late SharedPreferenceStore _localStorage;
  @override
  Future<HomeScreenControllerState> build() async {
    _localStorage = SharedPreferenceStore();
    final defaultAddress = await loadFromStorage();
    final serviceAddresses = await ref.read(serviceAddressesProvider.future);
    // 초기값으로 상점 목록 로드
    final storeGoods = await ref.read(
      storeGoodsListProvider(
        latitude: defaultAddress.latitude,
        longitude: defaultAddress.longitude,
        onlyAvailable: false, // 초기값
        sortType: SortType.recentDesc, // 초기값
      ).future,
    );

    return HomeScreenControllerState(
      onlyAvailable: false,
      sortType: SortType.recentDesc,
      defaultAddress: defaultAddress,
      storeGoodsList: storeGoods,
      serviceAddresses: serviceAddresses,
      currentPage: 1,
      isLoadingMore: false,
      hasMore: storeGoods.length >= 10,
    );
  }

  Future<void> toggleOnlyAvailable() async {
    final currentData = state.value;
    if (currentData == null) return;

    // UI 즉시 업데이트
    state = AsyncData(
      currentData.copyWith(onlyAvailable: !currentData.onlyAvailable),
    );

    // 데이터 재로딩
    await _reloadStoreGoods();
  }

  Future<void> setSortType(SortType sortType) async {
    final currentData = state.value;
    if (currentData == null) return;

    // UI 즉시 업데이트
    state = AsyncData(currentData.copyWith(sortType: sortType));

    // 데이터 재로딩
    await _reloadStoreGoods();
  }

  Future<void> loadMore() async {
    final currentData = state.value;
    if (currentData == null) return;
    if (currentData.isLoadingMore) return;
    if (!currentData.hasMore) return;

    state = AsyncData(currentData.copyWith(isLoadingMore: true));

    try {
      final nextPage = currentData.currentPage + 1;
      const pageSize = 10;

      var newItems = await ref
          .read(storeRepositoryProvider)
          .getStoreGoodsList(
            latitude: currentData.defaultAddress.latitude,
            longitude: currentData.defaultAddress.longitude,
            onlyAvailable: currentData.onlyAvailable,
            sortType: currentData.sortType,
            page: nextPage,
            size: pageSize,
          );

      if (currentData.onlyAvailable) {
        newItems = newItems.where((s) => s.saleStatus == 'ON').toList();
      }

      state = AsyncData(
        currentData.copyWith(
          storeGoodsList: [...currentData.storeGoodsList, ...newItems],
          currentPage: nextPage,
          isLoadingMore: false,
          hasMore: newItems.length >= pageSize,
        ),
      );
    } catch (e, stack) {
      state = AsyncData(currentData.copyWith(isLoadingMore: false));
    }
  }

  Future<void> _reloadStoreGoods() async {
    final currentData = state.value;
    if (currentData == null) return;

    try {
      var storeGoods = await ref
          .read(storeRepositoryProvider)
          .getStoreGoodsList(
            latitude: currentData.defaultAddress.latitude,
            longitude: currentData.defaultAddress.longitude,
            onlyAvailable: currentData.onlyAvailable,
            sortType: currentData.sortType,
            page: 1,
            size: 10,
          );

      if (currentData.onlyAvailable) {
        storeGoods = storeGoods
            .where((store) => store.saleStatus == 'ON')
            .toList();
      }

      state = AsyncData(currentData.copyWith(
        storeGoodsList: storeGoods,
        currentPage: 1,
        isLoadingMore: false,
        hasMore: storeGoods.length >= 10,
      ));
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  Future<Address> loadFromStorage() async {
    final serviceAreas = await ref.read(serviceAddressesProvider.future);
    final defaultAddressId = await _localStorage.getAddress();
    return serviceAreas.firstWhere(
      (address) => address.id == defaultAddressId,
      orElse: () => serviceAreas.isNotEmpty ? serviceAreas.first : mockAddress,
    );
  }

  Future<void> saveToStorage(Address address) async {
    final currentData = state.value;
    if (currentData == null) return;
    await _localStorage.setAddress(address.id ?? 1); // TODO: 로직 수정 필요
    state = AsyncData(currentData.copyWith(defaultAddress: address));
    await _reloadStoreGoods();
  }
}
