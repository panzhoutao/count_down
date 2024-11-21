import 'package:count_down/entities/countdown_entity.dart';
import 'package:count_down/entities/tag_entity.dart';
import 'package:count_down/services/tag_service.dart';
import 'package:count_down/utils/remind_advance_utils.dart';
import 'package:count_down/utils/toast_utils.dart';
import 'package:count_down/widgets/picker/repeat_picker.dart';
import 'package:date_format/date_format.dart';
import 'package:get/get.dart';

///
class EditCountdownController extends GetxController {
  ///
  EditCountdownController(this.entity);

  ///
  DbCountdownEntity? entity;

  ///
  DateTime get _dateTime => DateTime.parse(entity!.dateTime!);

  ///
  String get dateText => formatDate(_dateTime, [yyyy, '-', mm, '-', dd]);

  ///
  String get timeText {
    if (entity?.isAllDay ?? true) {
      return '全天';
    } else {
      return formatDate(_dateTime, [HH, ':', nn]);
    }
  }

  ///
  String get repeatText {
    return CountdownRepeatType.fromName(entity!.repeat!).text;
  }

  ///
  String get remindAdvanceText {
    if (entity?.remindAdvance == null) {
      return '未设置';
    } else {
      return RemindAdvanceUtils.getRemindAdvanceText(entity!.remindAdvance!);
    }
  }

  ///
  String get tagText {
    if (entity?.tagId != null) {
      return TagService.to.findTagById(entity!.tagId!).name!;
    } else {
      return '无';
    }
  }

  @override
  void onInit() {
    entity ??= DbCountdownEntity(
      dateTime: _formatDate(DateTime.now().copyWith(hour: 0, minute: 0)),
      repeat: CountdownRepeatType.once.name,
    );
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
      entity?.tagId = null;
    } else {
      entity?.tagId = value.id;
    }
    update();
  }

  ///
  void save() {
    if (entity?.name == null) {
      showToast('请填写事件名称');
      return;
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
