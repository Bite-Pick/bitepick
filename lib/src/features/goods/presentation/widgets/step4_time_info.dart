import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';

class Step4TimeInfo extends ConsumerStatefulWidget {
  const Step4TimeInfo({super.key});

  @override
  ConsumerState<Step4TimeInfo> createState() => _Step4TimeInfoState();
}

class _Step4TimeInfoState extends ConsumerState<Step4TimeInfo> {
  DateTime? _startTime;
  DateTime? _endTime;

  Future<void> _selectStartTime() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (time != null) {
        setState(() {
          _startTime = DateTime(
            picked.year,
            picked.month,
            picked.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  Future<void> _selectEndTime() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (time != null) {
        setState(() {
          _endTime = DateTime(
            picked.year,
            picked.month,
            picked.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return '시간 선택';
    return '${dateTime.year}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: MgSizes.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 판매 시작 시간
          Text('판매 시작 시간').md().bold(),
          Gaps.h8,
          Text('마감백 판매를 시작할 시간을 선택해주세요').sm().textGray(),
          Gaps.h16,
          GestureDetector(
            onTap: _selectStartTime,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                border: Border.all(color: MgColorScheme.gray3),
                borderRadius: BorderRadius.circular(MgRadius.md),
                color: MgColorScheme.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_formatDateTime(_startTime))
                      .md()
                      .textColor(_startTime == null
                          ? MgColorScheme.gray5
                          : MgColorScheme.text),
                  Icon(
                    Icons.calendar_today_outlined,
                    color: MgColorScheme.gray5,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),

          Gaps.h32,

          // 판매 종료 시간
          Text('판매 종료 시간').md().bold(),
          Gaps.h8,
          Text('마감백 판매를 종료할 시간을 선택해주세요').sm().textGray(),
          Gaps.h16,
          GestureDetector(
            onTap: _selectEndTime,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                border: Border.all(color: MgColorScheme.gray3),
                borderRadius: BorderRadius.circular(MgRadius.md),
                color: MgColorScheme.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_formatDateTime(_endTime))
                      .md()
                      .textColor(_endTime == null
                          ? MgColorScheme.gray5
                          : MgColorScheme.text),
                  Icon(
                    Icons.calendar_today_outlined,
                    color: MgColorScheme.gray5,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),

          Gaps.h24,

          // 판매 기간 요약
          if (_startTime != null && _endTime != null)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: MgColorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(MgRadius.md),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('판매 기간').sm().bold(),
                  Gaps.h8,
                  Text(
                    '${_formatDateTime(_startTime)} ~ ${_formatDateTime(_endTime)}',
                  ).md().textColor(MgColorScheme.primary),
                  Gaps.h4,
                  Text(
                    '총 ${_endTime!.difference(_startTime!).inHours}시간 ${_endTime!.difference(_startTime!).inMinutes % 60}분',
                  ).sm().textGray(),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
