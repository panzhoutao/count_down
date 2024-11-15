import 'package:count_down/entities/tag_entity.dart';
import 'package:get/get.dart';
import '../db/db_manager.dart';

///
class TagService extends GetxService {
  static TagService get to => Get.find();

  ///
  var tagList = <DbTagEntity>[].obs;

  @override
  void onInit() {
    updateTagList();
    super.onInit();
  }

  ///
  Future<bool> addTag(String value) async {
    var tag = DbTagEntity()..name = value;
    bool result = await DbManager.instance.tagDao.insert(tag);
    updateTagList();
    return result;
  }

  ///
  void updateTagList() async {
    tagList.assignAll(await getTagList());
  }

  ///
  Future<List<DbTagEntity>> getTagList() async {
    return await DbManager.instance.tagDao.queryAll();
  }

  ///
  Future<bool> deleteTag(DbTagEntity tag) async {
    bool result = await DbManager.instance.tagDao.delete(tag);
    updateTagList();
    return result;
  }
}
