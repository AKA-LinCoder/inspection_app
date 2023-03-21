import 'package:get/get.dart';

import 'index.dart';

/// FileName bindings
///
/// @Author LinGuanYu
/// @Date 2023/3/21 17:12
///
/// @Description TODO

class MyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyController>(() => MyController());
  }
}
