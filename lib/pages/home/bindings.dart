import 'package:get/get.dart';

import 'index.dart';

/// FileName bindings
///
/// @Author LinGuanYu
/// @Date 2023/3/30 20:25
///
/// @Description TODO

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
