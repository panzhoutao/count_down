import 'package:count_down/widgets/bottom_sheet.dart';
import 'package:count_down/widgets/picker/picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

///
Future<Duration?> showMyTimingReminderPicker() {
  return Get.bottomSheet<Duration?>(
    BottomSheetWidget(
      title: '提前提醒',
      onConfirm: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 38),
        child: TimingReminderPickerWidget(),
      ),
    ),
  );
}

///
class TimingReminderPickerWidget extends StatefulWidget {
  const TimingReminderPickerWidget({super.key});

  @override
  State<TimingReminderPickerWidget> createState() =>
      _TimingReminderPickerWidgetState();
}

class _TimingReminderPickerWidgetState
    extends State<TimingReminderPickerWidget> {
  ///
  bool _isOpen = false;

  ///
  int _selectedIndex = 0;

  ///
  List<_ItemEntity> _items = [
    _ItemEntity(
      title: '当天',
      numberDays: 0,
    ),
    _ItemEntity(
      title: '1天前',
      numberDays: 1,
    ),
  ];

  ///
  Widget _buildOpen() {
    return Row(
      children: [
        Text('已开启'),
        Spacer(),
        CupertinoSwitch(
          value: _isOpen,
          onChanged: (value) {
            setState(() {
              _isOpen = value;
            });
          },
        ),
      ],
    );
  }

  ///
  Widget _buildList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _items.length,
      itemBuilder: (context , index) {
        IconData icon = _selectedIndex == index
            ? Icons.check_circle
            : Icons.radio_button_unchecked_outlined;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedIndex = index;
            });
          },
          child: SizedBox(
            height: 45.w,
            child: Row(
              children: [
                Icon(icon),
                SizedBox(width: 12),
                Text(_items[index].title),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOpen(),
          _buildList(),
        ],
      ),
    );
  }
}

class _ItemEntity {
  final String title;
  final int numberDays;

  _ItemEntity({
    required this.title,
    required this.numberDays,
  });
}
