import 'package:count_down/utils/log_util.dart';
import 'package:get/get.dart';

///
class SortAndTagController extends GetxController {

  ///
  List data = [];

  @override
  void onInit() {
    _getData();
    super.onInit();
  }

  ///
  void _getData() {
    data.addAll([
      {'name': '1'},
      {'name': '2'},
      {'name': '3'},
      {'name': '4'},
    ]);
    Log.i('22222---- ${data.length}');

    update();
  }

  ///
  void delete(int index) {

  }

}