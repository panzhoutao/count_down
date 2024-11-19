import 'package:count_down/widgets/bottom_sheet.dart';
import 'package:count_down/widgets/picker/picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
enum CountdownRepeatType {
  once,
  weekly,
  monthly,
  yearly;

  static CountdownRepeatType fromName(String name) {
    return CountdownRepeatType.values.firstWhere((element) => element.name == name);
  }
}

extension CountdownRepeatTypeExtension on CountdownRepeatType {
  String get text {
    switch (this) {
      case CountdownRepeatType.once:
        return '不重复';
      case CountdownRepeatType.weekly:
        return '周重复';
      case CountdownRepeatType.monthly:
        return '月重复';
      case CountdownRepeatType.yearly:
        return '年重复';
    }
  }
}

///
void showMyRepeatPicker(Function(CountdownRepeatType type) onConfirm) {
  var selected = CountdownRepeatType.once;
  Get.bottomSheet(
    BottomSheetWidget(
      title: '重复',
      onConfirm: () {
        onConfirm(selected);
        Get.backLegacy();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: MyPickerWidget(
          looping: false,
          items1: ['每'],
          items2: ['不重复','周重复', '月重复', '年重复'],
          onChangedIndex: (List<int> value) {
            selected = CountdownRepeatType.values[value[1]];
          },
        ),
      ),
    ),
  );
}
