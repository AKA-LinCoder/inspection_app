import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/themes/texts.dart';
import 'index.dart';

/// FileName view
///
/// @Author LinGuanYu
/// @Date 2023/3/30 20:25
///
/// @Description TODO

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Text("Home",style: Styles.headLineStyle2,),
      ),
    );
  }











}