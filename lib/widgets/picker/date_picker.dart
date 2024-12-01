import 'package:count_down/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scroll_datetime_picker/scroll_datetime_picker.dart';
import 'package:intl/intl.dart';

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
        padding: EdgeInsets.symmetric(horizontal: 12.w ,vertical: 10.w),
        child: ScrollDateTimePicker(
          style: DateTimePickerStyle(
            activeStyle: TextStyle(color: Colors.black, fontSize: 18.sp),
            inactiveStyle: TextStyle(color: Colors.grey, fontSize: 18.sp),
          ),
          centerWidget: DateTimePickerCenterWidget(
            builder: (context, constraints, child) => DecoratedBox(
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                color: Color(0xFFC6DEFF),
              ),
            ),
          ),
          itemExtent: 55.w,
          dateOption: DateTimePickerOption(
            dateFormat: DateFormat('yyyyMMMdd', 'zh'),
            minDate: DateTime(2000, 1),
            maxDate: DateTime(2099, 12),
            initialDate: DateTime.now(),
          ),
          onChange: (date) {
            selectedDate = date;
          },
        ),
      ),
    ),
  );
}
