import 'package:echo_utils/echo_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

/// FileName controller
///
/// @Author LinGuanYu
/// @Date 2023/3/21 17:12
///
/// @Description TODO



class MyController extends GetxController with  GetTickerProviderStateMixin {




  MyController();

  /// 响应式成员变量

  final states = MyState();




  //默认展开的高度
  double defaultExpandHeight = 300;

  //展开的最大高度
  double expandMaxHeight = 420;
  //临时记录下拉的展开距离
  double expandScrollHeight = 0;


  
  late AnimationController animationController;
  late TabController tabController;

  
  

  ///@title moveListener
  ///@description TODO 手指移动的回调
  ///@param: event
  ///@updateTime 2023/3/24 14:48
  ///@author LinGuanYu
  void moveListener(PointerMoveEvent event){
    //获取在竖直方向上的偏移
    double dy = event.position.dy;
    //记录手指按下的距离
    if(states.preDy.value==0){
      states.preDy.value = dy;
    }
    states.expandHeight.value += dy - states.preDy.value;

    //如果向下滑动的距离大与最大可滑动的距离
    if(states.expandHeight.value>expandMaxHeight){
      states.expandHeight.value = expandMaxHeight;
    }else if(states.expandHeight<=0){
      states.expandHeight.value = 0;
    }

    ///计算标题的透明度
    if(states.expandHeight>0&&states.expandHeight<defaultExpandHeight){
      states.slidRate.value = 1-states.expandHeight/defaultExpandHeight;
      if(states.slidRate.value<=0){
        states.slidRate.value = 0;
      }else if(states.slidRate.value>1){
        states.slidRate.value = 1;
      }
    }

    ///更新标识
    states.preDy.value = dy;
  }

  ///@title upListener
  ///@description TODO 手指抬起事件的回调：用于判断是否触发自动向上回弹效果
  ///@param: event
  ///@updateTime 2023/3/24 14:59
  ///@author LinGuanYu
  void upListener(PointerUpEvent event){
    states.preDy.value = 0;
    //手指抬起时，如果当前滑动的距离大于默认展开的高度，就开启动画，回到默认的高度
    if(states.expandHeight>expandMaxHeight){
      expandScrollHeight = states.expandHeight.value-defaultExpandHeight;
      //重置并开启动画
      animationController.reset();
      animationController.forward();
    }


  }









  /// 生命周期

  @override
  void onInit() {
    animationController = AnimationController(vsync: this,duration: const Duration(milliseconds: 200));
    tabController =  TabController(length: 3, vsync: this);
    super.onInit();
  }

  @override
  void onReady() {
    initCache();

    animationController.addListener(() {
      states.expandHeight.value = defaultExpandHeight + (1-animationController.value) * expandScrollHeight;
    });
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    animationController.dispose();
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