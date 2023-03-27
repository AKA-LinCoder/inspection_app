import 'package:echo_utils/echo_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_app/common/utils/string_extension.dart';

import '../../main.dart';
import 'index.dart';

/// FileName controller
///
/// @Author LinGuanYu
/// @Date 2023/3/27 18:50
///
/// @Description TODO

class ChatController extends GetxController {
  ChatController();

  /// 响应式成员变量

  final states = ChatState();
  // 存储导航列表的高度位置瞄点
  List<double> scrollHeightList = [];
  // 教师item高度
  double itemHeight = 60;
  // 导航item高度
  double sessionHeight = 38.5;

  // 最后占满屏幕的高度
  double lastHeight = 0;
  // 最后占满屏幕的位置
  int lastIndex = 0;
  // 标签页高度
  double firstItemHeight = 0;

  List indexWord = ['#','A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
  final ScrollController scrollController = ScrollController();









  /// 生命周期

  @override
  void onInit() {
    scrollController.addListener(() {
      final double offsetY = scrollController.offset;
      for(int i = 0; i < scrollHeightList.length; i ++) {
        if(offsetY < scrollHeightList[i]) {
          states.indexLocation.value = i - 1;
          break;
        }else {
          for (int i = 0; i < indexWord.length; i++) {
            if(indexWord[i] == states.teacherList.last.index) {
              states.indexLocation.value = i;
              break;
            }
          }
        }
      }
    });
    super.onInit();
  }

  @override
  void onReady() {

    createData();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  ///@title createData
  ///@description TODO  创建mockData
  ///@updateTime 2023/3/27 19:23
  ///@author LinGuanYu
  void createData() {
    states.teacherList.addAll([
      TeacherChooseList("A", [
        TeacherChooseModel('阿婆', false, '12'),
      ]),
      TeacherChooseList("B", [
        TeacherChooseModel('爸爸', false, ''),
      ]),
      TeacherChooseList("C", [
        TeacherChooseModel('曹映', false, ''),
        TeacherChooseModel('陈力平', false, ''),
        TeacherChooseModel('陈毅', false, ''),
      ]),
      TeacherChooseList("D", [
        TeacherChooseModel('邓丹文', false, ''),
        TeacherChooseModel('杜晶', false, ''),
      ]),
      TeacherChooseList("E", [
        TeacherChooseModel('易中天', false, ''),
      ]),
      TeacherChooseList("F", [
        TeacherChooseModel('FBI', false, ''),
      ]),
      TeacherChooseList("Z", [
        TeacherChooseModel('赵今麦', false, ''),
      ]),
    ]);
    ///计算距离相关
    List<TeacherChooseList> dataList = states.teacherList;
    double textWidth = '文本文本文本文本文本文本文本文本文本文本'.paintWidthWithTextStyle(
        const TextStyle(
            fontSize: 12
        ));
    double topItemHeight = 0;
    var context = appKey.currentState!.overlay!.context;
    if(textWidth > (MediaQuery.of(context).size.width - 30)) {
      topItemHeight = 33.5;
    }else {
      topItemHeight = 17;
    }
    firstItemHeight = topItemHeight + 52.5;
    double totalHeight = firstItemHeight;
    scrollHeightList.add(totalHeight);
    int wordIndex = 0;
    lastHeight += sessionHeight +
        itemHeight * dataList[dataList.length - 1].teacherItem.length;
    for(int i = 0; i < indexWord.length; i++) {

      for(int j = 1; j < dataList.length; j++) {

        if(dataList[j - 1].index == indexWord[i]) {
          if (j + 1 == (dataList.length)) {
            int dataIndex = j;
            echoLog(MediaQuery.of(context).size.height
                - firstItemHeight
                - MediaQuery.of(context).padding.top
                - 64);
            while (lastHeight < (MediaQuery.of(context).size.height
                - firstItemHeight
                - MediaQuery.of(context).padding.top
                - 64)) {
              if(dataIndex >= 0) {
                lastHeight += sessionHeight +
                    itemHeight * dataList[dataIndex].teacherItem.length;
              }
              dataIndex -= 1;
              if(lastIndex == 0) {
                lastIndex = wordIndex;
              }
            }
          }

          totalHeight += sessionHeight + itemHeight*dataList[j - 1].teacherItem.length;
          break;
          // }
        }

      }
      scrollHeightList.add(totalHeight);
      wordIndex += 1;
    }
  }




}