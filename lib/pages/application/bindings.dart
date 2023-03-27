import 'package:get/get.dart';
import 'package:inspection_app/pages/my/index.dart';

import '../chat/index.dart';
import 'index.dart';

/// FileName bindings
///
/// @Author LinGuanYu
/// @Date 2023/3/21 17:12
///
/// @Description TODO


class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplicationController>(()=>ApplicationController());
    Get.lazyPut<MyController>(()=>MyController());
    Get.lazyPut<ChatController>(() => ChatController());

  }
}