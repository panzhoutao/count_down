import 'package:count_down/services/tag_service.dart';
import 'package:get/get.dart';

class AddTagLogic extends GetxController {
  ///
  void addTag(String value) {
    TagService.to.addTag(value).then((value) {
      if (value) {
        Get.back();
      }
    });
  }
}
