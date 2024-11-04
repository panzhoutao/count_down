import 'package:count_down/utils/log_util.dart';
import 'package:get/get.dart';

///
class SortAndTagController extends GetxController {

  ///
  List data = [];

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  ///
  void getData() {
    data.addAll([
      {'name': '1'},
      {'name': '2'},
      {'name': '3'},
      {'name': '4'},
    ]);

    update();
  }

  ///
  void delete(int index) {

  }

}