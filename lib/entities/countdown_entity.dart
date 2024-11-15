import 'package:count_down/generated/json/base/json_field.dart';

@JsonSerializable()
class DbCountdownEntity {
  ///
  int? id;

  ///
  String? name;

  ///
  String? dateTime;

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
    this.repeat,
    this.timing,
    this.tagId,
    this.isDone,
  });

  ///
  factory DbCountdownEntity.fromJson(Map<String, dynamic> json) => DbCountdownEntity();
}
