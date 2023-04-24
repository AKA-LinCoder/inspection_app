import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../themes/colors.dart';
import 'dialog.dart';
// import '../values/colors.dart';
// import 'dialog.dart';

/// 透明背景 AppBar
AppBar transparentAppBar({
  Widget? title,
  Widget? leading,
  List<Widget>? actions,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: title != null
        ? Center(
            child: title,
          )
        : null,
    leading: leading,
    actions: actions,
  );
}

//
// @description app首页展示处的appbar
// @author LinGy
// @date 2022/5/15 15:18
//
AppBar normalAppBar(
    {required String title,
    Widget? leading,
    List<Widget>? actions,
    bool? centerTitle = false}) {
  return AppBar(
    centerTitle: centerTitle,
    backgroundColor: Colors.white,
    title: Text(
      title,
      style: TextStyle(
          color: Colors.black, fontSize: 21.sp, fontWeight: FontWeight.bold),
    ),
    leading: leading,
    actions: actions,
  );
}

//
// @description
// @author LinGy
// @date 2022/5/16 14:26
//
// AppBar withBackAppBar(
//     {required String title,
//       Widget? leading,
//       List<Widget>? actions,
//       bool? centerTitle = true}) {
//   return AppBar(
//     centerTitle: centerTitle,
//     backgroundColor:  const Color(0xff2e3034),
//     title: Text(
//       title,
//       style: TextStyle(
//           color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.bold),
//     ),
//     leading: leading??IconButton(
//         onPressed: () {
//           Get.back();
//         },
//         icon: Image(
//           image: const AssetImage('images/assets/back.png'),
//           width: 30.w,
//           height: 30.w,
//         )),
//     actions: actions,
//   );
// }



/// 10像素 Divider
Widget divider10Px({Color bgColor = AppColors.secondaryElement}) {
  return Container(
    height: 10.w,
    decoration: BoxDecoration(
      color: bgColor,
    ),
  );
}

extension StateExt<T> on StateMixin<T> {
  Widget LinObx(
    NotifierBuilder<T?> widget, {
    void Function()? tryAgain,
    Widget Function(String? error)? onError,
    Widget? onLoading,
    Widget? onEmpty,
  }) {
    return SimpleBuilder(builder: (_) {
      if (status.isLoading) {
        return onLoading ?? const Center(child:
        ProgressDialog(isShow: true,
          title: '加载中',
          textColor: AppColors.primary,
          itemColor: Colors.white,
        ));
      } else if (status.isError) {
        return onError != null
            ? onError(status.errorMessage)
            : Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Text(
                      '页面加载出错: ${status.errorMessage}',
                      style: TextStyle(fontSize: 18.sp,color: Colors.redAccent),
                    )),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 150.r),
                      child: GestureDetector(
                        onTap: tryAgain,
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          padding: EdgeInsets.all(10.r),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primary),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                            child: Text(
                              '重新加载',
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
      } else if (status.isEmpty) {
        return onEmpty ??
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Text(
                    '暂无数据',
                    style: TextStyle(fontSize: 18.sp),
                  )),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 150.r),
                    child: GestureDetector(
                      onTap: tryAgain,
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        padding: EdgeInsets.all(10.r),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primary),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: Text(
                            '重新加载',
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ); // Also can be widget(null); but is risky
      }
      return widget(value);
    });
  }
}
