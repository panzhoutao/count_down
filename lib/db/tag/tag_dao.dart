import 'package:count_down/entities/tag_entity.dart';

///
abstract class TagDao {
  Future<bool> insert(DbTagEntity task);

  Future<List<DbTagEntity>> queryAll();

  Future<bool> delete(DbTagEntity task);
}
