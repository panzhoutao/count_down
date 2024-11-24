import 'package:count_down/db/db_manager.dart';
import 'package:count_down/db/tag/tag_dao.dart';
import 'package:count_down/entities/tag_entity.dart';
import 'package:count_down/utils/log_util.dart';

class TagDaoImpl implements TagDao {
  ///
  final DbManager _dbManager = DbManager();

  @override
  Future<bool> delete(DbTagEntity tag) async {
    int result = await _dbManager.db.delete(
      _dbManager.tagTable,
      where: '${_dbManager.columnKey} = ?',
      whereArgs: [tag.key],
    );
    Log.i('db deleteTask = $result');
    return result > 0;
  }

  @override
  Future<bool> insert(DbTagEntity tag) async {
    int result = await _dbManager.db.insert(
      _dbManager.tagTable,
      tag.toSqlRaw(),
    );
    Log.i('db insertTask = $result');
    return result > 0;
  }

  @override
  Future<List<DbTagEntity>> queryAll() async {
    List<Map<String, dynamic>> list =
        await _dbManager.db.query(_dbManager.tagTable);
    List<DbTagEntity> result = [];
    for (var element in list) {
      result.add(DbTagEntity.fromSqlRaw(element));
    }
    Log.i('db queryTasks list = $result');
    return result;
  }
}
