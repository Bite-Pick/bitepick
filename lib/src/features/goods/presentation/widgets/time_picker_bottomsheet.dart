import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/widgets/mg_bottomsheet.dart';
import 'package:magambell/src/widgets/mg_button.dart';

class TimeOption {
  final String displayText;
  final DateTime dateTime;

  TimeOption({required this.displayText, required this.dateTime});
}

class TimePickerBottomSheet extends StatefulWidget {
  const TimePickerBottomSheet({
    super.key,
    this.initialTime,
    this.startTime,
    this.endTime,
    required this.onTimeSelected,
    this.onSelectionChanged,
  });

  final DateTime? initialTime;
  final DateTime? startTime;
  final DateTime? endTime;

  final void Function(DateTime selected, String? errorMessage) onTimeSelected;

  /// 휠이 움직여서 "현재 선택 값"이 바뀔 때마다 호출
  final void Function(DateTime selected, String? errorMessage)?
  onSelectionChanged;

  @override
  State<TimePickerBottomSheet> createState() => _TimePickerBottomSheetState();

  static Future<void> show(
    BuildContext context, {
    DateTime? initialTime,
    DateTime? startTime,
    DateTime? endTime,
    required void Function(DateTime selected, String? errorMessage)
    onTimeSelected,
    void Function(DateTime selected, String? errorMessage)? onSelectionChanged,
  }) {
    return MgBottomsheet.show(context, (context, bottomState) {
      return TimePickerBottomSheet(
        initialTime: initialTime,
        startTime: startTime,
        endTime: endTime,
        onTimeSelected: onTimeSelected,
        onSelectionChanged: onSelectionChanged,
      );
    }, height: 450);
  }
}

class _TimePickerBottomSheetState extends State<TimePickerBottomSheet> {
  late FixedExtentScrollController _timeController;
  late List<TimeOption> _timeOptions;
  late int _selectedIndex;
  late bool _isPickupToday; // 오늘 픽업 여부
  late DateTime _pickupDate; // 픽업 날짜 (오늘 또는 내일)

