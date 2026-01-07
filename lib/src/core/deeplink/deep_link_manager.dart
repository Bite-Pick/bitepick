import 'dart:async';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/core/router/app_router.dart';

class DeepLinkManager {
  DeepLinkManager._();
  static final DeepLinkManager instance = DeepLinkManager._();

  AppsflyerSdk? _appsflyerSdk;
  StreamSubscription? _deepLinkSubscription;
  StreamSubscription? _conversionDataSubscription;

  /// AppsFlyer SDK 초기화
  ///
  /// [devKey]: AppsFlyer Dev Key (Android, iOS 공통)
  /// [appId]: iOS용 Apple App Store ID (숫자). Android는 불필요
  Future<void> initialize({
    required String devKey,
    required String appId,
  }) async {
    final options = AppsFlyerOptions(
      afDevKey: devKey,
      appId: appId,
      showDebug: true,
      timeToWaitForATTUserAuthorization: 15,
    );

    _appsflyerSdk = AppsflyerSdk(options);

    // SDK 초기화
    await _appsflyerSdk?.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true,
    );

    // 딥링크 리스너 등록
    _setupDeepLinkListeners();
  }

  /// 딥링크 리스너 설정
  void _setupDeepLinkListeners() {
    // Unified Deep Link (UDL) 리스너
    _appsflyerSdk?.onDeepLinking((result) {
      debugPrint('🔗 AppsFlyer Deep Link Received: ${result.deepLink?.toString()}');

      if (result.status == Status.FOUND) {
        final deepLink = result.deepLink;
        if (deepLink != null) {
          _handleDeepLink(deepLink);
        }
      } else if (result.status == Status.NOT_FOUND) {
        debugPrint('🔗 Deep Link not found');
      } else {
        debugPrint('🔗 Deep Link error: ${result.error}');
      }
    });

    // Conversion Data 리스너 (설치 어트리뷰션)
    _appsflyerSdk?.onInstallConversionData((data) {
      debugPrint('🔗 AppsFlyer Conversion Data: $data');

      // 설치 후 첫 실행시 딥링크 처리
      if (data['is_first_launch'] == true) {
        final deepLinkValue = data['deep_link_value'];
        if (deepLinkValue != null) {
          _handleDeepLinkFromConversionData(deepLinkValue);
        }
      }
    });

    // Legacy App Open Attribution 리스너
    _appsflyerSdk?.onAppOpenAttribution((data) {
      debugPrint('🔗 AppsFlyer App Open Attribution: $data');
      final deepLinkValue = data['deep_link_value'];
      if (deepLinkValue != null) {
        _handleDeepLinkFromConversionData(deepLinkValue);
      }
    });
  }

  /// UDL DeepLink 객체 처리
  void _handleDeepLink(DeepLink deepLink) {
    final deepLinkValue = deepLink.deepLinkValue;
    final clickHttpReferrer = deepLink.clickHttpReferrer;
    final mediaSource = deepLink.mediaSource;

    debugPrint('🔗 Deep Link Value: $deepLinkValue');
    debugPrint('🔗 Click HTTP Referrer: $clickHttpReferrer');
    debugPrint('🔗 Media Source: $mediaSource');

    if (deepLinkValue != null) {
      _routeDeepLink(deepLinkValue);
    }
  }

  /// Conversion Data에서 추출한 딥링크 처리
  void _handleDeepLinkFromConversionData(String deepLinkValue) {
    debugPrint('🔗 Deep Link from Conversion Data: $deepLinkValue');
    _routeDeepLink(deepLinkValue);
  }

  /// 딥링크 값을 파싱하여 라우팅
  void _routeDeepLink(String deepLinkValue) {
    final context = GlobalVariable.navigatorKey.currentContext;
    if (context == null) {
      debugPrint('❌ Navigator context is null');
      return;
    }

    debugPrint('🔗 Routing deep link: $deepLinkValue');

    // URI 파싱
    final uri = Uri.tryParse(deepLinkValue);
    if (uri == null) {
      debugPrint('❌ Invalid deep link format: $deepLinkValue');
      return;
    }

    // magambell:// 스킴을 path로 변환
    // 예: magambell://store/123 -> /store/123
    final path = _convertDeepLinkToPath(uri);
    if (path == null) {
      debugPrint('❌ Unsupported deep link scheme: ${uri.scheme}');
      return;
    }

    try {
      // GoRouter가 알아서 path를 파싱하고 라우팅
      context.push(path);
    } catch (e) {
      debugPrint('❌ Error routing deep link: $e');
    }
  }

  /// 딥링크 URI를 GoRouter path로 변환
  ///
  /// 예시:
  /// - magambell://store/123 -> /store/123
  /// - magambell://main -> /main
  /// - magambell://search -> /search
  String? _convertDeepLinkToPath(Uri uri) {
    if (uri.scheme != 'magambell') {
      return null;
    }

    // host + path를 GoRouter path 형식으로 변환
    final host = uri.host;
    final path = uri.path;

    if (host.isEmpty) {
      return null;
    }

    // magambell://store/123 -> /store/123
    return '/$host$path';
  }

  /// 딥링크 리스너 해제
  void dispose() {
    _deepLinkSubscription?.cancel();
    _conversionDataSubscription?.cancel();
    _deepLinkSubscription = null;
    _conversionDataSubscription = null;
  }
}
