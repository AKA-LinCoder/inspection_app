import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/routes.dart';
import '../store/store.dart';

/// FileName router_welcome
///
/// @Author LinGuanYu
/// @Date 2023/3/20 18:19
///
/// @Description TODO

/// 路由中间件
class RouteWelcomeMiddleware extends GetMiddleware {
  // priority 数字小优先级高
  @override
  int? priority = 0;

  RouteWelcomeMiddleware({required this.priority});

  //重定向，当正在搜索被调用路由的页面时，将调用该函数
  @override
  RouteSettings? redirect(String? route) {
    if (ConfigStore.to.isFirstOpen == true) {
      return null;
    } else if (UserStore.to.isLogin == true) {
      ///如果token存在就前往首页
      return const RouteSettings(name: AppRoutes.Application);
    } else {
      //如果token不存在就跳转到登陆页面
      return const RouteSettings(name: AppRoutes.SIGN_IN);
    }
  }
}
