import 'package:get/get.dart';

import 'index.dart';

/// FileName bindings
///
/// @Author LinGuanYu
/// @Date 2023/3/20 18:03
///
/// @Description TODO

class WelcomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WelcomeController>(() => WelcomeController());
  }
}
