import 'package:count_down/db/db_manager.dart';
import 'package:count_down/generated/json/base/json_field.dart';

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
    final DbTagEntity dbCleanTaskEntity = DbTagEntity();
    // final int? id = jsonConvert.convert<int>(json['id']);
    // if (id != null) {
    //   dbCleanTaskEntity.id = id;
    // }
    // final int? status = jsonConvert.convert<int>(json['status']);
    // if (status != null) {
    //   dbCleanTaskEntity.status = status;
    // }
    // final CleanTaskEntity? data =
    // jsonConvert.convert<CleanTaskEntity>(jsonDecode(json['data']));
    // if (data != null) {
    //   dbCleanTaskEntity.data = data;
    // }
    return dbCleanTaskEntity;
  }
}
