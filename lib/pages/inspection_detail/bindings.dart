import 'package:get/get.dart';
import 'package:inspection_app/pages/my/index.dart';

import '../chat/index.dart';
import '../home/index.dart';
import 'index.dart';

/// FileName bindings
///
/// @Author LinGuanYu
/// @Date 2023/3/21 17:12
///
/// @Description TODO


class InspectionDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InspectionDetailController>(()=>InspectionDetailController());
  }
}