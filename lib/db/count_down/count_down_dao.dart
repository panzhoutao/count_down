
import 'package:count_down/entities/countdown_entity.dart';

///
abstract class CountdownDao {
  Future<bool> insert(DbCountdownEntity entity);

  Future<List<DbCountdownEntity>> queryAll();

  Future<bool> delete(DbCountdownEntity entity);
}
