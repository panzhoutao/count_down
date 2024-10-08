import 'package:bot_toast/bot_toast.dart';
import 'package:count_down/generated/l10n.dart';
import 'package:count_down/global.dart';
import 'package:count_down/router_manage.dart';
import 'package:count_down/style/theme_data.dart';
import 'package:count_down/utils/local_utils.dart';
import 'package:count_down/utils/log_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  init().then((value) {
    runApp(MyApp());
  });
}

///
Future init() async {
  await Global.instance.init();
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  ///
  final botToastBuilder = BotToastInit();

  ///
  Iterable<LocalizationsDelegate<dynamic>> get _localizationsDelegates => [
    S.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  ///
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context , child) {
        return GetMaterialApp(
          scaffoldMessengerKey: _scaffoldMessengerKey,
          theme: MyThemeData.instance.themeData,
          builder: (context, child) {
            child = botToastBuilder(context, child);
            return child;
          },
          navigatorObservers: [BotToastNavigatorObserver()],
          title: 'Clean robot',
          onGenerateTitle: (context) => 'Clean robot',
          getPages: RoutersManager.getPages,
          routingCallback: RoutersManager.routingCallback,
          initialRoute: RoutersManager.splash,
          supportedLocales: S.delegate.supportedLocales,
          locale: LocaleUtils().locale,
          localizationsDelegates: _localizationsDelegates,
          localeResolutionCallback: LocaleUtils().localeResolutionCallback,
          logWriterCallback: (String text, {bool? isError}) {
            Log.i(text);
          },
        );
      },
    );
  }
}
