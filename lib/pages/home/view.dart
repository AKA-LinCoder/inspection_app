import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_app/common/themes/colors.dart';
import 'package:inspection_app/common/widgets/app.dart';
import 'package:inspection_app/pages/home/widget/finished_tast_list.dart';
import 'package:inspection_app/pages/home/widget/un_finished_task_list.dart';

import '../../common/themes/texts.dart';
import 'index.dart';

/// FileName view
///
/// @Author LinGuanYu
/// @Date 2023/3/30 20:25
///
/// @Description TODO

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      // 标签数量
        length: 2,
        child:Scaffold(
          backgroundColor: Colors.grey[200],
            appBar: AppBar(
                backgroundColor: Colors.white,
                title:Row(
                  children:  <Widget>[
                    // 弹性容器布局
                    Expanded(
                        child:TabBar(
                          // 多个标签时滚动加载
                          isScrollable:true,
                          // 标签指示器的颜色
                          indicatorColor: Colors.transparent,
                          // 标签的颜色
                          labelColor: AppColors.primary,
                          labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 21.sp,color: AppColors.primary),
                          // 未选中标签的颜色
                          unselectedLabelColor: Colors.grey,
                          unselectedLabelStyle: TextStyle(fontSize: 15.sp),
                          // 指示器的大小
                          indicatorSize: TabBarIndicatorSize.label,
                          // 指示器的权重，即线条高度
                          indicatorWeight: 4.0,

                          tabs: const <Widget>[
                            Tab(text:"进行中"),
                            Tab(text:"已完成"),
                          ],
                        )
                    )
                  ],
                )
            ),
            // 标签页所对应的页面
            body: TabBarView(
              children: <Widget>[
                controller.LinObx((state) => const UnFinishedTaskList(),tryAgain: controller.getUnFinishedTaskList),
                controller.LinObx((state) => const FinishedTaskList(),tryAgain: controller.getFinishedTaskList)
              ],
            )
        )
    );
  }











}