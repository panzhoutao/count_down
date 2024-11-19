import 'package:count_down/generated/json/base/json_field.dart';

@JsonSerializable()
class DbCountdownEntity {
  ///
  int? id;

  ///
  String? name;

  /// 日期时间
  String? dateTime;

  /// 是否全天
  bool? isAllDay;

  /// 重复类型  - CountdownRepeatType
  String? repeat;

  /// 提前提醒 (天数)
  int? remindAdvance;

  /// 标签
  int? tagId;

  /// 是否完成
  bool? isDone;

  ///
  DbCountdownEntity({
    this.id,
    this.name,
    this.dateTime,
    this.isAllDay,
    this.repeat,
    this.remindAdvance,
    this.tagId,
    this.isDone,
  });

  ///
  factory DbCountdownEntity.fromJson(Map<String, dynamic> json) => DbCountdownEntity();
}
