import 'package:count_down/generated/json/base/json_convert_content.dart';
import 'package:count_down/entities/countdown_entity.dart';
import 'package:count_down/db/db_manager.dart';

import 'package:count_down/generated/json/base/json_convert_content.dart';

import 'package:count_down/widgets/picker/repeat_picker.dart';


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
  final bool? isDone = jsonConvert.convert<bool>(json['isDone']);
  if (isDone != null) {
    dbCountdownEntity.isDone = isDone;
  }
  final String? topDateTime = jsonConvert.convert<String>(json['topDateTime']);
  if (topDateTime != null) {
    dbCountdownEntity.topDateTime = topDateTime;
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
  data['isDone'] = entity.isDone;
  data['topDateTime'] = entity.topDateTime;
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
    bool? isDone,
    String? topDateTime,
  }) {
    return DbCountdownEntity()
      ..key = key ?? this.key
      ..name = name ?? this.name
      ..dateTime = dateTime ?? this.dateTime
      ..isAllDay = isAllDay ?? this.isAllDay
      ..repeat = repeat ?? this.repeat
      ..remindAdvance = remindAdvance ?? this.remindAdvance
      ..tagKey = tagKey ?? this.tagKey
      ..isDone = isDone ?? this.isDone
      ..topDateTime = topDateTime ?? this.topDateTime;
  }
}