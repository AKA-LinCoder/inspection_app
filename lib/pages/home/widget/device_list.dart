import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/routes/router_name.dart';
import '../../../common/themes/texts.dart';
import '../controller.dart';
class DeviceListView extends StatefulWidget {
  const DeviceListView({Key? key}) : super(key: key);

  @override
  State<DeviceListView> createState() => _DeviceListViewState();
}

class _DeviceListViewState extends State<DeviceListView> {

  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("设备列表",style: Styles.headLineStyle3.copyWith(fontSize: 22.sp,color: Colors.white),),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 0.w,
          horizontal: 0.w,
        ),
        child: ListView.builder(
          itemCount:  controller.states.equipmentList.length,
            itemBuilder: (context,index){
          var item = controller.states.equipmentList[index];
          var arguments = Get.arguments;
          return GestureDetector(
            onTap: (){
              Get.toNamed(AppRoutes.InspectionDetail,arguments: arguments);
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
                      const Text("设备id"),
                      SizedBox(width: 5.w,),
                      Text(item.equipmentId.toString()),
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
                      const Text("设备名称"),
                      SizedBox(width: 5.w,),
                      Text(item.equipmentName),
                    ],
                  ),
                  SizedBox(height: 10.h,),
                  Row(
                    children: [
                      const Text("设备类型"),
                      SizedBox(width: 5.w,),
                      Text(item.type),
                    ],
                  ),
                  // SizedBox(height: 10.h,),
                  // Divider(
                  //   color: Colors.grey,
                  //   height: 1.w,
                  // ),

                  SizedBox(height: 10.h,),
                ],
              ),
            ),
          );
        }),

      ),
    );
  }
}
