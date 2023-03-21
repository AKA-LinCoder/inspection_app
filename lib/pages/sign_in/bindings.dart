import 'package:get/get.dart';

import 'index.dart';

/// FileName bindings
///
/// @Author LinGuanYu
/// @Date 2023/3/20 18:24
///
/// @Description TODO

class SignInBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(() => SignInController());
    // Get.lazyPut<ApplicationController>(()=>ApplicationController());

  }
}
