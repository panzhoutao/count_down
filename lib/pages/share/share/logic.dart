import 'dart:typed_data';
import 'package:count_down/utils/toast_utils.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:screenshot/screenshot.dart';

class ShareLogic extends GetxController {
  ///
  var screenshotController = ScreenshotController();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  ///
  void saveImage() async {
    screenshotController.capture(pixelRatio: 3).then((image) async {
      final result = await ImageGallerySaverPlus.saveImage(
        image!,
        quality: 100,
      );
      if (result != null) {
        showToast('保存到相册');
      }
    });
  }
}
