import 'package:get/get.dart';

import 'index.dart';

/// FileName bindings
///
/// @Author LinGuanYu
/// @Date 2023/3/22 08:58
///
/// @Description TODO

class SettingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingController>(() => SettingController());
  }
}
