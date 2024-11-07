import 'package:count_down/entities/tag_entity.dart';
import 'package:get/get.dart';
import '../db/db_manager.dart';

///
interface class TegListener {

}

///
class TagService extends GetxService {
  static TagService get to => Get.find();

  ///
  List<DbTagEntity> tagList = [];

  ///
  Future<bool> addTag(String value) {
    var tag = DbTagEntity()..name = value;
    return DbManager.instance.tagDao.insert(tag);
  }
}
