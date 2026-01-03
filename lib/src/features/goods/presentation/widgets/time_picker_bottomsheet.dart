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

// TODO: 엽업 외 시간에는 다음날의 예약을 미리 할 수 있도록 설정
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
  List<TimeOption> _generateTimeOptions() {
    final options = <TimeOption>[];
    final now = DateTime.now();

    // 시작/종료 시간 (분 단위)
    int startMinute = 0;
    int endMinute = 24 * 60 - 30; // 23:30

    if (widget.startTime != null) {
      startMinute = widget.startTime!.hour * 60 + widget.startTime!.minute;
    }
    if (widget.endTime != null) {
      endMinute = widget.endTime!.hour * 60 + widget.endTime!.minute;
    }

    // 30분 단위로 반올림
    startMinute = ((startMinute + 14) ~/ 30) * 30; // 반올림
    endMinute = (endMinute ~/ 30) * 30; // 내림

    // 30분 단위로 시간 생성
    for (int minute = startMinute; minute <= endMinute; minute += 30) {
      final hour = minute ~/ 60;
      final min = minute % 60;

      final dateTime = DateTime(now.year, now.month, now.day, hour, min);
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

  @override
  Widget build(BuildContext context) {
    return MgBottomsheet(
      Container(
        padding: EdgeInsets.all(MgSizes.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('픽업 시간 설정').md().bold().margin(bottom: MgSizes.md),
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
              content: Text('설정하기').md().bold(),
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
                        .fontSize(isSelected ? MgFontSize.lg : MgFontSize.md),
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
