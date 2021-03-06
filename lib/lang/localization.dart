import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_app/lang/en_us.dart';
import 'package:pos_app/lang/vi_vn.dart';

class LocalizationService extends Translations {
  GetStorage box = GetStorage();
   get locale => box.hasData('_language_code') ? Locale(box.read('_language_code'), box.read('_country_code') ) : Locale('vi', 'VN');
  static final fallbackLocale = Locale('en', 'US');
  static final langs = [
    'English',
    'Tiếng Việt',
  ];
  static final locales = [
    Locale('en', 'US'),
    Locale('vi', 'VN'),
  ];
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'vi_VN': viVN,
      };
  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale!);
  }

  Locale? _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale;
  }
}
