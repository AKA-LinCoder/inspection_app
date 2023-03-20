import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    splashColor: Colors.white12,
    appBarTheme:  const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      elevation: 0,
      titleTextStyle: TextStyle(color: Colors.white,fontSize: 20),
      ///设置appbar的背景颜色
      backgroundColor: Colors.indigoAccent,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    ///背景色
    scaffoldBackgroundColor: Colors.white,
    ///设置icon的颜色
    iconTheme: const IconThemeData(
      color: Colors.orange,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.tealAccent
    ),
    //全局主题色
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red,).copyWith(background: Colors.orange),
  );

  ///夜间模式
  static final darkTheme = ThemeData.dark().copyWith(
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      elevation: 0,
      backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    scaffoldBackgroundColor: ThemeData.dark().scaffoldBackgroundColor,
    backgroundColor: Colors.black,
    iconTheme: const IconThemeData(
      color: Colors.blue,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.tealAccent,
        unselectedItemColor: Colors.blue
    ),
  );
}