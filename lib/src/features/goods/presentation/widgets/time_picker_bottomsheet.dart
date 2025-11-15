import 'package:flutter/material.dart';
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
    required this.onTimeSelected,
  });

  final DateTime? initialTime;
  final Function(DateTime) onTimeSelected;

  @override
  State<TimePickerBottomSheet> createState() => _TimePickerBottomSheetState();

  static Future<void> show(
    BuildContext context, {
    DateTime? initialTime,
    required Function(DateTime) onTimeSelected,
  }) {
    return MgBottomsheet.show(
      context,
      (context, bottomState) {
        return TimePickerBottomSheet(
          initialTime: initialTime,
          onTimeSelected: onTimeSelected,
        );
      },
      height: 450,
    );
  }
}

class _TimePickerBottomSheetState extends State<TimePickerBottomSheet> {
  late FixedExtentScrollController _periodController;
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;

  late int _selectedPeriod; // 0: 오전(AM), 1: 오후(PM)
  late int _selectedHour; // 1-12
  late int _selectedMinute; // 0-59

  final List<String> _periods = ['오전', '오후'];
  final List<int> _hours = List.generate(12, (index) => index + 1); // 1-12
  final List<int> _minutes = List.generate(6, (index) => index * 10); // 0, 10, 20, 30, 40, 50

  @override
  void initState() {
    super.initState();

    final now = widget.initialTime ?? DateTime.now();
    final hour24 = now.hour;

    // 24시간제를 12시간제로 변환
    _selectedPeriod = hour24 >= 12 ? 1 : 0;
    _selectedHour = hour24 == 0
        ? 12
        : (hour24 > 12 ? hour24 - 12 : hour24);
    // 분을 가장 가까운 10분 단위로 반올림
    _selectedMinute = (now.minute / 10).round() * 10;
    if (_selectedMinute >= 60) _selectedMinute = 50;

    _periodController = FixedExtentScrollController(initialItem: _selectedPeriod);
    _hourController = FixedExtentScrollController(initialItem: _selectedHour - 1);
    _minuteController = FixedExtentScrollController(initialItem: _selectedMinute ~/ 10);
  }

  @override
  void dispose() {
    _periodController.dispose();
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  DateTime _getSelectedDateTime() {
    // 12시간제를 24시간제로 변환
    int hour24;
    if (_selectedPeriod == 0) {
      // 오전
      hour24 = _selectedHour == 12 ? 0 : _selectedHour;
    } else {
      // 오후
      hour24 = _selectedHour == 12 ? 12 : _selectedHour + 12;
    }

    return DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      hour24,
      _selectedMinute,
    );
  }

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {
                widget.onTimeSelected(_getSelectedDateTime());
                Navigator.of(context).pop();
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
                  },
                  itemBuilder: (index) {
                    final isSelected = index == _selectedPeriod;
                    return Center(
                      child: Text(
                        _periods[index],
                      ).textColor(
                        isSelected ? MgColorScheme.text : MgColorScheme.gray5,
                      ).lg(),
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
                  },
                  itemBuilder: (index) {
                    final hour = _hours[index];
                    final isSelected = hour == _selectedHour;
                    return Center(
                      child: Text(
                        hour.toString(),
                      ).textColor(
                        isSelected ? MgColorScheme.text : MgColorScheme.gray5,
                      ).xl(),
                    );
                  },
                ),
              ),
              // 분 선택 (0-59)
              Expanded(
                flex: 2,
                child: _buildWheelScrollView(
                  controller: _minuteController,
                  itemCount: _minutes.length,
                  onSelectedItemChanged: (index) {
                    setState(() {
                      _selectedMinute = _minutes[index];
                    });
                  },
                  itemBuilder: (index) {
                    final minute = _minutes[index];
                    final isSelected = minute == _selectedMinute;
                    return Center(
                      child: Text(
                        minute.toString().padLeft(2, '0'),
                      ).textColor(
                        isSelected ? MgColorScheme.text : MgColorScheme.gray5,
                      ).xl(),
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
      physics: FixedExtentScrollPhysics(),
      onSelectedItemChanged: onSelectedItemChanged,
      childDelegate: ListWheelChildBuilderDelegate(
        builder: (context, index) => itemBuilder(index),
        childCount: itemCount,
      ),
    );
  }
}
