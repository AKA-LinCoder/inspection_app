import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_app/common/themes/texts.dart';

import '../../common/themes/colors.dart';
import 'index.dart';

/// FileName view
///
/// @Author LinGuanYu
/// @Date 2023/3/20 18:03
///
/// @Description TODO 这个页面没有什么东西，主要作用是当作路由中间件判断是否已经登陆，如果已经登陆就跳转到首页，否则跳转到登陆页面

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Text("Welcome",style: Styles.headLineStyle2,),
      ),
    );
  }











}