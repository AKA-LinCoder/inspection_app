import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_app/pages/setting/index.dart';

/// FileName echo_text
///
/// @Author LinGuanYu
/// @Date 2023/3/22 10:08
///
/// @Description TODO

class EchoText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final controller = Get.put(SettingController());
  EchoText({Key? key, required this.text, this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double scaleFacter = controller.states.fontSize.value;
    return Text(
      text,
      style: style?? const TextStyle().copyWith(
        fontSize: 16*scaleFacter
      ),
    );
  }
}
