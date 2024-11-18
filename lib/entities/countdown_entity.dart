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

  /// 重复
  String? repeat;

  /// 提前提醒
  String? timing;

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
    this.timing,
    this.tagId,
    this.isDone,
  });

  ///
  factory DbCountdownEntity.fromJson(Map<String, dynamic> json) => DbCountdownEntity();
}
