
import 'package:count_down/generated/l10n.dart';
import 'package:count_down/utils/sp_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
class LocaleUtils {
  factory LocaleUtils() => _instance;

  static final LocaleUtils _instance = LocaleUtils._internal();

  List<Locale> get supportedLocales => S.delegate.supportedLocales;

  Locale? _locale;

  Locale? get locale => _locale;

  LocaleUtils._internal() {
    _locale = SPUtils.instance.getLocal() ?? Get.deviceLocale;
  }

  ///
  void _saveLocale(locale) async {
    _locale = locale;
    await SPUtils.instance.setLocal(locale);
  }

  ///
  void updateLocale(locale) {
    _saveLocale(locale);
    Get.updateLocale(locale);
    Future.delayed(
      const Duration(milliseconds: 100),
          () => Get.updateLocale(locale),
    );
  }

  ///
  Locale? localeResolutionCallback(
      Locale? locale,
      Iterable<Locale> supportedLocales,
      ) {
    for (Locale supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale?.languageCode) {
        if (_locale != supportedLocale) {
          _saveLocale(supportedLocale);
        }
        return supportedLocale;
      }
    }
    return null;
  }

}
