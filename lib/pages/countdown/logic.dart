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
  DateTime get dateTime => DateTime.parse(entity!.dateTime!);

  @override
  void onInit() {
    entity ??= DbCountdownEntity();
    super.onInit();
  }

  ///
  void setName(String value) {
    entity?.name = value;
  }

  ///
  void setDate(DateTime value) {
    entity?.dateTime = _formatDate(
      dateTime.copyWith(year: value.year, month: value.month, day: value.day),
    );
    update();
  }

  ///
  void setTime(Duration value) {
    entity?.dateTime = _formatDate(
      dateTime.copyWith(
        hour: value.inHours,
        minute: value.inMinutes % Duration.secondsPerMinute,
      ),
    );
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