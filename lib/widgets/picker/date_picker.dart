import 'package:count_down/style/theme_data.dart';
import 'package:count_down/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_wheel_date_picker/scroll_wheel_date_picker.dart';

///
Future<DateTime?> showMyDatePicker({DateTime? selectedDate}) {
  selectedDate ??= DateTime.now();
  return Get.bottomSheet<DateTime?>(
    BottomSheetWidget(
      title: '日期',
      onConfirm: () {
        Get.backLegacy(result: selectedDate);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ScrollWheelDatePicker(
          theme: FlatDatePickerTheme(
            backgroundColor: MyThemeData.instance.backgroundColor,
            overlay: ScrollWheelDatePickerOverlay.highlight,
            itemTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
            ),
            overlayColor: Color(0xFFC6DEFF),
            overAndUnderCenterOpacity: 0.4,
          ),
          onSelectedItemChanged: (date) {
            selectedDate = date;
          },
        ),
      ),
    ),
  );
}
