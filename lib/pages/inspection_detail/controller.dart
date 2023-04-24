import 'package:echo_utils/echo_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'index.dart';

/// FileName controller
///
/// @Author LinGuanYu
/// @Date 2023/3/21 17:12
///
/// @Description TODO

class InspectionDetailController extends GetxController {
  InspectionDetailController();

  /// 响应式成员变量

  final state = InspectionDetailState();


  // 页控制器
  late final PageController pageController;


  List<AssetEntity> assets = [];

  /// 事件

  // tab栏动画
  void handleNavBarTap(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  // tab栏页码切换
  void handlePageChanged(int page) {
    state.page.value = page;
  }



  /// 生命周期

  @override
  void onInit() {

    super.onInit();
    pageController = PageController(initialPage: state.page.value);
  }

  @override
  void onReady() {

    super.onReady();


  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }



}