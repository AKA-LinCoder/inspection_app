import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inspection_app/common/themes/colors.dart';

/// FileName themes
///
/// @Author LinGuanYu
/// @Date 2023/3/20 13:54
///
/// @Description TODO 主题设置

class Themes {
  ///白天模式
  static final lightTheme = ThemeData.light().copyWith(
    useMaterial3: true,
    // splashColor: Colors.white12,
    appBarTheme:  AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20.sp),

      ///设置appbar的背景颜色
      backgroundColor: Colors.indigoAccent,
      iconTheme: const IconThemeData(color: Colors.white),
    ),

    ///背景色
    scaffoldBackgroundColor: Colors.white,

    ///设置icon的颜色
    iconTheme: const IconThemeData(
      color: Colors.orange,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 0,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey),
    //全局主题色
    colorScheme:
        ColorScheme.fromSwatch(primarySwatch: AppColors.primarySwatchColor),
  );

  ///夜间模式
  static final darkTheme = ThemeData.dark().copyWith(
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20.sp),

      ///设置appbar的背景颜色
      backgroundColor: const Color(0xff121212),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    scaffoldBackgroundColor: ThemeData.dark().scaffoldBackgroundColor,
    iconTheme: const IconThemeData(
      color: Colors.blue,
    ),
    textTheme: ThemeData.dark().textTheme.copyWith(
        //     bodySmall表示较小的文本和元素。它通常用于在空间有限的情况下，例如在小型设备上的弹出窗口或对话框中。
        //     bodyMedium表示中等大小的文本和元素。它通常用于普通大小的文本和按钮等元素的显示。
        // bodyLarge表示较大的文本和元素。它通常用于较大的文本块，例如标题和段落，或用于突出显示特定的UI元素。
        bodySmall: const TextStyle(color: Colors.black),
        bodyLarge: const TextStyle(color: Colors.black),
        bodyMedium: const TextStyle(color: Colors.black)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 0,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: AppColors.primarySwatchColor),
  );
}
