import 'package:echo_utils/echo_utils.dart';
import 'package:get/get.dart';

import 'index.dart';

/// FileName controller
///
/// @Author LinGuanYu
/// @Date 2023/3/22 08:57
///
/// @Description TODO

class SettingController extends GetxController {
  SettingController();

  /// 响应式成员变量

  final states = SettingState();











  /// 生命周期

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    initCache();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
  }


  initCache()async{
    states.cacheInt.value = await EchoCacheUtil.total();
  }

  handleClearCache() async{
    try{
      if(states.cacheInt.value<=0){
        return;
      }
      await EchoCacheUtil.clear();
      await initCache();
    }catch(e,stack){
      echoLog("",error: e,stackTrace: stack);
    }
  }


  ///格式化文件大小
  renderSize(double value) {
    List<String> unitArr = ['B', 'K', 'M', 'G'];
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }



}