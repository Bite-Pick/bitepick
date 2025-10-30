import 'package:flutter/material.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/core/utils/shorebird_manager.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:package_info_plus/package_info_plus.dart';

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

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(title: const Text('마이페이지')),
      body: ListView(
        children: [
          _buildVersionSection(),
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
