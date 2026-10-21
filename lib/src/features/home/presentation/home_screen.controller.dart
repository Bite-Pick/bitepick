import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:magambell/src/core/utils/shared_preference_store.dart';
import 'package:magambell/src/features/address/domain/entities/address.dart';
import 'package:magambell/src/features/goods/data/dtos/store_list.dto.dart';
import 'package:magambell/src/features/store/data/repositories/store_repository.dart';
import 'package:magambell/src/features/store/domain/sort_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_screen.controller.g.dart';
part 'home_screen.controller.freezed.dart';

/// 위치 권한이 없거나 현위치를 가져오지 못할 때 쓰는 기준 좌표 (죽전역)
const _fallbackLatitude = 37.324716;
const _fallbackLongitude = 127.107391;

const _pageSize = 10;

@freezed
class HomeScreenControllerState with _$HomeScreenControllerState {
  const factory HomeScreenControllerState({
    required bool onlyAvailable,
    required SortType sortType,

    /// 서버에 보내는 기준 좌표 (현위치 또는 죽전역)
    required double latitude,
    required double longitude,
    required List<StoreListDTO> storeGoodsList,
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
    final position = await _resolveLocation();

    // 초기값: 기본순(영업중 우선 + 가까운 순은 서버에서 정렬)
    const onlyAvailable = false;
    const sortType = SortType.recentDesc;
    final stores = await _fetchStores(
      latitude: position.latitude,
      longitude: position.longitude,
      onlyAvailable: onlyAvailable,
      sortType: sortType,
      page: 1,
    );

    return HomeScreenControllerState(
      onlyAvailable: onlyAvailable,
      sortType: sortType,
      latitude: position.latitude,
      longitude: position.longitude,
      storeGoodsList: stores,
      hasMore: stores.length >= _pageSize,
    );
  }

  Future<void> toggleOnlyAvailable() async {
    final currentData = state.value;
    if (currentData == null) return;

    // UI 즉시 업데이트
    state = AsyncData(
      currentData.copyWith(onlyAvailable: !currentData.onlyAvailable),
    );

    await _reloadStoreGoods();
  }

  Future<void> setSortType(SortType sortType) async {
    final currentData = state.value;
    if (currentData == null) return;

    // UI 즉시 업데이트
    state = AsyncData(currentData.copyWith(sortType: sortType));

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
      final newItems = await _fetchStores(
        latitude: currentData.latitude,
        longitude: currentData.longitude,
        onlyAvailable: currentData.onlyAvailable,
        sortType: currentData.sortType,
        page: nextPage,
      );

      state = AsyncData(
        currentData.copyWith(
          storeGoodsList: [...currentData.storeGoodsList, ...newItems],
          currentPage: nextPage,
          isLoadingMore: false,
          hasMore: newItems.length >= _pageSize,
        ),
      );
    } catch (_) {
      state = AsyncData(currentData.copyWith(isLoadingMore: false));
    }
  }

  Future<void> _reloadStoreGoods() async {
    final currentData = state.value;
    if (currentData == null) return;

    try {
      final stores = await _fetchStores(
        latitude: currentData.latitude,
        longitude: currentData.longitude,
        onlyAvailable: currentData.onlyAvailable,
        sortType: currentData.sortType,
        page: 1,
      );

      state = AsyncData(
        currentData.copyWith(
          storeGoodsList: stores,
          currentPage: 1,
          isLoadingMore: false,
          hasMore: stores.length >= _pageSize,
        ),
      );
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  Future<List<StoreListDTO>> _fetchStores({
    required double latitude,
    required double longitude,
    required bool onlyAvailable,
    required SortType sortType,
    required int page,
  }) {
    return ref
        .read(storeRepositoryProvider)
        .getStoreGoodsList(
          latitude: latitude,
          longitude: longitude,
          onlyAvailable: onlyAvailable,
          sortType: sortType,
          page: page,
          size: _pageSize,
        );
  }

  Future<void> saveToStorage(Address address) async {
    await _localStorage.setAddress(address.id);
  }

  Future<({double latitude, double longitude})> _resolveLocation() async {
    const fallback = (latitude: _fallbackLatitude, longitude: _fallbackLongitude);
    try {
      if (!await Geolocator.isLocationServiceEnabled()) return fallback;

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return fallback;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
        timeLimit: const Duration(seconds: 5),
      );
      return (latitude: position.latitude, longitude: position.longitude);
    } catch (_) {
      return fallback;
    }
  }
}
