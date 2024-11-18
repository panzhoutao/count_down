import 'package:count_down/entities/countdown_entity.dart';
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

  @override
  void onInit() {
    entity ??= DbCountdownEntity(
      dateTime: _formatDate(DateTime.now().copyWith(hour: 0, minute: 0)),
      isAllDay: true,
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
  void save() {}
}

///
String _formatDate(DateTime value) {
  return formatDate(
    value,
    [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn],
  );
}
