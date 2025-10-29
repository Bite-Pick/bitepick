import 'dart:async';
import 'dart:convert';
import 'dart:developer' show log;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/util/shared_preference_store.dart';
import '../data/repository/naver_geocoding_repository.dart';
import '../domain/entities/address.dart';
import '../domain/entities/area.dart';

part 'search_address_screen.controller.freezed.dart';
part 'search_address_screen.controller.g.dart';

/// ====== State ======
@freezed
class SearchAddressState with _$SearchAddressState {
  const factory SearchAddressState({
    @Default([]) List<Address> addresses, // 저장된 주소 목록(최대 5)
    @Default([]) List<Address> addressSearchResults, // 전체 주소 검색 결과
    @Default([]) List<Area> areaSearchResults, // 동 수준 검색 결과
    @Default('') String searchText, // 입력 텍스트(즉시)
    @Default(false) bool isLoading, // 검색/저장 중 플래그
    String? message, // UI에서 토스트/스낵바로 보여줄 메시지(성공/오류)
  }) = _SearchAddressState;
}

/// ====== Controller (Riverpod Generator) ======
@riverpod
class SearchAddressScreenController extends _$SearchAddressScreenController {
  static const _debounce = Duration(milliseconds: 500);
  Timer? _debounceTimer;

  late final NaverGeocodingRepository _repository;
  late final SharedPreferenceStore _store;

  @override
  SearchAddressState build() {
    _store = SharedPreferenceStore();
    _repository = NaverGeocodingRepository();

    ref.onDispose(() => _debounceTimer?.cancel());
    _loadFromStorage();

    return const SearchAddressState();
  }

  /// 입력 변경시 호출: 내부적으로 debounce 후 geocode 실행
  void setSearchText(String value) {
    state = state.copyWith(searchText: value, message: null);

    _debounceTimer?.cancel();
    if (value.trim().isEmpty) {
      state = state.copyWith(addressSearchResults: [], areaSearchResults: []);
      return;
    }
    _debounceTimer = Timer(_debounce, () => searchAreaByKeyword(value.trim()));
  }

  /// 검색 버튼/확정 시 즉시 실행하고 싶으면 이걸 호출
  Future<void> searchNow() async {
    final text = state.searchText.trim();
    if (text.isEmpty) {
      state = state.copyWith(
        addressSearchResults: [],
        areaSearchResults: [],
        message: null,
      );
      return;
    }
    await searchAreaByKeyword(text);
  }

  /// ====== 2. 동(Area) 키워드 검색 ======
  Future<void> searchAreaByKeyword(String keyword) async {
    state = state.copyWith(isLoading: true, message: null);
    final results = await _repository.searchArea(keyword);

    state = state.copyWith(
      areaSearchResults: results,
      isLoading: false,
      message: results.isEmpty ? '검색 결과가 없습니다.' : null,
    );
  }

  /// ====== 3. Reverse Geocoding (좌표 → 동 주소) ======
  Future<Area?> getAreaFromCoordinates(double lat, double lng) async {
    try {
      final result = await _repository.reverseGeocode(lat, lng);
      return result;
    } catch (e) {
      state = state.copyWith(message: 'Reverse geocoding 실패: 네트워크 상태를 확인해주세요.');
      return null;
    }
  }

  /// ====== 주소 관리 메서드 ======

  /// 검색 결과 리스트에서 항목을 탭했을 때(새 주소 추가 + 기본주소로 설정)
  Future<void> selectFromSearch(Address addr) async {
    // 최대 5개 제한
    if (state.addresses.length >= 5) {
      state = state.copyWith(message: '주소는 최대 5개까지 저장할 수 있습니다.');
      return;
    }

    // 기존 기본 해제
    final concated = state.addresses
        .map((a) => a.isDefault ? a.copyWith(isDefault: false) : a)
        .toList();

    final target = addr.copyWith(isDefault: true);
    final updated = [...concated, target]..sort(_defaultFirst);

    state = state.copyWith(
      addresses: updated,
      addressSearchResults: [],
      areaSearchResults: [],
      searchText: '',
      message: null,
    );
    await _saveToStorage(updated);
  }

  /// Area를 Address로 변환하여 저장
  Future<void> selectAreaAsAddress(Area area) async {
    // 최대 5개 제한
    if (state.addresses.length >= 5) {
      state = state.copyWith(message: '주소는 최대 5개까지 저장할 수 있습니다.');
      return;
    }

    // Area를 Address로 변환
    final address = Address(
      label: area.displayName,
      name: area.displayName,
      latitude: area.latitude,
      longitude: area.longitude,
      isDefault: true,
    );

    // 기존 기본 해제
    final concated = state.addresses
        .map((a) => a.isDefault ? a.copyWith(isDefault: false) : a)
        .toList();

    final updated = [...concated, address]..sort(_defaultFirst);

    state = state.copyWith(
      addresses: updated,
      addressSearchResults: [],
      areaSearchResults: [],
      searchText: '',
      message: '주소가 추가되었습니다.',
    );
    await _saveToStorage(updated);
  }

