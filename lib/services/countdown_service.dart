import 'package:count_down/db/db_manager.dart';
import 'package:count_down/entities/countdown_entity.dart';
import 'package:get/get.dart';

///
class CountdownService extends GetxService {
  static CountdownService get to => Get.find();

  ///
  var dataList = <DbCountdownEntity>[].obs;

  @override
  void onInit() {
    updateList();
    super.onInit();
  }

  ///
  void updateList() async {
    dataList.assignAll(await getList());
  }

  ///
  Future<List<DbCountdownEntity>> getList() async {
    return DbManager.instance.countdownDao.queryAll();
  }

  ///
  Future<bool> add(DbCountdownEntity value) async {
    bool result = await DbManager.instance.countdownDao.insert(value);
    updateList();
    return result;
  }

  Future<bool> update(DbCountdownEntity value) async {
    bool result = await DbManager.instance.countdownDao.update(value);
    updateList();
    return result;
  }

  ///
  Future<bool> delete(DbCountdownEntity tag) async {
    bool result = await DbManager.instance.countdownDao.delete(tag);
    updateList();
    return result;
  }

  ///
  DbCountdownEntity findByKey(String key) {
    return dataList.firstWhere((element) => element.key == key);
  }

}