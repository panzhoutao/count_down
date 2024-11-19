import 'package:count_down/widgets/bottom_sheet.dart';
import 'package:count_down/widgets/picker/picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

///
typedef OnMyTimerPicker = void Function(bool isAllDay, [Duration? value]);

///
void showMyTimePicker({OnMyTimerPicker? onPicker}) {
  DayTimeType type = DayTimeType.all;
  Duration? duration;
  Get.bottomSheet(
    BottomSheetWidget(
      title: '时间',
      onConfirm: () {
        onPicker?.call(type == DayTimeType.all, duration);
        Get.backLegacy();
      },
      child: MyTimePickerWidget(
        onTypeChanged: (DayTimeType value) {
          type = value;
        },
        onDurationChanged: (Duration value) {
          duration = value;
        },
      ),
    ),
  );
}

///
enum DayTimeType {
  all,
  time,
}

///
class MyTimePickerWidget extends StatefulWidget {
  const MyTimePickerWidget({
    super.key,
    required this.onTypeChanged,
    required this.onDurationChanged,
  });

  ///
  final Function(DayTimeType type) onTypeChanged;

  ///
  final Function(Duration duration) onDurationChanged;

  @override
  State<MyTimePickerWidget> createState() => _MyTimePickerWidgetState();
}

class _MyTimePickerWidgetState extends State<MyTimePickerWidget> {
  ///
  DayTimeType _type = DayTimeType.all;

  var items1 = List.generate(
    24,
    (int index) => '$index',
    growable: true,
  );

  var items2 = List.generate(
    60,
    (int index) => '$index',
    growable: true,
  );

  ///
  Widget _buildTime() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: MyPickerWidget(
        items1: items1,
        items2: items2,
        onChangedIndex: (List<int> value) {
          widget.onDurationChanged(Duration(
            hours: int.parse(items1[value[0]]),
            minutes: int.parse(items2[value[1]]),
          ));
        },
      ),
    );
  }

  ///
  Widget _typeWidget({
    required DayTimeType type,
    required String title,
    required Function() onTap,
  }) {
    IconData icon = _type == type
        ? Icons.check_circle
        : Icons.radio_button_unchecked_outlined;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 45.w,
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 12),
            Text(title),
          ],
        ),
      ),
    );
  }

  ///
  Widget _buildTypes() {
    return Column(
      children: [
        _typeWidget(
          type: DayTimeType.all,
          title: '全天',
          onTap: () {
            setState(() {
              _type = DayTimeType.all;
            });
            widget.onTypeChanged(_type);
          },
        ),
        _typeWidget(
          type: DayTimeType.time,
          title: '精准时间',
          onTap: () {
            setState(() {
              _type = DayTimeType.time;
            });
            widget.onTypeChanged(_type);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 38),
          child: _buildTypes(),
        ),
        if (_type == DayTimeType.time) _buildTime(),
      ],
    );
  }
}
