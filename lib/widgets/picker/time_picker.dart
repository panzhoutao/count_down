import 'package:count_down/widgets/bottom_sheet.dart';
import 'package:count_down/widgets/picker/picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

///
Future<Duration?> showMyTimePicker({Duration? selectedTime}) {
  selectedTime ??= Duration(hours: 9);
  return Get.bottomSheet<Duration?>(
    BottomSheetWidget(
      title: '时间',
      onConfirm: () {
        Get.backLegacy(result: selectedTime);
      },
      child: MyTimePickerWidget(),
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
  const MyTimePickerWidget({super.key});

  @override
  State<MyTimePickerWidget> createState() => _MyTimePickerWidgetState();
}

class _MyTimePickerWidgetState extends State<MyTimePickerWidget> {
  ///
  DayTimeType _type = DayTimeType.all;

  ///
  Widget _buildTime() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: MyPickerWidget(
        items1: List.generate(
          24,
          (int index) => '$index',
          growable: true,
        ),
        items2: List.generate(
          60,
          (int index) => '$index',
          growable: true,
        ),
        onChanged: (List<String> value) {},
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
          },
        ),
        _typeWidget(
          type: DayTimeType.time,
          title: '精准时间',
          onTap: () {
            setState(() {
              _type = DayTimeType.time;
            });
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