  @override
  void initState() {
    super.initState();
    // 1. 먼저 시간 옵션 생성
    _timeOptions = _generateTimeOptions();

    // 2. 초기 선택 인덱스 계산
    final initialTime = widget.initialTime ?? DateTime.now();
    _selectedIndex = _findClosestTimeIndex(initialTime);

    // 3. 컨트롤러 생성 (이제 _selectedIndex가 초기화된 상태)
    _timeController = FixedExtentScrollController(initialItem: _selectedIndex);

    // 초기 상태 콜백
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _notifySelectionChanged();
    });
  }

  @override
  void dispose() {
    _timeController.dispose();
    super.dispose();
  }

  /// 30분 단위로 시간 옵션 생성
  /// 현재 시간 기준으로 픽업 날짜(오늘/내일)와 선택 가능한 시간 범위를 자동 결정
  List<TimeOption> _generateTimeOptions() {
    final options = <TimeOption>[];
    final now = DateTime.now();

    // 기본값 설정
    final startTime =
        widget.startTime ?? DateTime(now.year, now.month, now.day, 0, 0);
    final endTime =
        widget.endTime ?? DateTime(now.year, now.month, now.day, 23, 30);

    // 시간만 추출 (날짜 무시)
    final nowTimeInMinutes = now.hour * 60 + now.minute;
    final startTimeInMinutes = startTime.hour * 60 + startTime.minute;
    final endTimeInMinutes = endTime.hour * 60 + endTime.minute;

    // 픽업 날짜와 선택 가능한 시간 범위 결정
    DateTime pickupDate;
    int rangeStartMinute;
    int rangeEndMinute;

    if (nowTimeInMinutes >= startTimeInMinutes &&
        nowTimeInMinutes <= endTimeInMinutes) {
      // 케이스 1: 현재 시간이 영업 시간 내 (startTime <= now <= endTime)
      // → 픽업 날짜: 오늘, 선택 범위: now ~ endTime
      _isPickupToday = true;
      pickupDate = DateTime(now.year, now.month, now.day);
      rangeStartMinute = nowTimeInMinutes;
      rangeEndMinute = endTimeInMinutes;
    } else if (nowTimeInMinutes > endTimeInMinutes) {
      // 케이스 2: 현재 시간이 영업 종료 이후 (now > endTime)
      // → 픽업 날짜: 내일, 선택 범위: startTime ~ endTime
      _isPickupToday = false;
      pickupDate = DateTime(now.year, now.month, now.day + 1);
      rangeStartMinute = startTimeInMinutes;
      rangeEndMinute = endTimeInMinutes;
    } else {
      // 케이스 3: 현재 시간이 영업 시작 전 (now < startTime)
      // → 픽업 날짜: 오늘, 선택 범위: startTime ~ endTime
      _isPickupToday = true;
      pickupDate = DateTime(now.year, now.month, now.day);
      rangeStartMinute = startTimeInMinutes;
      rangeEndMinute = endTimeInMinutes;
    }

    _pickupDate = pickupDate;

    // 30분 단위로 반올림/내림
    rangeStartMinute = ((rangeStartMinute + 14) ~/ 30) * 30; // 반올림
    rangeEndMinute = (rangeEndMinute ~/ 30) * 30; // 내림

    // 30분 단위로 시간 생성
    for (
      int minute = rangeStartMinute;
      minute <= rangeEndMinute;
      minute += 30
    ) {
      final hour = minute ~/ 60;
      final min = minute % 60;

      // 픽업 날짜 + 선택된 시간으로 DateTime 생성
      final dateTime = DateTime(
        pickupDate.year,
        pickupDate.month,
        pickupDate.day,
        hour,
        min,
      );
      final displayText = _formatTime(hour, min);

      options.add(TimeOption(displayText: displayText, dateTime: dateTime));
    }

    return options;
  }

  /// 시간을 "오전/오후 HH:MM" 형식으로 포맷
  String _formatTime(int hour24, int minute) {
    final period = hour24 < 12 ? '오전' : '오후';
    final hour12 = hour24 == 0 ? 12 : (hour24 > 12 ? hour24 - 12 : hour24);
    final minuteStr = minute.toString().padLeft(2, '0');
    return '$period $hour12:$minuteStr';
  }

  /// 주어진 시간과 가장 가까운 시간 옵션의 인덱스 찾기
  int _findClosestTimeIndex(DateTime target) {
    if (_timeOptions.isEmpty) return 0;

    final targetMinute = target.hour * 60 + target.minute;
    int closestIndex = 0;
    int minDiff =
        (targetMinute -
                (_timeOptions[0].dateTime.hour * 60 +
                    _timeOptions[0].dateTime.minute))
            .abs();

    for (int i = 1; i < _timeOptions.length; i++) {
      final optionMinute =
          _timeOptions[i].dateTime.hour * 60 + _timeOptions[i].dateTime.minute;
      final diff = (targetMinute - optionMinute).abs();

      if (diff < minDiff) {
        minDiff = diff;
        closestIndex = i;
      }
    }

    return closestIndex;
  }

  void _notifySelectionChanged() {
    if (_selectedIndex < 0 || _selectedIndex >= _timeOptions.length) return;

    final selectedOption = _timeOptions[_selectedIndex];

    if (widget.onSelectionChanged != null) {
      widget.onSelectionChanged!(selectedOption.dateTime, null);
    }
  }

  /// 버튼 텍스트 생성: "(오늘/내일)(날짜) (시간)"
  String _buildButtonText() {
    if (_selectedIndex < 0 || _selectedIndex >= _timeOptions.length) {
      return '설정하기';
    }

    final selectedOption = _timeOptions[_selectedIndex];
    final dayLabel = _isPickupToday ? '오늘' : '내일';
    final dateLabel = '${_pickupDate.month}/${_pickupDate.day}';

    return '$dayLabel($dateLabel) ${selectedOption.displayText}';
  }

  @override
  Widget build(BuildContext context) {
    return MgBottomsheet(
      Container(
        padding: EdgeInsets.all(MgSizes.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 타이틀과 날짜 정보 표시
            Text('픽업 시간 설정').md().bold(),
            Gaps.h16,
            _buildTimePicker(),
            Gaps.h24,
            MgButton(
              onPressed: () {
                if (_selectedIndex >= 0 &&
                    _selectedIndex < _timeOptions.length) {
                  final selectedOption = _timeOptions[_selectedIndex];
                  widget.onTimeSelected(selectedOption.dateTime, null);
                  context.pop();
                }
              },
              content: Text(_buildButtonText()).md().bold(),
            ).primary().constrained(height: 56),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePicker() {
    return SizedBox(
      height: 240,
      child: Stack(
        children: [
          // 중앙 선택 영역 하이라이트
          Center(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: MgColorScheme.gray9,
                borderRadius: BorderRadius.circular(MgRadius.sm),
              ),
            ),
          ),
          // 시간 선택 휠
          Center(
            child: ListWheelScrollView.useDelegate(
              controller: _timeController,
              itemExtent: 48,
              diameterRatio: 3,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: (index) {
                setState(() => _selectedIndex = index);
                _notifySelectionChanged();
              },
              childDelegate: ListWheelChildBuilderDelegate(
                builder: (context, index) {
                  if (index < 0 || index >= _timeOptions.length) return null;

                  final option = _timeOptions[index];
                  final isSelected = index == _selectedIndex;

                  return Center(
                    child: Text(option.displayText)
                        .textColor(
                          isSelected
                              ? MgColorScheme.gray1
                              : MgColorScheme.gray5,
                        )
                        .fontSize(isSelected ? MgFontSize.lg : MgFontSize.md)
                        .fontWeight(isSelected ? FontWeight.bold : FontWeight.normal),
                  );
                },
                childCount: _timeOptions.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
