
import 'package:count_down/pages/home.dart';
import 'package:count_down/pages/splash.dart';
import 'package:get/get.dart';

///@Description:
///@Author:         @Mr.pan
///@CreateDate:     2021/12/11
class RoutersManager {
  static String splash = '/';
  static String welcome = '/welcome';
  static String home = '/home';

  static List<GetPage> getPages = [
    GetPage(name: splash, page: () => const SplashPage()),
    // GetPage(name: welcome, page: () => const WelcomePage()),
    GetPage(name: home, page: () => const HomePage()),
  ];

  ///
  static void routingCallback(Routing? routing) {

  }

  /// 移除页面
  static void removeRoute(String name) {
    if (Get.currentRoute == name) {
      Get.backLegacy();
    } else {
      Get.removeRoute(name);
    }
  }
}
