import 'package:echo_utils/echo_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_app/common/routes/routes.dart';
import 'package:inspection_app/common/themes/colors.dart';
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
    return Scaffold(
      body: Listener(
        ///手指移动的回调
        onPointerMove: controller.moveListener,

        ///手指抬起是的回调
        onPointerUp: controller.upListener,
        child: buildNestedScrollView(),
      ),
    );
    return buildNestedScrollView();
  }

  Widget buildNestedScrollView() {
    return NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            Obx(() => SliverAppBar(
              title: buildHeader(),
              centerTitle: true,

              ///当此值为true时 SliverAppBar 会固定在页面顶部
              ///当此值为false时 SliverAppBar 会随着滑动向上滑动
              pinned: true,

              ///当值为true时 SliverAppBar设置的title会随着上滑动隐藏
              ///然后配置的bottom会显示在原AppBar的位置
              ///当值为false时 SliverAppBar设置的title会不会隐藏
              ///然后配置的bottom会显示在原AppBar设置的title下面
              floating: false,

              ///当snap配置为true时，向下滑动页面，SliverAppBar（以及其中配置的flexibleSpace内容）会立即显示出来，
              ///反之当snap配置为false时，向下滑动时，只有当ListView的数据滑动到顶部时，SliverAppBar才会下拉显示出来。
              snap: false,

              ///展开的高度
              expandedHeight: controller.states.expandHeight.value,
              bottom: buildFlexibleTooBarWidget(context),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: AppColors.primary,
                  child: Stack(
                    children: [
                      Positioned(
                          left: 0, right: 0, bottom: 0, top: 0,
                          child: Image.asset("assets/bg.jpg",fit: BoxFit.fill,))
                    ],
                  ),
                ),
              ),
            ))
          ];
        },
        // body: ListView.builder(
        //     itemCount: 20,
        //     padding: EdgeInsets.zero,
        //     itemBuilder: (context, index) {
        //       return Container(
        //           height: 80,
        //           alignment: Alignment.center,
        //           color: Colors.primaries[index % Colors.primaries.length],
        //           child: Text(index.toString()));
        //     }));
        body: TabBarView(
          controller: controller.tabController,
          children:  [
            Container(
              color: Colors.orangeAccent,
            ),
            Container(
              color: Colors.redAccent,
            ),
            Container(
              color: Colors.deepPurpleAccent,
            ),
          ],
        ));
  }

  PreferredSize buildFlexibleTooBarWidget(BuildContext context) {
    ///[PreferredSize]用于配置在AppBar或者是SliverAppBar
    ///的bottom中 实现 PreferredSizeWidget
    return PreferredSize(
      ///定义大小
      preferredSize: Size(MediaQuery.of(context).size.width, 48),
      ///配置任意的子Widget
      child: Container(
        color: AppColors.primary,
        alignment: Alignment.center,
        child: TabBar(
          controller: controller.tabController,
          unselectedLabelColor: Colors.white,
          labelColor: Colors.greenAccent,
          // indicator: const UnderlineTabIndicator(
          //     borderSide: BorderSide(width: 2.0, color: Colors.blue),
          //     insets: EdgeInsets.symmetric(horizontal:16.0, vertical: 4.0)
          // ),
          indicator: const BoxDecoration(),
          tabs: const [
             Tab(text: "我的订单",),
             Tab(text: "待办事项",),
             Tab(text: "历史巡检",),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: controller.states.slidRate.value,
            child: const Text("个人中心"),
          ),
          Positioned(
              right: 1.w,
              child: InkWell(
                onTap: () async {
                  Get.toNamed(AppRoutes.Setting);
                },
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                      color: Colors.white30,
                      borderRadius: BorderRadius.all(Radius.circular(18))),
                  child: Icon(
                    Icons.settings_outlined,
                    size: 20.w,
                    color: AppColors.primary,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
