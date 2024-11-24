import 'package:count_down/generated/json/base/json_convert_content.dart';
import 'package:count_down/entities/countdown_entity.dart';
import 'package:count_down/db/db_manager.dart';

import 'package:count_down/generated/json/base/json_convert_content.dart';


DbCountdownEntity $DbCountdownEntityFromJson(Map<String, dynamic> json) {
  final DbCountdownEntity dbCountdownEntity = DbCountdownEntity();
  final String? key = jsonConvert.convert<String>(json['key']);
  if (key != null) {
    dbCountdownEntity.key = key;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    dbCountdownEntity.name = name;
  }
  final String? dateTime = jsonConvert.convert<String>(json['dateTime']);
  if (dateTime != null) {
    dbCountdownEntity.dateTime = dateTime;
  }
  final bool? isAllDay = jsonConvert.convert<bool>(json['isAllDay']);
  if (isAllDay != null) {
    dbCountdownEntity.isAllDay = isAllDay;
  }
  final String? repeat = jsonConvert.convert<String>(json['repeat']);
  if (repeat != null) {
    dbCountdownEntity.repeat = repeat;
  }
  final int? remindAdvance = jsonConvert.convert<int>(json['remindAdvance']);
  if (remindAdvance != null) {
    dbCountdownEntity.remindAdvance = remindAdvance;
  }
  final String? tagKey = jsonConvert.convert<String>(json['tagKey']);
  if (tagKey != null) {
    dbCountdownEntity.tagKey = tagKey;
  }
  final bool? isTop = jsonConvert.convert<bool>(json['isTop']);
  if (isTop != null) {
    dbCountdownEntity.isTop = isTop;
  }
  return dbCountdownEntity;
}

Map<String, dynamic> $DbCountdownEntityToJson(DbCountdownEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['key'] = entity.key;
  data['name'] = entity.name;
  data['dateTime'] = entity.dateTime;
  data['isAllDay'] = entity.isAllDay;
  data['repeat'] = entity.repeat;
  data['remindAdvance'] = entity.remindAdvance;
  data['tagKey'] = entity.tagKey;
  data['isTop'] = entity.isTop;
  return data;
}

extension DbCountdownEntityExtension on DbCountdownEntity {
  DbCountdownEntity copyWith({
    String? key,
    String? name,
    String? dateTime,
    bool? isAllDay,
    String? repeat,
    int? remindAdvance,
    String? tagKey,
    bool? isTop,
  }) {
    return DbCountdownEntity()
      ..key = key ?? this.key
      ..name = name ?? this.name
      ..dateTime = dateTime ?? this.dateTime
      ..isAllDay = isAllDay ?? this.isAllDay
      ..repeat = repeat ?? this.repeat
      ..remindAdvance = remindAdvance ?? this.remindAdvance
      ..tagKey = tagKey ?? this.tagKey
      ..isTop = isTop ?? this.isTop;
  }
}