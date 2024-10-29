import 'package:count_down/style/theme_data.dart';
import 'package:count_down/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_wheel_date_picker/scroll_wheel_date_picker.dart';

///
Future<DateTime?> showMyDatePicker() {
  DateTime selectedDate = DateTime.now();
  return Get.bottomSheet<DateTime?>(
    BottomSheetWidget(
      title: '日期',
      child: ScrollWheelDatePicker(
        theme: FlatDatePickerTheme(
          backgroundColor: MyThemeData.instance.backgroundColor,
          overlay: ScrollWheelDatePickerOverlay.none,
          itemTextStyle: defaultItemTextStyle.copyWith(color: Colors.black),
          overlayColor: Colors.black,
          overAndUnderCenterOpacity: 0.2,
        ),
      ),
    ),
  );
}
