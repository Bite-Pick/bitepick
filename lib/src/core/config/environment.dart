import 'package:flutter/foundation.dart';
import 'package:magambell/src/core/config/constants.dart';
import 'package:magambell/src/main.dart' as main_app;

enum BuildType { dev, prod }

class Environment {
  Environment._internal(this._buildType);

  factory Environment.newInstance(BuildType buildType) {
    _instance = Environment._internal(buildType);
    return _instance;
  }

  static late Environment _instance;
  static Environment get instance => _instance;

  late BuildType _buildType;
  static BuildType get buildType => instance._buildType;

  bool get isDev => _buildType == BuildType.dev;
  bool get isProd => _buildType == BuildType.prod;

  bool get isReleaseMode => kReleaseMode;

  static String get appName => switch (instance._buildType) {
    BuildType.dev => 'MagamBell Dev',
    BuildType.prod => 'MagamBell',
  };

  static String get baseApiUrl => switch (instance._buildType) {
    BuildType.dev => DEV_API_URL,
    BuildType.prod => API_URL,
  };

  // Naver Cloud Platform Geocoding
  static String get geocodingApiUrl => GEOCODING_API_URL;
  static String get ncpApiKeyId => X_NCP_APIGW_API_KEY_ID;
  static String get ncpApiKey => X_NCP_APIGW_API_KEY;

  // Kakao
  static String get kakaoNativeAppKey =>  switch (instance._buildType) {
    BuildType.dev => KAKAO_NATIVE_DEV_APP_KEY,
    BuildType.prod => KAKAO_NATIVE_PROD_APP_KEY,
  };
  static String get kakaoJavascriptKey => KAKAO_JAVASCRIPT_KEY;
  static String get kakaoRestApiKey => KAKAO_REST_API_KEY;

  // Firebase (Android용 - iOS는 GoogleService-Info.plist 사용)
  static String get firebaseAppId => switch (instance._buildType) {
    BuildType.dev => FIREBASE_APP_ID_ANDROID_DEV,
    BuildType.prod => FIREBASE_APP_ID_ANDROID_PROD,
  };

  static String get firebaseApiKey => switch (instance._buildType) {
    BuildType.dev => FIREBASE_API_KEY_ANDROID_DEV,
    BuildType.prod => FIREBASE_API_KEY_ANDROID_PROD,
  };

  static String get firebaseMessagingSenderId => switch (instance._buildType) {
    BuildType.dev => FIREBASE_MESSAGING_SENDER_ID_ANDROID_DEV,
    BuildType.prod => FIREBASE_MESSAGING_SENDER_ID_ANDROID_PROD,
  };

  static String get firebaseProjectId => switch (instance._buildType) {
    BuildType.dev => FIREBASE_PROJECT_ID_ANDROID_DEV,
    BuildType.prod => FIREBASE_PROJECT_ID_ANDROID_PROD,
  };

  Future<void> run() async {
    await main_app.runMagamBellApp();
  }
}
