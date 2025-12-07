import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/widgets/mg_bottomsheet.dart';
import 'package:magambell/src/widgets/mg_button.dart';

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

  /// 선택 가능한 시작 시간 (옵션)
  /// - 날짜는 무시하고 hour/minute 기준으로만 사용
  final DateTime? startTime;

  /// 선택 가능한 종료 시간 (옵션)
  /// - 날짜는 무시하고 hour/minute 기준으로만 사용
  final DateTime? endTime;

  /// 최종 "설정하기" 버튼 눌렀을 때 호출
  /// - errorMessage 가 null 이면 유효한 시간
  /// - errorMessage 가 non-null 이면 범위 밖 (일반적으로 버튼이 disabled라 안 불림)
  final void Function(DateTime selected, String? errorMessage) onTimeSelected;

  /// 휠이 움직여서 "현재 선택 값"이 바뀔 때마다 호출
  /// - errorMessage가 null이면 유효
  /// - errorMessage가 non-null이면 범위 밖
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
  late FixedExtentScrollController _periodController;
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;

  late int _selectedPeriod; // 0: 오전(AM), 1: 오후(PM)
  late int _selectedHour; // 1-12
  late int _selectedMinute; // 0-59 (10분 단위)

  final List<String> _periods = ['오전', '오후'];
  final List<int> _hours = List.generate(12, (index) => index + 1); // 1-12
  final List<int> _minutes = List.generate(
    6,
    (index) => index * 10,
  ); // 0,10,20,30,40,50

  int? get _startMinuteOfDay => widget.startTime == null
      ? null
      : widget.startTime!.hour * 60 + widget.startTime!.minute;

  int? get _endMinuteOfDay => widget.endTime == null
      ? null
      : widget.endTime!.hour * 60 + widget.endTime!.minute;

  String? _currentErrorMessage; // 버튼 enable/disable 기준

  @override
  void initState() {
    super.initState();

    final base = widget.initialTime ?? DateTime.now();
    int baseMinuteOfDay = base.hour * 60 + base.minute;

    // 초기값은 10분 단위로 반올림
    baseMinuteOfDay = ((baseMinuteOfDay / 10).round()) * 10;
    if (baseMinuteOfDay < 0) baseMinuteOfDay = 0;
    if (baseMinuteOfDay > 24 * 60 - 10) {
      baseMinuteOfDay = 24 * 60 - 10;
    }

    // 초기값이 범위 밖이면 근처 유효 값으로 클램프
    final start = _startMinuteOfDay;
    final end = _endMinuteOfDay;
    if (start != null && baseMinuteOfDay < start) {
      baseMinuteOfDay = start;
    }
    if (end != null && baseMinuteOfDay > end) {
      baseMinuteOfDay = end;
    }

    final hour24 = baseMinuteOfDay ~/ 60;
    final minute = baseMinuteOfDay % 60;

    _selectedPeriod = hour24 >= 12 ? 1 : 0;
    _selectedHour = hour24 == 0 ? 12 : (hour24 > 12 ? hour24 - 12 : hour24);
    _selectedMinute = minute;

    _periodController = FixedExtentScrollController(
      initialItem: _selectedPeriod,
    );
    _hourController = FixedExtentScrollController(
      initialItem: _selectedHour - 1,
    );
    _minuteController = FixedExtentScrollController(
      initialItem: _selectedMinute ~/ 10,
    );

    // 초기 상태도 한 번 콜백 + 에러 계산
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _notifySelectionChanged();
    });
  }

  @override
  void dispose() {
    _periodController.dispose();
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  /// 현재 선택을 24시간제 + minuteOfDay로 변환
  int _currentHour24() {
    if (_selectedPeriod == 0) {
      // 오전
      return _selectedHour == 12 ? 0 : _selectedHour;
    } else {
      // 오후
      return _selectedHour == 12 ? 12 : _selectedHour + 12;
    }
  }

  int _currentMinuteOfDay() {
    final hour24 = _currentHour24();
    return hour24 * 60 + _selectedMinute;
  }

  bool _isWithinRange(int minuteOfDay) {
    final start = _startMinuteOfDay;
    final end = _endMinuteOfDay;

    if (start != null && minuteOfDay < start) {
      return false;
    }
    if (end != null && minuteOfDay > end) {
      return false;
    }
    return true;
  }

  String _formatMinuteOfDay(int minuteOfDay) {
    final h = minuteOfDay ~/ 60;
    final m = minuteOfDay % 60;
    final hh = h.toString().padLeft(2, '0');
    final mm = m.toString().padLeft(2, '0');
    return '$hh:$mm';
  }

  String? _errorMessageFor(int minuteOfDay) {
    if (_isWithinRange(minuteOfDay)) return null;

    final start = _startMinuteOfDay;
    final end = _endMinuteOfDay;

    if (start == null && end == null) return null;

    final startStr = start != null ? _formatMinuteOfDay(start) : null;
    final endStr = end != null ? _formatMinuteOfDay(end) : null;

    if (startStr != null && endStr != null) {
      return '선택 가능한 시간은 $startStr ~ $endStr 입니다.';
    } else if (startStr != null) {
      return '$startStr 이후의 시간만 선택할 수 있어요.';
    } else {
      return '$endStr 이전의 시간만 선택할 수 있어요.';
    }
  }

  void _notifySelectionChanged() {
    final hour24 = _currentHour24();
    final minuteOfDay = _currentMinuteOfDay();
    final error = _errorMessageFor(minuteOfDay);

    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, hour24, _selectedMinute);

    // 에러 상태 갱신 → 버튼 enable/disable
    setState(() {
      _currentErrorMessage = error;
    });

    if (widget.onSelectionChanged != null) {
      widget.onSelectionChanged!(dt, error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasError = _currentErrorMessage != null;

    return MgBottomsheet(
      Container(
        padding: EdgeInsets.all(MgSizes.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('픽업 시간 설정').lg().bold().margin(bottom: MgSizes.md),
            Gaps.h16,
            _buildTimePicker(),
            Gaps.h24,
            MgButton(
              onPressed: hasError
                  ? null
                  : () {
                      //TODO[time-picker]: hasError시 여기서 toast!
                      final hour24 = _currentHour24();
                      final minuteOfDay = _currentMinuteOfDay();
                      final error = _errorMessageFor(minuteOfDay);

                      final now = DateTime.now();
                      final dt = DateTime(
                        now.year,
                        now.month,
                        now.day,
                        hour24,
                        _selectedMinute,
                      );

                      // 최종 콜백에서 error 여부에 따라 분기 가능
                      widget.onTimeSelected(dt, error);

                      if (error == null) context.pop();
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 오전/오후 선택
              Expanded(
                flex: 2,
                child: _buildWheelScrollView(
                  controller: _periodController,
                  itemCount: _periods.length,
                  onSelectedItemChanged: (index) {
                    setState(() {
                      _selectedPeriod = index;
                    });
                    _notifySelectionChanged();
                  },
                  itemBuilder: (index) {
                    final isSelected = index == _selectedPeriod;
                    return Center(
                      child: Text(_periods[index])
                          .textColor(
                            isSelected
                                ? MgColorScheme.text
                                : MgColorScheme.gray5,
                          )
                          .lg(),
                    );
                  },
                ),
              ),
              // 시간 선택 (1-12)
              Expanded(
                flex: 2,
                child: _buildWheelScrollView(
                  controller: _hourController,
                  itemCount: _hours.length,
                  onSelectedItemChanged: (index) {
                    setState(() {
                      _selectedHour = _hours[index];
                    });
                    _notifySelectionChanged();
                  },
                  itemBuilder: (index) {
                    final hour = _hours[index];
                    final isSelected = hour == _selectedHour;
                    return Center(
                      child: Text(hour.toString())
                          .textColor(
                            isSelected
                                ? MgColorScheme.text
                                : MgColorScheme.gray5,
                          )
                          .xl(),
                    );
                  },
                ),
              ),
              // 분 선택 (0-50, 10분 간격)
              Expanded(
                flex: 2,
                child: _buildWheelScrollView(
                  controller: _minuteController,
                  itemCount: _minutes.length,
                  onSelectedItemChanged: (index) {
                    setState(() {
                      _selectedMinute = _minutes[index];
                    });
                    _notifySelectionChanged();
                  },
                  itemBuilder: (index) {
                    final minute = _minutes[index];
                    final isSelected = minute == _selectedMinute;
                    return Center(
                      child: Text(minute.toString().padLeft(2, '0'))
                          .textColor(
                            isSelected
                                ? MgColorScheme.text
                                : MgColorScheme.gray5,
                          )
                          .xl(),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWheelScrollView({
    required FixedExtentScrollController controller,
    required int itemCount,
    required Function(int) onSelectedItemChanged,
    required Widget Function(int) itemBuilder,
  }) {
    return ListWheelScrollView.useDelegate(
      controller: controller,
      itemExtent: 48,
      diameterRatio: 1.5,
      physics: const FixedExtentScrollPhysics(),
      onSelectedItemChanged: onSelectedItemChanged,
      childDelegate: ListWheelChildBuilderDelegate(
        builder: (context, index) => itemBuilder(index),
        childCount: itemCount,
      ),
    );
  }
}
