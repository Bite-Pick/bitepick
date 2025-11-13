import 'dart:developer' show log;

import 'package:shared_preferences/shared_preferences.dart';

/// 해당 키를 가지고 데이터 IO
/// 저장할거 있을때마다 키 추가해서 세이브
class SharedPreferenceKey {
  /// 저장된 주소 목록
  static const storedAddresses = 'storedAddresses';

  /// Visual Logger 표시 여부
  static const showVisualLogger = 'showVisualLogger';
}

/// 실제 데이터 IO 하는부분
class SharedPreferenceStore {
  factory SharedPreferenceStore() => _instance;

  static final _instance = SharedPreferenceStore._private();

  late Future<SharedPreferences> _sharedPreferences;

  SharedPreferenceStore._private() {
    _sharedPreferences = _initSharedPreference();
  }

  Future<SharedPreferences> _initSharedPreference() async {
    return await SharedPreferences.getInstance();
  }

  /// 저장된 주소 목록 저장
  Future<void> setAddresses(String addressesJson) async {
    try {
      await (await _sharedPreferences).setString(
        SharedPreferenceKey.storedAddresses,
        addressesJson,
      );
    } catch (e) {
      log('Error saving addresses to storage: $e');
    }
  }

  /// 저장된 주소 목록 가져오기
  Future<String?> getAddresses() async {
    try {
      return (await _sharedPreferences).getString(
        SharedPreferenceKey.storedAddresses,
      );
    } catch (e) {
      log('Error loading addresses from storage: $e');
      return null;
    }
  }

  /// 로그아웃시 토큰 삭제ㅌ
  Future<void> clearAddresses() async {
    try {
      await (await _sharedPreferences).remove(
        SharedPreferenceKey.storedAddresses,
      );
    } catch (e) {
      log('Error clearing addresses from storage: $e');
    }
  }

  /// 모든 데이터 삭제
  Future<void> clearAll() async {
    try {
      await (await _sharedPreferences).clear();
    } catch (e) {
      log('Error clearing all data from storage: $e');
    }
  }

  /// Visual Logger 표시 여부 저장
  Future<void> setShowVisualLogger(bool value) async {
    try {
      await (await _sharedPreferences).setBool(
        SharedPreferenceKey.showVisualLogger,
        value,
      );
    } catch (e) {
      log('Error saving visual logger visibility: $e');
    }
  }

  /// Visual Logger 표시 여부 가져오기
  Future<bool> getShowVisualLogger() async {
    try {
      return (await _sharedPreferences).getBool(
            SharedPreferenceKey.showVisualLogger,
          ) ??
          true;
    } catch (e) {
      log('Error loading visual logger visibility: $e');
      return false;
    }
  }
}
