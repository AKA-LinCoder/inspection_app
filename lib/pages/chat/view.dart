import 'package:echo_utils/echo_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_app/common/routes/routes.dart';
import 'package:inspection_app/common/utils/string_extension.dart';
import 'package:inspection_app/pages/chat/widgets/chat_choose_index.dart';

import '../../common/themes/colors.dart';
import '../../main.dart';
import 'index.dart';

/// FileName view
///
/// @Author LinGuanYu
/// @Date 2023/3/27 18:50
///
/// @Description TODO

class TeacherChooseList {
  String index;
  List<TeacherChooseModel> teacherItem;

  TeacherChooseList(this.index, this.teacherItem);
}

class TeacherChooseModel {
  String name;
  bool isChoose;
  String className;

  TeacherChooseModel(this.name, this.isChoose, this.className);
}


class ChatPage extends GetView<ChatController> {
  ChatPage({Key? key}) : super(key: key);

  // 数据选择的字典
  ///第一个字段表示在哪个大模块下面，第二个表示在这个模块下的哪一个
  Map chooseIndex = {'first': -1, 'second': -1};


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("通讯录"),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.add_circle_outline_outlined))
          ],
        ),
        body: Stack(
          children: [
            ///主题显示区域
            SingleChildScrollView(
              controller: controller.scrollController,
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(top: 5, bottom: 5),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                         Text('文本文本文本文本文本文',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppColors.primary)),
                         Text('文本文本文本文本文本文本文本文本文本文本',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: AppColors.primary,
                            )
                        ),
                      ],
                    ),
                  ),
                  Obx(() => Container(
                    color: AppColors.primary,
                    child: _getListView(context),
                  ))
                ],
              ),
            ),
            ///右边的快速跳转列表
            ChatChooseIndex(
                totalHeight: MediaQuery.of(context).size.height - controller.firstItemHeight - 400,
                chooseIndex: controller.states.indexLocation.value,
                firstItemHeight: controller.firstItemHeight,
                indexBarCallBack: (index) {
                  if (controller.lastIndex == 0) {
                    controller.scrollController.jumpTo(controller.scrollHeightList[index]);
                  }else {
                    if(index >= controller.lastIndex) {
                      controller.scrollController.jumpTo(controller.scrollHeightList[controller.lastIndex - 1]);
                    }else {
                      controller.scrollController.jumpTo(controller.scrollHeightList[index]);
                    }
                  }

                }),
          ],
        )
    );
  }

  ///@title _getListView
  ///@description TODO 联系人列表widget
  ///@param: context
  ///@return: Widget
  ///@updateTime 2023/3/27 19:25
  ///@author LinGuanYu
  Widget _getListView(BuildContext context) {
    return ListView.builder(itemBuilder: _getListItem,
      itemCount: controller.states.teacherList.length,
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,);
  }

  ///@title _getListItem
  ///@description TODO 整体导航列表
  ///@param: context
  ///@param: index
  ///@return: Widget
  ///@updateTime 2023/3/27 19:26
  ///@author LinGuanYu
  Widget _getListItem(BuildContext context, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: controller.sessionHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///每一组最上面的导航
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  color: Colors.grey[300],
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(controller.states.teacherList[index].index ?? '',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black
                      ),),
                  ),
                ),
              ),
            ],
          ),
        ),
        ///这一组下面具体的人的列表
        getTeacherListItem(context, controller.states.teacherList[index],index)
      ],
    );
  }

  ///@title getTeacherListItem
  ///@description TODO 具体每一组下面的所有人
  ///@param: context
  ///@param: teacherList
  ///@param: first
  ///@return: Widget
  ///@updateTime 2023/3/27 19:28
  ///@author LinGuanYu
  Widget getTeacherListItem(BuildContext context,TeacherChooseList teacherList,int first) {

    return ListView.builder(itemBuilder:(context, index) {
      return teacherWidget(context, index, teacherList.teacherItem[index], first);
    },
      itemCount: teacherList.teacherItem.length,
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,);
  }


  ///@title teacherWidget
  ///@description TODO 每一个人的widget
  ///@param: context
  ///@param: index
  ///@param: item
  ///@param: first
  ///@return: Widget
  ///@updateTime 2023/3/27 19:29
  ///@author LinGuanYu
  Widget teacherWidget(BuildContext context, int index, TeacherChooseModel item,int first) {

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Get.toNamed(AppRoutes.ChatDetail);
        item.isChoose = !(item.isChoose ?? false);
        if(chooseIndex['first'] == -1) {

          chooseIndex['first'] = first;
          chooseIndex['second'] = index;
        } else {
          if(chooseIndex['first'] == first
              && chooseIndex['second'] == index) {
            chooseIndex['first'] = -1;
            chooseIndex['second'] = -1;
          }else {
            controller.states.teacherList[chooseIndex['first']].teacherItem[chooseIndex['second']].isChoose = false;
            chooseIndex['first'] = first;
            chooseIndex['second'] = index;
          }
        }
      },
      child: Container(
        width: double.maxFinite,
        height: controller.itemHeight,
        color: (item.isChoose ?? false) ? AppColors.primary : Colors.white,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15,top: 5),
                      child: Text(item.name ?? '',style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.black
                      ),),
                    ),
                  ],
                ),
                if (item.className != '')
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      item.className ?? '',
                      style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color:Colors.black),
                    ),
                  )
              ],
            ),

          ],
        ),
      ),
    );
  }




}