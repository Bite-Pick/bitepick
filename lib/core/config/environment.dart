import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:magambell/core/config/constants.dart';
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

  Future<void> run() async {
    await dotenv.load(fileName: '.env');
    await main_app.runMagamBellApp();
  }
}
