import 'package:count_down/widgets/bottom_sheet.dart';
import 'package:count_down/widgets/picker/picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
Future<Duration?> showMyRepeatPicker() {
  return Get.bottomSheet<Duration?>(
    BottomSheetWidget(
      title: '重复',
      onConfirm: () {
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: MyPickerWidget(
          looping: false,
          items1: ['每'],
          items2: ['周重复', '月重复', '年重复'],
          onChanged: (List<String> value) {},
        ),
      ),
    ),
  );
}
