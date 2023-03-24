import 'package:echo_utils/echo_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_app/common/routes/router_name.dart';
import 'package:inspection_app/common/themes/colors.dart';
import 'package:inspection_app/common/themes/texts.dart';

import '../../common/themes/themes.dart';
import 'index.dart';

/// FileName view
///
/// @Author LinGuanYu
/// @Date 2023/3/22 08:57
///
/// @Description TODO

class SettingPage extends GetView<SettingController> {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("设置"),
        ),
        body: SafeArea(
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  await controller.handleClearCache();
                },
                child: Row(
                  children: [
                    Obx(() => Expanded(
                      child: Text(
                          "清楚本地缓存${controller.renderSize(controller.states.cacheInt.value)}"),
                    ))
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Get.changeTheme(
                      Get.isDarkMode ? Themes.lightTheme : Themes.darkTheme);
                },
                child: Row(
                  children: const [Expanded(child: Text("模式切换"))],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Get.updateLocale(const Locale("en", "US"));
                },
                child: Row(
                  children: const [Expanded(child: Text("语言切换"))],
                ),
              ),
              Obx(() => Row(
                children: [
                  Slider(value: controller.states.fontSize.value,
                      min: 0.8,
                      max: 3,
                      onChanged: (double s){
                    controller.states.fontSize.value = s;
                  })
                ],
              ),),
              Expanded(child: Container()),
              GestureDetector(
                onTap: (){},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 30.h,
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8.r)
                    ),

                    child:  Center(child: Text("登出",style: Styles.headLineStyle3.copyWith(color: Colors.white,),),),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
