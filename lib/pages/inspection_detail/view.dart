import 'package:echo_utils/echo_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_app/common/themes/texts.dart';
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

    return Scaffold(
      appBar: AppBar(
        title:  Text("巡检详情",style: Styles.headLineStyle3.copyWith(fontSize: 22.sp,color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("设备名称",style: Styles.headLineStyle4.copyWith(color: Colors.grey,fontSize: 16.sp),),

                  Text(controller.item.equipmentName,style: Styles.headLineStyle4.copyWith(color: Colors.black,fontSize: 16.sp),),
                ],
              ),
              SizedBox(height: 15.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("设备地址",style: Styles.headLineStyle4.copyWith(color: Colors.grey,fontSize: 16.sp),),
                  Text(controller.item.address,style: Styles.headLineStyle4.copyWith(color: Colors.black,fontSize: 16.sp),),
                ],
              ),
              SizedBox(height: 15.h,),
              Row(
                children: [
                  Text(
                    "检查项目",
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold,color: AppColors.primary),
                  ),
                  Expanded(child: Container()),
                ],
              ),
              SizedBox(height: 15.h,),
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
              ...controller.inspectionTaskFormList,
              SizedBox(height: 15.h,),
              Row(
                children: [
                  Text(
                    "附件",
                    style:
                    TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold,color: AppColors.primary),
                  ),
                  Expanded(child: Container()),
                ],
              ),
              SizedBox(height: 15.h,),
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
                  onPressed: () async{
                    await controller.commit();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
