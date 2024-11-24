import 'package:count_down/db/db_manager.dart';
import 'package:count_down/generated/json/base/json_convert_content.dart';
import 'package:count_down/generated/json/base/json_field.dart';

@JsonSerializable()
class DbTagEntity {
  DbTagEntity();

  String? key;
  String? name;

  ///
  factory DbTagEntity.fromJson(Map<String, dynamic> json) => DbTagEntity();

  /// key 暂用name , 后边做同步时候要用一个唯一标识
  Map<String, Object?> toSqlRaw() {
    return {
      DbManager().columnKey: key ?? name,
      DbManager().columnName: name,
    };
  }

  ///
  factory DbTagEntity.fromSqlRaw(Map<String, dynamic> json) {
    final dbTagEntity = DbTagEntity();
    final String? key =
        jsonConvert.convert<String>(json[DbManager().columnKey]);
    if (key != null) {
      dbTagEntity.key = key;
    }
    final String? name =
        jsonConvert.convert<String>(json[DbManager().columnName]);
    if (name != null) {
      dbTagEntity.name = name;
    }
    return dbTagEntity;
  }
}
