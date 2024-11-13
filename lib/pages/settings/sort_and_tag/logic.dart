import 'package:count_down/utils/log_util.dart';
import 'package:get/get.dart';

import '../../../entities/tag_entity.dart';
import '../../../services/tag_service.dart';

///
class SortAndTagController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  ///
  void delete(DbTagEntity tag) {
    TagService.to.deleteTag(tag);
  }
}
