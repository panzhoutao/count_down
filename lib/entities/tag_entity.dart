import 'package:count_down/db/db_manager.dart';
import 'package:count_down/generated/json/base/json_field.dart';
import '../generated/json/base/json_convert_content.dart';

@JsonSerializable()
class DbTagEntity {
  DbTagEntity();

  int? id;
  String? name;

  ///
  Map<String, Object?> toSqlRaw() {
    return {
      DbManager().columnId: id,
      DbManager().columnName: name,
    };
  }

  ///
  factory DbTagEntity.fromSqlRaw(Map<String, dynamic> json) {
    final dbTagEntity = DbTagEntity();
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
}
