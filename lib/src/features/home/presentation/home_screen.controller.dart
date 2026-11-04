import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:magambell/src/core/utils/shared_preference_store.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';
import 'package:magambell/src/features/address/domain/entities/address.dart';
import 'package:magambell/src/features/goods/data/dtos/store_list.dto.dart';
import 'package:magambell/src/features/store/data/repositories/store_repository.dart';
import 'package:magambell/src/features/store/domain/sort_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_screen.controller.g.dart';
part 'home_screen.controller.freezed.dart';

/// 권한은 있지만 현위치를 가져오지 못할 때 쓰는 기준 좌표 (죽전역)
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

    /// 위치 권한(및 위치 서비스)이 허용되어 매장 목록을 보여줄 수 있는지 여부
    required bool isLocationGranted,
    required List<StoreListDTO> storeGoodsList,
    @Default(1) int currentPage,
    @Default(false) bool isLoadingMore,
    @Default(true) bool hasMore,

    /// 다음 페이지 조회가 실패한 상태. 사용자가 재시도하기 전까지 자동 재요청하지 않는다.
    @Default(false) bool loadMoreFailed,
  }) = _HomeScreenControllerState;
}

@riverpod
class HomeScreenController extends _$HomeScreenController {
  late SharedPreferenceStore _localStorage;

  /// 응답 순번. 목록을 새로 만드는 요청(build/재조회)이 시작될 때마다 올려서,
  /// 늦게 도착한 이전 요청의 응답이 최신 상태를 덮어쓰지 않게 한다.
  int _requestSeq = 0;

  @override
  Future<HomeScreenControllerState> build() async {
    _requestSeq++;
    _localStorage = SharedPreferenceStore();
    final position = await _resolveLocation();

    // 위치 권한이 없으면 매장 목록을 조회하지 않고 권한 안내 화면을 보여준다.
    if (position == null) {
      return const HomeScreenControllerState(
        onlyAvailable: false,
        sortType: SortType.recentDesc,
        latitude: _fallbackLatitude,
        longitude: _fallbackLongitude,
        isLocationGranted: false,
        storeGoodsList: [],
        hasMore: false,
      );
    }

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
      isLocationGranted: true,
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

    if (!currentData.isLocationGranted) return;
    await _reloadStoreGoods();
  }

  Future<void> setSortType(SortType sortType) async {
    final currentData = state.value;
    if (currentData == null) return;

    // UI 즉시 업데이트
    state = AsyncData(currentData.copyWith(sortType: sortType));

    if (!currentData.isLocationGranted) return;
    await _reloadStoreGoods();
  }

  Future<void> loadMore() async {
    final currentData = state.value;
    if (currentData == null || !currentData.isLocationGranted) return;
    if (currentData.isLoadingMore) return;
    if (!currentData.hasMore) return;
    if (currentData.loadMoreFailed) return;

    final seq = _requestSeq;
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

      // 응답을 기다리는 사이 필터/정렬이 바뀌었다면 이전 쿼리의 페이지는 버린다.
      final latest = state.value;
      if (seq != _requestSeq || latest == null) return;

      state = AsyncData(
        latest.copyWith(
          storeGoodsList: [...latest.storeGoodsList, ...newItems],
          currentPage: nextPage,
          isLoadingMore: false,
          hasMore: newItems.length >= _pageSize,
        ),
      );
    } catch (e, stack) {
      talker.handle(e, stack, '홈 매장 다음 페이지 조회 실패');
      final latest = state.value;
      if (seq != _requestSeq || latest == null) return;
      state = AsyncData(
        latest.copyWith(isLoadingMore: false, loadMoreFailed: true),
      );
    }
  }

  /// 다음 페이지 조회 실패 후 사용자가 재시도할 때 호출한다.
  Future<void> retryLoadMore() async {
    final currentData = state.value;
    if (currentData == null) return;

    state = AsyncData(currentData.copyWith(loadMoreFailed: false));
    await loadMore();
  }

  Future<void> _reloadStoreGoods() async {
    final currentData = state.value;
    if (currentData == null) return;

    final seq = ++_requestSeq;
    try {
      final stores = await _fetchStores(
        latitude: currentData.latitude,
        longitude: currentData.longitude,
        onlyAvailable: currentData.onlyAvailable,
        sortType: currentData.sortType,
        page: 1,
      );

      final latest = state.value;
      if (seq != _requestSeq || latest == null) return;

      state = AsyncData(
        latest.copyWith(
          storeGoodsList: stores,
          currentPage: 1,
          isLoadingMore: false,
          loadMoreFailed: false,
          hasMore: stores.length >= _pageSize,
        ),
      );
    } catch (e, stack) {
      if (seq != _requestSeq) return;
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

  /// 위치 권한 요청 버튼 동작. 설정에서 직접 허용해야 하는 경우 설정 화면을 연다.
  Future<void> requestLocationPermission() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return;
    }
    if (permission == LocationPermission.denied) return;

    if (!await Geolocator.isLocationServiceEnabled()) {
      await Geolocator.openLocationSettings();
      return;
    }
    ref.invalidateSelf();
  }

  /// 설정 화면에서 돌아왔을 때 위치 권한/서비스 상태가 바뀌었다면 목록을 다시 구성한다.
  /// - 권한 없음 → 허용: 목록을 새로 불러온다.
  /// - 허용 → 권한/위치 서비스 꺼짐: 권한 안내 화면으로 전환한다.
  /// 허용 상태가 그대로라면 목록과 스크롤 위치를 유지한다.
  Future<void> recheckLocation() async {
    final currentData = state.value;
    if (currentData == null) return;

    final position = await _resolveLocation(requestIfDenied: false);
    final isGranted = position != null;
    if (isGranted != currentData.isLocationGranted) ref.invalidateSelf();
  }

  /// 현위치를 반환한다. 권한이 없거나 위치 서비스가 꺼져 있으면 null,
  /// 권한은 있지만 위치를 가져오지 못하면 죽전역 좌표를 반환한다.
  Future<({double latitude, double longitude})?> _resolveLocation({
    bool requestIfDenied = true,
  }) async {
    try {
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied && requestIfDenied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return null;
      }
      if (!await Geolocator.isLocationServiceEnabled()) return null;

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
        timeLimit: const Duration(seconds: 5),
      );
      return (latitude: position.latitude, longitude: position.longitude);
    } catch (_) {
      return (latitude: _fallbackLatitude, longitude: _fallbackLongitude);
    }
  }
}
