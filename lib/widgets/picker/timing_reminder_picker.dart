import 'package:count_down/utils/remind_advance_utils.dart';
import 'package:count_down/widgets/bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

///
void showRemindAdvancePicker(Function(int? value) onConfirm) {
  int? selected;
  Get.bottomSheet(
    BottomSheetWidget(
      title: '提前提醒',
      onConfirm: () {
        onConfirm(selected);
        Get.backLegacy();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 38),
        child: TimingReminderPickerWidget(
          onChange: (value) {
            selected = value;
          },
        ),
      ),
    ),
  );
}

///
class TimingReminderPickerWidget extends StatefulWidget {
  const TimingReminderPickerWidget({
    super.key,
    this.onChange,
  });

  ///
  final Function(int? value)? onChange;

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
  final List<int> _items = [0, 1, 2, 3, 7];

  ///
  void _changeValue() {
    if (_isOpen) {
       widget.onChange?.call(_items[_selectedIndex]);
    } else {
      widget.onChange?.call(null);
    }
  }

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
            _changeValue();
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
      itemBuilder: (context, index) {
        IconData icon = _selectedIndex == index
            ? Icons.check_circle
            : Icons.radio_button_unchecked_outlined;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedIndex = index;
            });
            _changeValue();
          },
          child: SizedBox(
            height: 45.w,
            child: Row(
              children: [
                Icon(icon),
                SizedBox(width: 12),
                Text(RemindAdvanceUtils.getRemindAdvanceText(_items[index])),
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
