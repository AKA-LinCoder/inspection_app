import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_app/pages/my/index.dart';

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
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text(
      //     "场地巡检",
      //     style: TextStyle(
      //         color: Colors.white, fontSize: 18.sp),
      //   ),
      //
      // ),
      // endDrawer: const userDrawer(),
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: controller.handlePageChanged,
        children: const [
          Text("data"),
          MyPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled),label: "主页"),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "个人中心"),
        ],
        currentIndex: controller.state.page.value,
        onTap: controller.handleNavBarTap,
      ),

    ));
  }






}
