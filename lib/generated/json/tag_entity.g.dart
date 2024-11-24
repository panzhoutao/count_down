import 'package:count_down/generated/json/base/json_convert_content.dart';
import 'package:count_down/entities/tag_entity.dart';
import 'package:count_down/db/db_manager.dart';

import 'package:count_down/generated/json/base/json_convert_content.dart';


DbTagEntity $DbTagEntityFromJson(Map<String, dynamic> json) {
  final DbTagEntity dbTagEntity = DbTagEntity();
  final String? key = jsonConvert.convert<String>(json['key']);
  if (key != null) {
    dbTagEntity.key = key;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    dbTagEntity.name = name;
  }
  return dbTagEntity;
}

Map<String, dynamic> $DbTagEntityToJson(DbTagEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['key'] = entity.key;
  data['name'] = entity.name;
  return data;
}

extension DbTagEntityExtension on DbTagEntity {
  DbTagEntity copyWith({
    String? key,
    String? name,
  }) {
    return DbTagEntity()
      ..key = key ?? this.key
      ..name = name ?? this.name;
  }
}