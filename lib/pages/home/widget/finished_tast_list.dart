import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../index.dart';




class FinishedTaskList extends StatefulWidget {
  const FinishedTaskList({Key? key}) : super(key: key);

  @override
  _FinishedTaskListState createState() => _FinishedTaskListState();
}

class _FinishedTaskListState extends State<FinishedTaskList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetX<HomeController>(
      init: controller,
      builder: (controller) => SmartRefresher(
        // enablePullUp: true,
        controller: controller.refreshController2,
        onRefresh: controller.onRefresh2,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(
                vertical: 0.w,
                horizontal: 0.w,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                      (content, index) {
                    var item = controller.states.finishedTaskList[index];
                    return Text(item.taskName);

                  },
                  childCount: controller.states.finishedTaskList.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}