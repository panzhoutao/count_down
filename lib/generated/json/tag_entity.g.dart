import 'package:count_down/generated/json/base/json_convert_content.dart';
import 'package:count_down/entities/tag_entity.dart';
import 'package:count_down/db/db_manager.dart';

import 'package:count_down/generated/json/base/json_convert_content.dart';


DbTagEntity $DbTagEntityFromJson(Map<String, dynamic> json) {
  final DbTagEntity dbTagEntity = DbTagEntity();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    dbTagEntity.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    dbTagEntity.name = name;
  }
  return dbTagEntity;
}

Map<String, dynamic> $DbTagEntityToJson(DbTagEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  return data;
}

extension DbTagEntityExtension on DbTagEntity {
  DbTagEntity copyWith({
    int? id,
    String? name,
  }) {
    return DbTagEntity()
      ..id = id ?? this.id
      ..name = name ?? this.name;
  }
}