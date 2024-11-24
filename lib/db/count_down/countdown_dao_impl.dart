import 'package:count_down/db/count_down/count_down_dao.dart';
import 'package:count_down/db/db_manager.dart';
import 'package:count_down/entities/countdown_entity.dart';
import 'package:count_down/utils/log_util.dart';

///
class CountdownDaoImpl implements CountdownDao {
  ///
  final DbManager _dbManager = DbManager();

  @override
  Future<bool> delete(DbCountdownEntity entity) async {
    int result = await _dbManager.db.delete(
      _dbManager.countdownTable,
      where: '${_dbManager.columnKey} = ?',
      whereArgs: [entity.key],
    );
    Log.i('db deleteTask = $result');
    return result > 0;
  }

  @override
  Future<bool> insert(DbCountdownEntity entity) async {
      int result = await _dbManager.db.insert(
      _dbManager.countdownTable,
        entity.toSqlRaw(),
    );
    Log.i('db insertTask = $result');
    return result > 0;
  }

  @override
  Future<List<DbCountdownEntity>> queryAll() async {
    List<Map<String, dynamic>> list =
        await _dbManager.db.query(_dbManager.countdownTable);
    List<DbCountdownEntity> result = [];
    for (var element in list) {
      result.add(DbCountdownEntity.fromSqlRaw(element));
    }
    Log.i('db queryTasks list = $result');
    return result;
  }
}
