import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

///@Description:
///@Author:         @Mr.pan
///@CreateDate:     2022/1/7
class SPUtils {
  factory SPUtils() => _getInstance();

  static SPUtils get instance => _getInstance();

  static SPUtils? _instance;

  static SPUtils _getInstance() {
    _instance ??= SPUtils._internal();
    return _instance!;
  }

  SPUtils._internal() {
    // initSharePre();
  }

  late SharedPreferences _sp;

  final String _kLocale = 'locale';

  ///init SharedPreferences
  Future<void> initSP() async {
    _sp = await SharedPreferences.getInstance();
  }

  ///
  void setString(String key , String value) {
    _sp.setString(key, value);
  }

  String? getString(String key) {
    return _sp.getString(key);
  }

  ///
  Locale? getLocal() {
    String? languageCode = _sp.getString(_kLocale);
    if (languageCode == null || languageCode.isEmpty) {
      return null;
    }
    Locale? locale = Locale(languageCode);
    return locale;
  }

  ///
  Future? setLocal(Locale locale) async {
    return _sp.setString(_kLocale, locale.languageCode);
  }

}
