import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_app/pages/home/index.dart';
import 'package:inspection_app/pages/my/index.dart';

import '../chat/index.dart';
import 'index.dart';

/// FileName view
///
/// @Author LinGuanYu
/// @Date 2023/3/21 17:12
///
/// @Description TODO

class ApplicationPage extends GetView<ApplicationController> {
  const ApplicationPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Obx(() =>  Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: controller.handlePageChanged,
        children:  [
          const HomePage(),
          ChatPage(),
          const MyPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled),label: "主页"),
          BottomNavigationBarItem(icon: Icon(Icons.chat_outlined),label: "通讯录"),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "个人中心"),
        ],
        currentIndex: controller.state.page.value,
        onTap: controller.handleNavBarTap,
      ),

    ));
  }






}
