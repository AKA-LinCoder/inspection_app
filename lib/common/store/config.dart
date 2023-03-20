import 'package:echo_utils/echo_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/storage.dart';
import '../values/values.dart';

/// FileName config
///
/// @Author LinGuanYu
/// @Date 2023/3/20 14:37
///
/// @Description TODO

class ConfigStore extends GetxController {
  static ConfigStore get to => Get.find();

  bool isFirstOpen = false;

  bool get isRelease => const bool.fromEnvironment("dart.vm.product");
  Locale? locale =  Get.deviceLocale;
  List<Locale> languages = const [
    Locale('en', 'US'),
    Locale('zh', 'CN'),
  ];

  @override
  void onInit() {
    super.onInit();
    onInitLocale();
    isFirstOpen = StorageService.to.getBool(STORAGE_DEVICE_FIRST_OPEN_KEY);
  }


  // 标记用户已打开APP
  Future<bool> saveAlreadyOpen() {
    return StorageService.to.setBool(STORAGE_DEVICE_FIRST_OPEN_KEY, false);
  }

  void onInitLocale() {
    var langCode = StorageService.to.getString(STORAGE_LANGUAGE_CODE);
    if (langCode.isEmpty) return;
    var index = languages.indexWhere((element) {
      return element.languageCode == langCode;
    });
    if (index < 0) return;
    locale = languages[index];
  }

  void onLocaleUpdate(Locale value) {
    locale = value;
    Get.updateLocale(value);
    StorageService.to.setString(STORAGE_LANGUAGE_CODE, value.languageCode);
  }
}
