import 'package:count_down/generated/json/base/json_field.dart';
import 'package:count_down/widgets/picker/repeat_picker.dart';

@JsonSerializable()
class DbCountdownEntity {
  ///
  int? id;

  ///
  String? name;

  /// 日期时间
  String? dateTime;

  /// 是否全天
  bool isAllDay;

  /// 重复类型  - CountdownRepeatType
  String? repeat;

  /// 提前提醒 (天数)
  int? remindAdvance;

  /// 标签
  int? tagId;

  /// 是否置顶
  bool isTop = false;

  ///
  DbCountdownEntity({
    this.id,
    this.name,
    this.dateTime,
    this.isAllDay = true,
    this.repeat,
    this.remindAdvance,
    this.tagId,
  });

  ///
  factory DbCountdownEntity.fromJson(Map<String, dynamic> json) => DbCountdownEntity();
}
