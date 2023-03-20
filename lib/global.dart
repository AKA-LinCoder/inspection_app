import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'common/services/services.dart';
import 'common/store/store.dart';

/// FileName global
///
/// @Author LinGuanYu
/// @Date 2023/3/20 14:30
///
/// @Description TODO 配置全局静态数据

class Global {
  /// 初始化
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    //设置只支持竖屏
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp
    ]);
    await Get.putAsync<StorageService>(() => StorageService().init());
    Get.put<UserStore>(UserStore());
    Get.put<ConfigStore>(ConfigStore());
  }
}