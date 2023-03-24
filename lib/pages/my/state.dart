import 'package:get/get.dart';

/// FileName state
///
/// @Author LinGuanYu
/// @Date 2023/3/21 17:12
///
/// @Description TODO

class MyState {

  RxDouble cacheInt = 0.0.obs;

  //记录每次手指滑动时的偏移量
  RxDouble preDy = 0.0.obs;

  //当前展开的高度
  RxDouble expandHeight = 300.0.obs;

  //标题的透明度
  RxDouble slidRate = 0.0.obs;
}
