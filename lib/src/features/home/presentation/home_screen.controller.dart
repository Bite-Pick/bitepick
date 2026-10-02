import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:magambell/src/core/utils/shared_preference_store.dart';
import 'package:magambell/src/features/address/data/repositories/region_repository.dart';
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

    /// 거리 계산 기준 좌표 (현위치 또는 죽전역)
    required double latitude,
    required double longitude,

    /// 서버에서 받은 전체 매장 (필터/정렬 전)
    required List<StoreListDTO> allStores,

    /// 필터/정렬이 적용된 전체 매장
    required List<StoreListDTO> storeGoodsList,
    required List<Address> serviceAddresses,
    @Default(_pageSize) int visibleCount,
  }) = _HomeScreenControllerState;

  const HomeScreenControllerState._();

  /// 화면에 보여줄 매장 (스크롤에 따라 늘어남)
  List<StoreListDTO> get visibleStores =>
      this.storeGoodsList.take(visibleCount).toList();

  bool get hasMore => visibleCount < this.storeGoodsList.length;
}

@riverpod
class HomeScreenController extends _$HomeScreenController {
  late SharedPreferenceStore _localStorage;

  @override
  Future<HomeScreenControllerState> build() async {
    _localStorage = SharedPreferenceStore();
    final serviceAddresses = await ref.read(serviceAddressesProvider.future);
    final position = await _resolveLocation();
    final allStores = await ref.read(storeRepositoryProvider).getAllStores();

    const onlyAvailable = false;
    const sortType = SortType.distanceAsc;
    return HomeScreenControllerState(
      onlyAvailable: onlyAvailable,
      sortType: sortType,
      latitude: position.latitude,
      longitude: position.longitude,
      allStores: allStores,
      storeGoodsList: _arrange(
        allStores,
        latitude: position.latitude,
        longitude: position.longitude,
        onlyAvailable: onlyAvailable,
        sortType: sortType,
      ),
      serviceAddresses: serviceAddresses,
    );
  }

  Future<void> toggleOnlyAvailable() async {
    final currentData = state.value;
    if (currentData == null) return;

    final onlyAvailable = !currentData.onlyAvailable;
    state = AsyncData(
      currentData.copyWith(
        onlyAvailable: onlyAvailable,
        visibleCount: _pageSize,
        storeGoodsList: _arrange(
          currentData.allStores,
          latitude: currentData.latitude,
          longitude: currentData.longitude,
          onlyAvailable: onlyAvailable,
          sortType: currentData.sortType,
        ),
      ),
    );
  }

  Future<void> setSortType(SortType sortType) async {
    final currentData = state.value;
    if (currentData == null) return;

    state = AsyncData(
      currentData.copyWith(
        sortType: sortType,
        visibleCount: _pageSize,
        storeGoodsList: _arrange(
          currentData.allStores,
          latitude: currentData.latitude,
          longitude: currentData.longitude,
          onlyAvailable: currentData.onlyAvailable,
          sortType: sortType,
        ),
      ),
    );
  }

  /// 전체 목록을 한 번에 받아오므로, 스크롤 시 화면에 보여줄 개수만 늘린다.
  Future<void> loadMore() async {
    final currentData = state.value;
    if (currentData == null || !currentData.hasMore) return;

    state = AsyncData(
      currentData.copyWith(visibleCount: currentData.visibleCount + _pageSize),
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

  /// 필터 → 현위치 기준 거리 재계산 → 정렬 (영업중 매장이 항상 최상단)
  List<StoreListDTO> _arrange(
    List<StoreListDTO> stores, {
    required double latitude,
    required double longitude,
    required bool onlyAvailable,
    required SortType sortType,
  }) {
    final result = stores
        .where((s) => !onlyAvailable || s.saleStatus == 'ON')
        .map(
          (s) => s.copyWith(
            distance:
                Geolocator.distanceBetween(
                  latitude,
                  longitude,
                  s.latitude,
                  s.longitude,
                ) /
                1000,
          ),
        )
        .toList();

    int byDistance(StoreListDTO a, StoreListDTO b) =>
        a.distance.compareTo(b.distance);

    result.sort((a, b) {
      final aOn = a.saleStatus == 'ON';
      final bOn = b.saleStatus == 'ON';
      if (aOn != bOn) return aOn ? -1 : 1;

      if (sortType == SortType.priceAsc) {
        final byPrice = a.salePrice.compareTo(b.salePrice);
        if (byPrice != 0) return byPrice;
      }
      return byDistance(a, b);
    });
    return result;
  }
}
