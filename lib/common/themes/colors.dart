import 'package:flutter/material.dart';

/// FileName colors
///
/// @Author LinGuanYu
/// @Date 2023/3/20 18:07
///
/// @Description TODO

class AppColors {

  /// 主题色
  static const Color primary = Color(primaryInt);
  static const int primaryInt = 0xff4169E1;

  static const MaterialColor primarySwatchColor = MaterialColor(primaryInt, {
    50: Color(primaryInt),
    100: Color(primaryInt),
    200: Color(primaryInt),
    300: Color(primaryInt),
    400: Color(primaryInt),
    500: Color(primaryInt),
    600: Color(primaryInt),
    700: Color(primaryInt),
    800: Color(primaryInt),
    900: Color(primaryInt),
  });

  // static const Color main =  Color(0xfff29a16);

  static const Color indigoAccentColor = Colors.indigoAccent;

  static const Color mainDark = Color(0xff2e3034);
  /// 主背景
  static const Color primaryBackground = Color.fromRGBO(248, 248, 248, 1);

  /// 主文本 灰色
  static const Color primaryText = Color.fromARGB(255, 45, 45, 47);

  /// 主控件-背景 蓝色
  static const Color primaryElement = Color.fromARGB(255, 41, 103, 255);

  /// 主控件-文本 白色
  static const Color primaryElementText = Color.fromARGB(255, 255, 255, 255);

  // *****************************************

  /// 第二种控件-背景色 淡灰色
  static const Color secondaryElement = Color.fromARGB(255, 246, 246, 246);

  /// 第二种控件-文本 浅蓝色
  static const Color secondaryElementText = Color.fromARGB(255, 41, 103, 255);

  // *****************************************

  /// 第三种控件-背景色 石墨色
  static const Color thirdElement = Color.fromARGB(255, 45, 45, 47);

  /// 第三种控件-文本 浅灰色2
  static const Color thirdElementText = Color.fromARGB(255, 141, 141, 142);

  // *****************************************

  /// tabBar 默认颜色 灰色
  static const Color tabBarElement = Color.fromARGB(255, 208, 208, 208);

  /// tabCellSeparator 单元格底部分隔条 颜色
  static const Color tabCellSeparator = Color.fromARGB(255, 230, 230, 231);
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}