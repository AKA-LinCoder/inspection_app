import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_app/common/routes/router_name.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../index.dart';




class UnFinishedTaskList extends StatefulWidget {
  const UnFinishedTaskList({Key? key}) : super(key: key);

  @override
  _UnFinishedTaskListState createState() => _UnFinishedTaskListState();
}

class _UnFinishedTaskListState extends State<UnFinishedTaskList>
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
        controller: controller.refreshController,
        onRefresh: controller.onRefresh,
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
                    var item = controller.states.unFinishedTaskList[index];
                    late DateTime dateTime;
                    if (item.endTime.toString().length == 13) {
                      dateTime = DateTime.fromMillisecondsSinceEpoch(item.endTime);
                    } else if (item.endTime.toString().length == 16) {
                      ///如果是十六位时间戳
                      dateTime = DateTime.fromMicrosecondsSinceEpoch(item.endTime);
                    }
                    String formattedDate = '${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}';

                    return GestureDetector(
                      onTap: ()async{
                        await controller.getEquipmentList();
                        Get.toNamed(AppRoutes.DeviceListView,arguments: item);
                      },
                      child: Container(
                        // margin: ,
                        margin: EdgeInsets.all(8.r),
                        padding: EdgeInsets.all(8.r),
                        decoration:  BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0), // 设置圆角大小
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5), // 设置阴影颜色
                              spreadRadius: 5, // 阴影扩散程度
                              blurRadius: 7, // 阴影模糊程度
                              offset: Offset(0, 3), // 阴影位置偏移
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 10.h,),
                            Row(
                              children: [
                                Text("任务编号"),
                                Text(item.taskId.toString()),
                              ],
                            ),
                            SizedBox(height: 5.h,),
                            Divider(
                              color: Colors.grey,
                              height: 1.w,
                            ),
                            SizedBox(height: 10.h,),
                            Row(
                              children: [
                                Text("任务内容"),
                                SizedBox(width: 5.w,),
                                Text(item.taskName),
                              ],
                            ),
                            SizedBox(height: 10.h,),
                            Row(
                              children: [
                                Text("发布人"),
                                SizedBox(width: 5.w,),
                                Text(item.publishName),
                              ],
                            ),
                            SizedBox(height: 10.h,),
                            Divider(
                              color: Colors.grey,
                              height: 1.w,
                            ),
                            SizedBox(height: 10.h,),
                            Row(
                              children: [
                                Text("截至日期"),
                                SizedBox(width: 5.w,),
                                Text(formattedDate ),
                              ],
                            ),
                            SizedBox(height: 10.h,),
                          ],
                        ),
                      ),
                    );
                    return Text(item.taskName);

                  },
                  childCount: controller.states.unFinishedTaskList.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}