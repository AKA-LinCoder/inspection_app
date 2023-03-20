import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_app/common/languages/zh_Hans.dart';

import 'en_US.dart';

/// FileName languages
///
/// @Author LinGuanYu
/// @Date 2023/3/20 14:08
///
/// @Description TODO

class TranslationService extends Translations{

  static Locale? get locale => Get.deviceLocale;
  static const fallbackLocale =  Locale('zh', 'CN');

  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'en_US': en_US,
    'zh_Hans': zh_Hans,
    // 'zh_HK': zh_HK,
  };

}