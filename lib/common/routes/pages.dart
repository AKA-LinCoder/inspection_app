import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pages/application/index.dart';
import '../../pages/my/index.dart';
import '../../pages/setting/index.dart';
import '../../pages/sign_in/index.dart';
import '../../pages/welcome/index.dart';
import '../middlewares/router_welcome.dart';
import 'routes.dart';

/// FileName pages
///
/// @Author LinGuanYu
/// @Date 2023/3/20 18:15
///
/// @Description TODO

class AppPages {
  static const INITIAL = AppRoutes.INITIAL;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [
    //欢迎
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => const WelcomePage(),
      binding: WelcomeBinding(),
      middlewares: [
        ///当这里存在多个中间件时 会根据priority的大小来决定先执行哪一个中间件（说明：优先级越低越先执行）
        ///middlewares的配置，在要跳转的页面进行配置，不是跳转前页面配置
        RouteWelcomeMiddleware(priority: 1),
      ],
    ),
    ///登陆页面
    GetPage(
      name: AppRoutes.SIGN_IN,
      page: () => const SignInPage(),
      binding: SignInBinding(),
    ),
    ///主页
    GetPage(
      name: AppRoutes.Application,
      page: () => const ApplicationPage(),
      binding: ApplicationBinding(),

    ),
    ///个人中心页面
    GetPage(
      name: AppRoutes.My,
      page: () => const MyPage(),
      binding: MyBinding(),
    ),
    ///设置页面
    GetPage(
      name: AppRoutes.Setting,
      page: () => const SettingPage(),
      binding: SettingBinding(),
    ),

  ];



}