import 'package:count_down/pages/home/home.dart';
import 'package:count_down/pages/settings/settings.dart';
import 'package:count_down/pages/splash.dart';
import 'package:count_down/widgets/cupertino_modal_sheet_route.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

///@Description:
///@Author:         @Mr.pan
///@CreateDate:     2021/12/11
class RoutersManager {
  static String splash = '/';
  static String welcome = '/welcome';
  static String home = '/home';
  static String settings = '/settings';

  static List<GetPage> getPages = [
    GetPage(name: splash, page: () => const SplashPage()),
    // GetPage(name: welcome, page: () => const WelcomePage()),
    GetPage(name: home, page: () => const HomePage()),
    GetPage(name: settings, page: () => const SettingsPage()),
  ];

  ///
  static void routingCallback(Routing? routing) {}

  /// 移除页面
  static void removeRoute(String name) {
    if (Get.currentRoute == name) {
      Get.backLegacy();
    } else {
      Get.removeRoute(name);
    }
  }
}

///
Future<T?> showCupertinoModalSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  bool fullscreenDialog = true,
  bool barrierDismissible = true,
  CupertinoModalSheetRouteTransition firstTransition =
      CupertinoModalSheetRouteTransition.none,
}) {
  return Navigator.of(context, rootNavigator: useRootNavigator).push(
    CupertinoModalSheetRoute<T>(
      builder: builder,
      settings: routeSettings,
      fullscreenDialog: fullscreenDialog,
      barrierDismissible: barrierDismissible,
      firstTransition: firstTransition,
    ),
  );
}

/// A page that creates a cupertino modal sheet [PageRoute].
class CupertinoModalSheetPage<T> extends Page<T> {
  final Widget child;
  final CupertinoModalSheetRouteTransition firstTransition;

  const CupertinoModalSheetPage({
    super.key,
    required this.child,
    super.name,
    super.arguments,
    super.restorationId,
    this.firstTransition = CupertinoModalSheetRouteTransition.none,
  });

  @override
  Route<T> createRoute(BuildContext context) {
    return CupertinoModalSheetRoute<T>(
      builder: (_) => child,
      settings: this,
      firstTransition: firstTransition,
    );
  }
}
