import 'package:count_down/generated/json/base/json_convert_content.dart';
import 'package:count_down/entities/countdown_entity.dart';
import 'package:count_down/widgets/picker/repeat_picker.dart';


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
  final int? tagId = jsonConvert.convert<int>(json['tagId']);
  if (tagId != null) {
    dbCountdownEntity.tagId = tagId;
  }
  final bool? isTop = jsonConvert.convert<bool>(json['isTop']);
  if (isTop != null) {
    dbCountdownEntity.isTop = isTop;
  }
  return dbCountdownEntity;
}

Map<String, dynamic> $DbCountdownEntityToJson(DbCountdownEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['dateTime'] = entity.dateTime;
  data['isAllDay'] = entity.isAllDay;
  data['repeat'] = entity.repeat;
  data['remindAdvance'] = entity.remindAdvance;
  data['tagId'] = entity.tagId;
  data['isTop'] = entity.isTop;
  return data;
}

extension DbCountdownEntityExtension on DbCountdownEntity {
  DbCountdownEntity copyWith({
    int? id,
    String? name,
    String? dateTime,
    bool? isAllDay,
    String? repeat,
    int? remindAdvance,
    int? tagId,
    bool? isTop,
  }) {
    return DbCountdownEntity()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..dateTime = dateTime ?? this.dateTime
      ..isAllDay = isAllDay ?? this.isAllDay
      ..repeat = repeat ?? this.repeat
      ..remindAdvance = remindAdvance ?? this.remindAdvance
      ..tagId = tagId ?? this.tagId
      ..isTop = isTop ?? this.isTop;
  }
}