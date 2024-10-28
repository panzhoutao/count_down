import 'package:count_down/generated/json/base/json_convert_content.dart';
import 'package:count_down/entities/item_entity.dart';

ItemEntity $ItemEntityFromJson(Map<String, dynamic> json) {
  final ItemEntity itemEntity = ItemEntity();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    itemEntity.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    itemEntity.name = name;
  }
  final String? date = jsonConvert.convert<String>(json['date']);
  if (date != null) {
    itemEntity.date = date;
  }
  final String? time = jsonConvert.convert<String>(json['time']);
  if (time != null) {
    itemEntity.time = time;
  }
  final String? repeat = jsonConvert.convert<String>(json['repeat']);
  if (repeat != null) {
    itemEntity.repeat = repeat;
  }
  final String? timing = jsonConvert.convert<String>(json['timing']);
  if (timing != null) {
    itemEntity.timing = timing;
  }
  final String? tag = jsonConvert.convert<String>(json['tag']);
  if (tag != null) {
    itemEntity.tag = tag;
  }
  final bool? isDone = jsonConvert.convert<bool>(json['isDone']);
  if (isDone != null) {
    itemEntity.isDone = isDone;
  }
  return itemEntity;
}

Map<String, dynamic> $ItemEntityToJson(ItemEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['date'] = entity.date;
  data['time'] = entity.time;
  data['repeat'] = entity.repeat;
  data['timing'] = entity.timing;
  data['tag'] = entity.tag;
  data['isDone'] = entity.isDone;
  return data;
}

extension ItemEntityExtension on ItemEntity {
  ItemEntity copyWith({
    String? id,
    String? name,
    String? date,
    String? time,
    String? repeat,
    String? timing,
    String? tag,
    bool? isDone,
  }) {
    return ItemEntity()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..date = date ?? this.date
      ..time = time ?? this.time
      ..repeat = repeat ?? this.repeat
      ..timing = timing ?? this.timing
      ..tag = tag ?? this.tag
      ..isDone = isDone ?? this.isDone;
  }
}