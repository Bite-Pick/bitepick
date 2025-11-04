import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/config/environment.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/network/api_client.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/core/utils/shorebird_manager.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'dart:convert';

class MypageScreen extends StatefulWidget {
  const MypageScreen({super.key});

  @override
  State<MypageScreen> createState() => _MypageScreenState();
}

class _MypageScreenState extends State<MypageScreen> {
  String _version = '';
  String _buildNumber = '';
  int? _patchNumber;

  @override
  void initState() {
    super.initState();
    _loadVersionInfo();
  }

  Future<void> _loadVersionInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final patchNumber = await ShorebirdManager.getCurrentPatchNumber();

    if (mounted) {
      setState(() {
        _version = packageInfo.version;
        _buildNumber = packageInfo.buildNumber;
        _patchNumber = patchNumber;
      });
    }
  }

  Future<void> _debugApiCall() async {
    try {
      // API 호출
      final dio = ApiClient().dio;
      final response = await dio.get(
        '/v1/store',
        queryParameters: {
          'latitude': 37.5185663,
          'longitude': 127.0230599,
          'onlyAvailable': true,
          'sortType': 'RECENT_DESC',
          'page': 1,
          'size': 10,
        },
      );

      // 응답 정보
      final statusCode = response.statusCode;
      final data = response.data;
      final dataLength = data is Map && data['data'] is Map
          ? (data['data']['storeListDTOResponses'] as List?)?.length ?? 0
          : 0;

      // JSON 포맷팅
      final prettyJson = const JsonEncoder.withIndent('  ').convert(data);

      // 디버깅 정보 구성
      final debugInfo = '''
🌐 Environment: ${Environment.instance.isDev ? 'DEV' : 'PROD'}
📍 Base URL: ${Environment.baseApiUrl}
🎯 Full URL: ${Environment.baseApiUrl}/v1/store
📊 Status: $statusCode
📦 Store Count: $dataLength

📄 Response:
$prettyJson
''';

      if (!mounted) return;

      // Flash로 표시
      await context.showFlash(
        duration: const Duration(seconds: 10),
        builder: (context, controller) {
          return FlashBar(
            controller: controller,
            position: FlashPosition.top,
            behavior: FlashBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: statusCode == 200 ? Colors.green : Colors.orange,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'API Debug Info',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy, color: Colors.white),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: debugInfo));
                        controller.dismiss();
                        context.showFlash(
                          duration: const Duration(seconds: 2),
                          builder: (context, controller) {
                            return FlashBar(
                              controller: controller,
                              content: const Text(
                                '클립보드에 복사되었습니다',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.black87,
                            );
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => controller.dismiss(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  constraints: const BoxConstraints(maxHeight: 400),
                  child: SingleChildScrollView(
                    child: Text(
                      debugInfo,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    } catch (e, stackTrace) {
      if (!mounted) return;

      // 에러 표시
      await context.showFlash(
        duration: const Duration(seconds: 10),
        builder: (context, controller) {
          return FlashBar(
            controller: controller,
            position: FlashPosition.top,
            behavior: FlashBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Colors.red,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '❌ API Error',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => controller.dismiss(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  e.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(title: const Text('마이페이지')),
      body: ListView(
        children: [
          _buildVersionSection(),
          MgButton(
            onPressed: _debugApiCall,
            content: const Text("API 디버깅"),
          ).margin(horizontal: MgSizes.md),
        ],
      ),
    );
  }

  Widget _buildVersionSection() {
    return Container(
      decoration: BoxDecoration(
        color: MgColorScheme.gray10,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text('버전 정보').lg().bold(),
          Gaps.h12,
          _buildVersionItem('앱 버전', '$_version ($_buildNumber)'),
          if (_patchNumber != null) ...[
            Gaps.h8,
            _buildVersionItem('패치 버전', 'Patch #$_patchNumber'),
          ],
          if (!ShorebirdManager.isAvailable) ...[
            Gaps.h8,
            Text('코드 푸시가 비활성화되어 있습니다.')
                .sm()
                .textGray()
                .regular(),
          ],
        ],
      ).margin(all: MgSizes.md),
    );

  }

  Widget _buildVersionItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label).md().textGray(),
        Text(value).md().bold(),
      ],
    );
  }
}
