import 'package:count_down/generated/json/base/json_convert_content.dart';
import 'package:count_down/entities/countdown_entity.dart';

DbCountdownEntity $DbCountdownEntityFromJson(Map<String, dynamic> json) {
  final DbCountdownEntity dbCountdownEntity = DbCountdownEntity();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    dbCountdownEntity.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    dbCountdownEntity.name = name;
  }
  final String? dateTime = jsonConvert.convert<String>(json['dateTime']);
  if (dateTime != null) {
    dbCountdownEntity.dateTime = dateTime;
  }
  final String? repeat = jsonConvert.convert<String>(json['repeat']);
  if (repeat != null) {
    dbCountdownEntity.repeat = repeat;
  }
  final String? timing = jsonConvert.convert<String>(json['timing']);
  if (timing != null) {
    dbCountdownEntity.timing = timing;
  }
  final int? tagId = jsonConvert.convert<int>(json['tagId']);
  if (tagId != null) {
    dbCountdownEntity.tagId = tagId;
  }
  final bool? isDone = jsonConvert.convert<bool>(json['isDone']);
  if (isDone != null) {
    dbCountdownEntity.isDone = isDone;
  }
  return dbCountdownEntity;
}

Map<String, dynamic> $DbCountdownEntityToJson(DbCountdownEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['dateTime'] = entity.dateTime;
  data['repeat'] = entity.repeat;
  data['timing'] = entity.timing;
  data['tagId'] = entity.tagId;
  data['isDone'] = entity.isDone;
  return data;
}

extension DbCountdownEntityExtension on DbCountdownEntity {
  DbCountdownEntity copyWith({
    int? id,
    String? name,
    String? dateTime,
    String? repeat,
    String? timing,
    int? tagId,
    bool? isDone,
  }) {
    return DbCountdownEntity()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..dateTime = dateTime ?? this.dateTime
      ..repeat = repeat ?? this.repeat
      ..timing = timing ?? this.timing
      ..tagId = tagId ?? this.tagId
      ..isDone = isDone ?? this.isDone;
  }
}