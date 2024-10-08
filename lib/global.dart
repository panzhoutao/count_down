import 'dart:io';
import 'package:count_down/utils/log_util.dart';
import 'package:count_down/utils/sp_utils.dart';

///@Description:
///@Author:         @Mr.pan
///@CreateDate:     2022/8/2
class Global {
  static Global? _instance;

  static Global get instance => _getInstance();

  factory Global() => _getInstance();

  ///
  static Global _getInstance() {
    return _instance ??= Global._internal();
  }

  Global._internal();

  ///
  Future<void> init() async {
    Log.i('Global init');
    HttpOverrides.global = MyHttpOverrides();
    await SPUtils.instance.initSP();
  }
}

/// 为了解决在vpn环境下握手不成功 （不安全）
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
