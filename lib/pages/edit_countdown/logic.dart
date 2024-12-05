import 'package:count_down/entities/countdown_entity.dart';
import 'package:count_down/entities/tag_entity.dart';
import 'package:count_down/services/countdown_service.dart';
import 'package:count_down/services/tag_service.dart';
import 'package:count_down/style/icon.dart';
import 'package:count_down/utils/remind_advance_utils.dart';
import 'package:count_down/utils/toast_utils.dart';
import 'package:count_down/widgets/picker/repeat_picker.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
class EditCountdownController extends GetxController {
  ///
  EditCountdownController(this.entity);

  ///
  DbCountdownEntity? entity;

  ///
  var nameController = TextEditingController();

  ///
  DateTime get _dateTime => DateTime.parse(entity!.dateTime!);

  ///
  String get dateText => formatDate(_dateTime, [yyyy, '-', mm, '-', dd]);

  ///
  String? get timeText {
    if (entity?.isAllDay ?? true) {
      return null;
    } else {
      return formatDate(_dateTime, [HH, ':', nn]);
    }
  }

  ///
  String get repeatText {
    return CountdownRepeatType.fromName(entity!.repeat!).text;
  }

  ///
  String? get remindAdvanceText {
    return RemindAdvanceUtils.getRemindAdvanceText(entity!.remindAdvance);
  }

  ///
  String? get tagText {
    if (entity?.tagKey != null) {
      return TagService.to.findTagByKey(entity!.tagKey!).name!;
    }
    return null;
  }

  ///
  String get iconAsset => entity?.iconAsset ?? IconDataList.defaultIcon;

  ///
  Color get iconColor => entity?.iconColorValue != null
      ? Color(entity!.iconColorValue!)
      : IconColor.defaultColor;

  @override
  void onInit() {
    entity ??= DbCountdownEntity(
      dateTime: _formatDate(DateTime.now().copyWith(hour: 0, minute: 0)),
      repeat: CountdownRepeatType.once.name,
    );
    nameController.text = entity?.name ?? '';
    super.onInit();
  }

  ///
  void setName(String value) {
    entity?.name = value;
  }

  ///
  void setDate(DateTime value) {
    entity?.dateTime = _formatDate(
      _dateTime.copyWith(year: value.year, month: value.month, day: value.day),
    );
    update();
  }

  ///
  void setTime({bool isAllDay = false, Duration? value}) {
    entity?.isAllDay = isAllDay;
    if (!isAllDay && value != null) {
      entity?.dateTime = _formatDate(
        _dateTime.copyWith(
          hour: value.inHours,
          minute: value.inMinutes % Duration.secondsPerMinute,
        ),
      );
    }
    update();
  }

  ///
  void setRepeat(CountdownRepeatType type) {
    entity?.repeat = type.name;
    update();
  }

  ///
  void setRemindAdvance(int? value) {
    entity?.remindAdvance = value;
    update();
  }

  ///
  void setTag(DbTagEntity? value) {
    if (value == null) {
      entity?.tagKey = null;
    } else {
      entity?.tagKey = value.key;
    }
    update();
  }

  ///
  void setIcon(String asset, int iconColorValue) {
    entity?.iconAsset = asset;
    entity?.iconColorValue = iconColorValue;
    update();
  }

  ///
  void save() {
    if (entity?.name == null) {
      showToast('请填写事件名称');
      return;
    }

    if (entity?.key == null) {
      CountdownService.to.add(entity!).then((value) {
        if (value) {
          Navigator.of(Get.context!).pop();
        }
      });
    } else {
      CountdownService.to.update(entity!).then((value) {
        if (value) {
          Navigator.of(Get.context!).pop();
        }
      });
    }
  }
}

///
String _formatDate(DateTime value) {
  return formatDate(
    value,
    [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn],
  );
}
