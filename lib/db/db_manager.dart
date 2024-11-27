import 'package:count_down/db/count_down/count_down_dao.dart';
import 'package:count_down/db/count_down/countdown_dao_impl.dart';
import 'package:count_down/db/tag/tag_dao.dart';
import 'package:count_down/db/tag/tag_dao_impl.dart';
import 'package:count_down/utils/log_util.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// 数据库
class DbManager {
  factory DbManager() => _getInstance();

  static DbManager get instance => _getInstance();

  static DbManager? _instance;

  static DbManager _getInstance() {
    return _instance ??= DbManager._internal();
  }

  DbManager._internal() {
    _init();
  }

  late Database db;

  ///
  void _init() {
    Log.i('初始化数据库');
  }

  final _databaseVersion = 1;
  final _databaseName = "count_down.db";
  final tagTable = "tag";
  final countdownTable = "countdown_detail";
  final columnKey = 'key';
  final columnName = 'name';
  final columnDateTime = 'date_time';
  final columnIsAllDay = 'is_all_day';
  final columnRepeat = 'repeat';
  final columnRemindAdvance = 'remind_advance';
  final columnTagKey = 'tag_key';
  final columnIsTop = 'is_top';

  /// 打开数据库
  Future<Database> openDb() async {
    db = await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) {
        createTagTable(db);
        createCountdownTable(db);
      },
      onUpgrade: (db, oldVersion, newVersion) {
        Log.i('数据库升级：$oldVersion -> $newVersion');
      },
      version: _databaseVersion,
    );
    Log.i('数据库打开（${db.isOpen}): $db');
    return db;
  }

  /// 创建标签表
  Future<void> createTagTable(Database db) {
    Log.i('数据表$tagTable 创建');
    return db.execute('''
      CREATE TABLE $tagTable (
        $columnKey TEXT PRIMARY KEY,
        $columnName TEXT
      )
    ''');
  }

  /// 创建倒计时事件表
  Future<void> createCountdownTable(Database db) {
    Log.i('数据表$countdownTable创建');
    return db.execute('''
        CREATE TABLE $countdownTable (
        $columnKey TEXT PRIMARY KEY,
        $columnName TEXT,
        $columnDateTime TEXT,
        $columnIsAllDay INTEGER,
        $columnRepeat TEXT,
        $columnRemindAdvance INTEGER NULL, 
        $columnTagKey TEXT NULL,
        $columnIsTop INTEGER
      )
    ''');
  }

  ///
  TagDao get tagDao => TagDaoImpl();

  ///
  CountdownDao get countdownDao => CountdownDaoImpl();
}
