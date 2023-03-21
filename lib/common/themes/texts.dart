import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inspection_app/common/themes/colors.dart';

/// FileName texts
///
/// @Author LinGuanYu
/// @Date 2023/3/20 18:07
///
/// @Description TODO

class Styles{
  static Color primaryColor = AppColors.primary;
  static Color textColor = const Color(0xFF3b3b3b);
  static Color bgColor = const Color(0xFFeeedf2);
  static Color orangeColor = const Color(0xFFF37B67);
  static Color kakiColor = const Color(0xFFd2bdb6);
  static TextStyle textStyle = TextStyle(fontSize: 16,color: textColor,fontWeight: FontWeight.w500);

  static TextStyle headLineStyle = TextStyle(fontSize: 26.sp,color: textColor,fontWeight: FontWeight.bold);

  static TextStyle headLineStyle2 = TextStyle(fontSize: 21.sp,color: textColor,fontWeight: FontWeight.bold);

  static TextStyle headLineStyle3 = TextStyle(fontSize: 17.sp,color: Colors.grey.shade500,fontWeight: FontWeight.w500);

  static TextStyle headLineStyle4 = TextStyle(fontSize: 14.sp,color: Colors.grey.shade500,fontWeight: FontWeight.w500);


}