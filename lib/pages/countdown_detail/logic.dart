import 'package:count_down/entities/countdown_entity.dart';
import 'package:count_down/services/countdown_service.dart';
import 'package:get/get.dart';

///
class CountdownDetailLogic extends GetxController {

  ///
  CountdownDetailLogic(this.keyId) {
    update();
  }

  ///
  final String keyId;

  ///
  late DbCountdownEntity data;

  ///
  void updateData() {
    data = CountdownService.to.findByKey(keyId);
    update();
  }

  ///
  void complete() {

  }

  ///
  void setTop() {

  }

}