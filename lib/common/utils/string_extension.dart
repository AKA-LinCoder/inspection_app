
import 'package:flutter/cupertino.dart';

extension StringExtension on String {
  ///修复dart的字符串bug
  ///如果字符串是汉字加一长串数字, 后面的一长串数字默认是一个整体
  ///这个扩展方法解决了这个问题
  String get notBreak => replaceAll('', '\u{200B}');

  /// 根据字符串获取宽度
  double paintWidthWithTextStyle(TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: this, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size.width;
  }
}