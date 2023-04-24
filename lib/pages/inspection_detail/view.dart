import 'package:echo_utils/echo_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_app/common/widgets/echo_asset_picker.dart';
import 'package:inspection_app/pages/home/index.dart';
import 'package:inspection_app/pages/inspection_detail/widget/form.dart';
import 'package:inspection_app/pages/my/index.dart';

import '../../common/entities/inspection.dart';
import '../../common/themes/colors.dart';
import '../chat/index.dart';
import 'index.dart';

/// FileName view
///
/// @Author LinGuanYu
/// @Date 2023/3/21 17:12
///
/// @Description TODO

class InspectionDetailPage extends GetView<InspectionDetailController> {
  const InspectionDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InspectionTask item = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text("巡检详情"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Text("设备名称"),
                SizedBox(
                  width: 5.w,
                ),
                Text(item.equipmentName),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Text("设备地址"),
                SizedBox(
                  width: 5.w,
                ),
                Text(item.address),
              ],
            ),
            Row(
              children: [
                Text(
                  "检查项目",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                Expanded(child: Container()),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.r, right: 8.r, left: 8.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Table(
                    border: const TableBorder(
                      top: BorderSide(
                          color: Color(0xFF000000),
                          width: 1,
                          style: BorderStyle.solid),
                      // horizontalInside: BorderSide(width: 1, color: Colors.grey),
                      bottom: BorderSide.none,
                      left: BorderSide(
                          color: Color(0xFF000000),
                          width: 1,
                          style: BorderStyle.solid),
                      right: BorderSide(
                          color: Color(0xFF000000),
                          width: 1,
                          style: BorderStyle.solid),
                      verticalInside: BorderSide(
                          color: Color(0xFF000000),
                          width: 1,
                          style: BorderStyle.solid),
                    ),
                    // border: TableBorder.all(), // 设置表格边框
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                                height: 50,
                                alignment: Alignment.center,
                                child: Text('巡检点')),
                          ),
                          TableCell(
                            child: Container(
                                height: 50,
                                alignment: Alignment.center,
                                child: Text('信息')),
                          ),
                          TableCell(
                            child: Container(
                                height: 50,
                                alignment: Alignment.center,
                                child: Text('结论')),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ...item.content
                .map((e) => InspectionTaskForm(
                      content: e,
                    ))
                .toList(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: EchoAssetPicker(
                maxAssets: 9,
                bgColor: Colors.transparent,
                oldAssets: controller.assets,
                callBack: (assetList) {
                  controller.assets = assetList;
                },
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            EchoButton(
                height: 40.h,
                buttonName: "完成",
                buttonColor: AppColors.primary,
                buttonTextStyle: TextStyle(
                  fontSize: 16.sp
                ),
                onPressed: () {})
          ],
        ),
      ),
    );
  }
}
