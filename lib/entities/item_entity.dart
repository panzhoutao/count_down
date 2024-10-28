import 'package:count_down/generated/json/base/json_field.dart';

@JsonSerializable()
class ItemEntity {
  ///
  String? id;

  ///
  String? name;

  ///
  String? date;

  ///
  String? time;

  ///
  String? repeat;

  ///
  String? timing;

  ///
  String? tag;

  ///
  bool? isDone;

  ///
  ItemEntity({
    this.id,
    this.name,
    this.date,
    this.time,
    this.repeat,
    this.timing,
    this.tag,
    this.isDone,
  });

  ///
  factory ItemEntity.fromJson(Map<String, dynamic> json) => ItemEntity();
}