  /// 기존 목록에서 선택(기본주소로 설정)
  Future<void> selectFromSaved(Address originAddress) async {
    final updated = state.addresses.map((address) {
      final isSame = (address.label == originAddress.label && address.name == originAddress.name);
      return address.copyWith(isDefault: isSame);
    }).toList()..sort(_defaultFirst);

    state = state.copyWith(addresses: updated, message: null);
    await _saveToStorage(updated);
  }

  /// 삭제
  Future<void> deleteAddress(Address originAddress) async {
    final updated = state.addresses
        .where((a) => a.label != originAddress.label)
        .toList();
    state = state.copyWith(addresses: updated, message: '주소가 삭제되었습니다.');
    await _saveToStorage(updated);
  }

  /// 외부(MainLocationScreen 등)에서 area1~4, 위경도 받은 경우 처리
  Future<void> applyExternalLocation({
    required String area1,
    String? area2,
    String? area3,
    String? area4,
    required double latitude,
    required double longitude,
  }) async {
    if (state.addresses.length >= 5) {
      state = state.copyWith(message: '주소는 최대 5개까지 저장할 수 있습니다.');
      return;
    }

    final concated = state.addresses
        .map((a) => a.isDefault ? a.copyWith(isDefault: false) : a)
        .toList();

    final label = [area1, if ((area2 ?? '').isNotEmpty) area2!].join(' ');
    final full = [
      area1,
      if ((area2 ?? '').isNotEmpty) area2!,
      if ((area3 ?? '').isNotEmpty) area3!,
      if ((area4 ?? '').isNotEmpty) area4!,
    ].join(' ');

    final target = Address(
      label: label,
      name: full,
      latitude: latitude,
      longitude: longitude,
      isDefault: true,
    );

    final updated = [...concated, target]..sort(_defaultFirst);
    state = state.copyWith(
      addresses: updated,
      addressSearchResults: [],
      areaSearchResults: [],
      message: '현재 위치로 주소가 설정되었습니다.',
    );
    await _saveToStorage(updated);
  }

  /// Reverse geocoding으로 현재 위치의 동 주소를 가져와서 저장
  Future<void> applyCurrentLocation(double lat, double lng) async {
    if (state.addresses.length >= 5) {
      state = state.copyWith(message: '주소는 최대 5개까지 저장할 수 있습니다.');
      return;
    }

    state = state.copyWith(isLoading: true, message: null);

    final area = await getAreaFromCoordinates(lat, lng);
    if (area == null) {
      state = state.copyWith(
        isLoading: false,
        message: '현재 위치의 주소를 가져올 수 없습니다.',
      );
      return;
    }

    final concated = state.addresses
        .map((a) => a.isDefault ? a.copyWith(isDefault: false) : a)
        .toList();

    final target = Address(
      label: area.displayName,
      name: area.displayName,
      latitude: lat,
      longitude: lng,
      isDefault: true,
    );

    final updated = [...concated, target]..sort(_defaultFirst);
    state = state.copyWith(
      addresses: updated,
      isLoading: false,
      message: '현재 위치로 주소가 설정되었습니다.',
    );
    await _saveToStorage(updated);
  }

  /// 현재 위치 가져오기 (권한 확인 포함)
  Future<void> getCurrentLocation() async {
    // 위치 서비스 확인
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      state = state.copyWith(message: '위치 서비스가 비활성화되어 있습니다');
      return;
    }

    // 위치 권한 확인
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        state = state.copyWith(message: '위치 권한이 거부되었습니다');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      state = state.copyWith(message: '위치 권한이 영구적으로 거부되었습니다. 설정에서 변경해주세요');
      return;
    }

    // 위치 가져오기
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      await applyCurrentLocation(position.latitude, position.longitude);
    } catch (e) {
      state = state.copyWith(message: '위치를 가져오는 중 오류가 발생했습니다: $e');
    }
  }

  /// 메시지 클리어 (스낵바 표시 후 호출)
  void clearMessage() => state = state.copyWith(message: null);

  /// ====== 내부 유틸 ======
  int _defaultFirst(Address a, Address b) {
    if (a.isDefault && !b.isDefault) return -1;
    if (!a.isDefault && b.isDefault) return 1;
    return 0;
  }

  void _loadFromStorage() async {
    final addresses = await _store.getAddresses();
    if (addresses == null) {
      state = state.copyWith(addresses: []);
      return;
    }
    try {
      final list =
          (jsonDecode(addresses) as List)
              .map((j) => Address.fromJson(j as Map<String, dynamic>))
              .toList()
            ..sort(_defaultFirst);
      state = state.copyWith(addresses: list);
    } catch (e) {
      log('Error parsing addresses from storage: $e');
      state = state.copyWith(addresses: []);
    }
  }

  Future<void> _saveToStorage(List<Address> addresses) async {
    await _store.setAddresses(
      jsonEncode(addresses.map((e) => e.toJson()).toList()),
    );
  }
}
