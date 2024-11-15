import 'package:bibletree/config/palette.dart';
import 'package:bibletree/widgets/modal_inkwell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTimePicker extends StatefulWidget {
  final TimeOfDay initialTime;
  final Function(TimeOfDay) onSave;

  const CustomTimePicker({
    super.key,
    required this.initialTime,
    required this.onSave,
  });

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  // 오전, 오후 설정
  static const List<String> day = ['오전', '오후'];

  // 시간
  static const List<String> hour = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
  ];

  // 분
  static const List<String> minutes = [
    '00',
    '05',
    '10',
    '15',
    '20',
    '25',
    '30',
    '35',
    '40',
    '45',
    '50',
    '55',
  ];

  static const double itemExtent = 48;

  /* 선택된 시간 값 index */
  late int selectedDayIndex;
  late int selectedHourIndex;
  late int selectedMinuteIndex;

  /* 초기 값을 위한 ScrollController 정의 */
  late FixedExtentScrollController dayController;
  late FixedExtentScrollController hourController;
  late FixedExtentScrollController minuteController;

  @override
  void initState() {
    super.initState();

    selectedDayIndex = widget.initialTime.period == DayPeriod.pm ? 1 : 0;
    selectedHourIndex = (widget.initialTime.hourOfPeriod - 1).clamp(0, 11);
    selectedMinuteIndex = (widget.initialTime.minute / 5).round();

    dayController = FixedExtentScrollController(initialItem: selectedDayIndex);
    hourController =
        FixedExtentScrollController(initialItem: selectedHourIndex);
    minuteController =
        FixedExtentScrollController(initialItem: selectedMinuteIndex);
  }

  @override
  void dispose() {
    dayController.dispose();
    hourController.dispose();
    minuteController.dispose();
    super.dispose();
  }

  /// 선택된 시간을 저장하는 함수
  void _saveTimeAndClose() {
    final isPM = selectedDayIndex == 1;
    final int hour = selectedHourIndex + 1; // 1로 시작하기 때문에 + 1
    final int minute = selectedMinuteIndex * 5; // 5분 단위이기 때문에 index * 5
    final int hour24 = isPM // 24시간제로 변경
        ? (hour == 12 ? 12 : hour + 12)
        : (hour == 12 ? 0 : hour);

    final selectedTime = TimeOfDay(hour: hour24, minute: minute);
    widget.onSave(selectedTime);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: 140,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 오전 오후
                SizedBox(
                  height: itemExtent * 2,
                  width: 100,
                  child: CupertinoPicker.builder(
                    scrollController: dayController,
                    itemExtent: itemExtent,
                    childCount: day.length,
                    onSelectedItemChanged: (int value) {
                      setState(() {
                        selectedDayIndex = value;
                      });
                    },
                    itemBuilder: (context, index) => Center(
                      child: Text(day[index]),
                    ),
                  ),
                ),

                // 시간
                SizedBox(
                  height: itemExtent * 2,
                  width: 100,
                  child: CupertinoPicker.builder(
                    scrollController: hourController,
                    itemExtent: itemExtent,
                    childCount: hour.length,
                    onSelectedItemChanged: (int value) {
                      setState(() {
                        selectedHourIndex = value;
                      });
                    },
                    itemBuilder: (context, index) => Center(
                      child: Text(hour[index]),
                    ),
                  ),
                ),

                const Text(':', style: TextStyle(fontSize: Palette.subtitle)),

                // 분
                SizedBox(
                  height: itemExtent * 2,
                  width: 100,
                  child: CupertinoPicker.builder(
                    scrollController: minuteController,
                    itemExtent: itemExtent,
                    childCount: minutes.length,
                    onSelectedItemChanged: (int value) {
                      setState(() {
                        selectedMinuteIndex = value;
                      });
                    },
                    itemBuilder: (context, index) => Center(
                      child: Text(minutes[index]),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // 확인 버튼
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Ink(
              height: 56,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: ModalInkwell(
                title: '확인',
                isTop: true,
                isBottom: true,
                onTap: _saveTimeAndClose,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
