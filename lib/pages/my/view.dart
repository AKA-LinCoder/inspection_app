import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_app/common/themes/themes.dart';

import 'index.dart';

/// FileName view
///
/// @Author LinGuanYu
/// @Date 2023/3/21 17:12
///
/// @Description TODO

class MyPage extends GetView<MyController> {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var con = controller;
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("个人中心"),),
      body:Column(
        children: [
            GestureDetector(
              onTap: ()async{
                await controller.handleClearCache();
              },
              child: Row(
                children: [
                  Obx(() => Text("清楚本地缓存${controller.renderSize(controller.states.cacheInt.value)}"))
                ],
              ),
            ),
          GestureDetector(
            onTap: ()async{
              Get.changeTheme(Get.isDarkMode?Themes.lightTheme:Themes.darkTheme);
            },
            child: Row(
              children: const [
                Text("模式切换")
              ],
            ),
          ),
          GestureDetector(
            onTap: ()async{
             Get.updateLocale(const Locale("en","US"));
            },
            child: Row(
              children: const [
                Text("语言切换")
              ],
            ),
          ),
        ],
      )
    );
  }


}
