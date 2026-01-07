import 'package:flutter/material.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_checkbox.dart';
import 'package:url_launcher/url_launcher.dart';

/// 약관 항목
class AgreementItem {
  final String text;
  final String link;

  const AgreementItem({required this.text, required this.link});
}

class AgreementSection extends StatefulWidget {
  const AgreementSection({
    super.key,
    required this.items,
    required this.onAllAgreedChanged,
    this.allAgreeText = '전체 동의',
  });

  final List<AgreementItem> items;
  final ValueChanged<bool> onAllAgreedChanged;
  final String allAgreeText;

  @override
  State<AgreementSection> createState() => _AgreementSectionState();
}

class _AgreementSectionState extends State<AgreementSection> {
  bool _allAgreed = false;
  late List<bool> _agreements;

  @override
  void initState() {
    super.initState();
    // 항목 개수만큼 동의 상태 초기화
    _agreements = List.filled(widget.items.length, false);
  }

  void _toggleAllAgreements(bool value) {
    setState(() {
      _allAgreed = value;
      // 모든 항목을 동일한 값으로 설정
      _agreements = List.filled(widget.items.length, value);
    });
    widget.onAllAgreedChanged(value);
  }

  void _checkAllAgreements() {
    // 모든 항목이 동의되었는지 확인
    final allAgreed = _agreements.every((agreed) => agreed);
    setState(() {
      _allAgreed = allAgreed;
    });
    widget.onAllAgreedChanged(allAgreed);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 전체 동의
        GestureDetector(
              onTap: () => _toggleAllAgreements(!_allAgreed),
              child: Row(
                children: [
                  MgCheckbox(
                    initialValue: _allAgreed,
                    onChanged: (value) => _toggleAllAgreements(value),
                  ).margin(all: MgSizes.xs),
                  Expanded(child: Text(widget.allAgreeText).md().bold()),
                ],
              ),
            )
            .margin(vertical: MgSizes.xs, horizontal: MgSizes.md)
            .decorated(
              color: MgColorScheme.gray9,
              borderRadius: BorderRadius.circular(MgRadius.md),
            ),
        Gaps.h12,
        // 동적으로 생성된 약관 항목들
        ...List.generate(
          widget.items.length,
          (index) => _buildAgreementItem(
            widget.items[index].text,
            widget.items[index].link,
            _agreements[index],
            (value) {
              setState(() => _agreements[index] = value);
              _checkAllAgreements();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAgreementItem(
    String text,
    String link,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Row(
        children: [
          BaseSvgIcon.check(
            color: value ? MgColorScheme.primary : MgColorScheme.gray6,
            size: MgSizes.lg,
          ),
          Gaps.w8,
          Expanded(child: Text(text).sm().textGray()),
          GestureDetector(
            onTap: () async {
              if (link.isNotEmpty) {
                await launchUrl(
                  Uri.parse(link),
                  mode: LaunchMode.externalApplication,
                );
              }
            },
            child: BaseSvgIcon.right(
              color: MgColorScheme.gray6,
              size: MgSizes.lg,
            ),
          ),
        ],
      ).margin(vertical: MgSizes.xs),
    );
  }
}

class JoinAgreementSection extends StatefulWidget {
  const JoinAgreementSection({
    super.key,
    required this.items,
    required this.onAllAgreedChanged,
    this.allAgreeText = '약관 전체 동의',
  });

  final List<AgreementItem> items;
  final ValueChanged<bool> onAllAgreedChanged;
  final String allAgreeText;

  @override
  State<JoinAgreementSection> createState() => _JoinAgreementSectionState();
}

class _JoinAgreementSectionState extends State<JoinAgreementSection> {
  bool _allAgreed = false;
  late List<bool> _agreements;

  @override
  void initState() {
    super.initState();
    // 항목 개수만큼 동의 상태 초기화
    _agreements = List.filled(widget.items.length, false);
  }

  void _toggleAllAgreements(bool value) {
    setState(() {
      _allAgreed = value;
      // 모든 항목을 동일한 값으로 설정
      _agreements = List.filled(widget.items.length, value);
    });
    widget.onAllAgreedChanged(value);
  }

  void _checkAllAgreements() {
    // 모든 항목이 동의되었는지 확인
    final allAgreed = _agreements.every((agreed) => agreed);
    setState(() {
      _allAgreed = allAgreed;
    });
    widget.onAllAgreedChanged(allAgreed);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 전체 동의
        GestureDetector(
              onTap: () => _toggleAllAgreements(!_allAgreed),
              child: Row(
                children: [
                  _buildCheckBox(_allAgreed),
                  Gaps.w8,
                  Expanded(child: Text(widget.allAgreeText).md().bold()),
                ],
              ),
            )
            .margin(vertical: MgSizes.sm, left: MgSizes.md)
            .decorated(
              color: MgColorScheme.gray9,
              borderRadius: BorderRadius.circular(MgRadius.md),
            ),
        Gaps.h16,
        // 동적으로 생성된 약관 항목들
        ...List.generate(
          widget.items.length,
          (index) => _buildAgreementItem(
            widget.items[index].text,
            widget.items[index].link,
            _agreements[index],
            (value) {
              setState(() => _agreements[index] = value);
              _checkAllAgreements();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCheckBox(bool isCheck) {
    return MgCheckbox(
      initialValue: isCheck,
      onChanged: (value) => _toggleAllAgreements(value),
    );
  }

  Widget _buildAgreementItem(
    String text,
    String link,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Row(
        children: [
          _buildCheckBox(value),
          Gaps.w8,
          Expanded(child: Text(text).sm().textColor(MgColorScheme.gray1)),
          GestureDetector(
            onTap: () async {
              if (link.isNotEmpty) {
                await launchUrl(
                  Uri.parse(link),
                  mode: LaunchMode.externalApplication,
                );
              }
            },
            child: BaseSvgIcon.right(
              color: MgColorScheme.gray6,
              size: MgSizes.xl,
            ),
          ),
        ],
      ),
    ).margin(vertical: MgSizes.xs, left: MgSizes.md);
  }
}
