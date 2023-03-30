/// FileName chat_detail_view
///
/// @Author LinGuanYu
/// @Date 2023/3/27 20:08
///
/// @Description TODO 详细的聊天页面
import 'package:echo_utils/echo_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:inspection_app/common/model/chat.dart';
import 'package:inspection_app/common/themes/texts.dart';
import 'package:inspection_app/pages/chat/widgets/chat_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/themes/colors.dart';
import '../index.dart';
import 'chat_bottom.dart';

class ChatDetailView extends StatefulWidget {
  const ChatDetailView({Key? key}) : super(key: key);

  @override
  State<ChatDetailView> createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends State<ChatDetailView> {
  final controller = Get.find<ChatController>();
  late FocusNode focusNode;
  late String name;

  @override
  void initState() {
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    name = Get.arguments ?? "";
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        controller.states.contentShow.value = true;
      }
    });
  }

  bool isTyping = false;
  late TextEditingController textEditingController;

  int _pageIndex = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textEditingController.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      resizeToAvoidBottomInset: false, //防止遮住视图
      appBar: AppBar(
        centerTitle: true,
        title: Text(name),
        actions: [
          IconButton(
              onPressed: () async {
                try {
                  if (await canLaunchUrl(
                      Uri(scheme: "tel", path: "13586420519"))) {
                    ///拨打电话
                    await launchUrl(Uri(scheme: "tel", path: "1398542445"));
                  } else {
                    ///iOS模拟器不能打电话
                    echoLog("不能拨打电话");
                  }
                } catch (e, stack) {
                  echoLog("", error: e, stackTrace: stack);
                }
              },
              icon: const Icon(Icons.local_phone_rounded)),
          IconButton(
              onPressed: () async {},
              icon: const Icon(Icons.view_headline_outlined))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Obx(() => Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.states.chatList.length,
                    controller: controller.chatListScrollController,
                    itemBuilder: (context, index) {
                      return ChatWidget(
                        msg: controller.states.chatList[index]
                            .msg,
                        chatIndex: controller.states.chatList[index]
                            .chatIndex,
                        shouldAnimate: true,
                        me: controller.states.chatList[index]
                            .chatIndex %
                            2 ==
                            0
                            ? true
                            : false,
                        allChats: controller.states.chatList.length,
                      );
                    }))),
            // Obx(() => Flexible(
            //   fit: FlexFit.tight,
            //     child: ListView.builder(
            //         reverse: true,
            //         shrinkWrap: true,
            //         itemCount: controller.states.chatList.length,
            //         controller: controller.chatListScrollController,
            //         itemBuilder: (context, index) {
            //           return ChatWidget(
            //             msg: controller.states.chatList.reversed
            //                 .toList()[index]
            //                 .msg,
            //             chatIndex: controller.states.chatList.reversed
            //                 .toList()[index]
            //                 .chatIndex,
            //             shouldAnimate: true,
            //             me: controller.states.chatList.reversed
            //                             .toList()[index]
            //                             .chatIndex %
            //                         2 ==
            //                     0
            //                 ? true
            //                 : false,
            //             allChats: controller.states.chatList.length,
            //           );
            //         }))),
            if (isTyping) ...[
              SpinKitThreeBounce(
                color: AppColors.primary,
                size: 18.sp,
              )
            ],
            // Expanded(child: Container()),
            ///底部输入框
            Column(
              children: [
                SizedBox(
                  ///要想实现类似微信的输入框随文本高度变化而变化就不能设置高度，并且maxLines 设为null
                  // height: 50.w,
                  child: Material(
                    color: Colors.grey[200],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(() => Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    if (controller.states.textModel.value) {
                                      controller.states.contentShow.value =
                                          false;
                                    }
                                    controller.states.textModel.value =
                                        !controller.states.textModel.value;
                                  },
                                  icon: Obx(() => Icon(
                                        !controller.states.textModel.value
                                            ? Icons.keyboard_alt_outlined
                                            : Icons.settings_voice_outlined,
                                        color: AppColors.primary,
                                      ))),
                              controller.states.textModel.value
                                  ? Expanded(
                                      child: TextField(
                                          controller: textEditingController,
                                          focusNode: focusNode,
                                          cursorColor: AppColors.primary, //光标颜色
                                          maxLines: null,
                                          onSubmitted: (msg) {
                                            sendMsg();
                                          },
                                          style: TextStyle(fontSize: 16.sp),

                                          // decoration:  InputDecoration.collapsed(
                                          //   // filled: true,
                                          //   // fillColor: Colors.white,
                                          //     hintText: "输入你想说的话",hintStyle: TextStyle(
                                          //   fontSize: 16.sp,color: Colors.black,
                                          // )),
                                          decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              horizontal: 16.r,
                                              vertical: 20.r,
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 0,
                                                        color: Colors
                                                            .transparent)),
                                            disabledBorder:
                                                const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 0,
                                                        color: Colors
                                                            .transparent)),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 0,
                                                        color: Colors
                                                            .transparent)),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(7.r),
                                              //borderSide: BorderSide(width: 0, color: Colors.transparent),
                                              // borderSide: BorderSide(width: 0, color: Colors.transparent),
                                            ),
                                          )),
                                    )
                                  : Expanded(
                                      child: Center(
                                          child: Text(
                                      "按住说话",
                                      style: TextStyle(
                                          fontSize: 16.sp, color: Colors.black),
                                    ))),
                              InkWell(
                                onTap: () {
                                  sendMsg();
                                },
                                child: const Icon(
                                  Icons.send,
                                  color: AppColors.primary,
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              InkWell(
                                onTap: () {},
                                child: const Icon(
                                  Icons.add_circle_outline,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
                //             Obx(() => controller.states.contentShow.value?
                // ChatBottom(pageCount: 8, items: controller.chatBottomModel, pageIndex: _pageIndex,):Container())
              ],
            )
          ],
        ),
      ),
    );
  }

  ///@title sendMsg
  ///@description TODO  发送信息
  ///@updateTime 2023/3/29 18:58
  ///@author LinGuanYu
  sendMsg() async {
    if (isTyping) {
      Get.snackbar("请等待别人回复", "",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    if (textEditingController.text.isEmpty) {
      return;
    }
    //增加聊天内容
    try {
      String msg = textEditingController.text;
      setState(() {
        isTyping = true;
        controller.states.chatList.add(
            ChatModel(msg: msg, chatIndex: controller.states.chatList.length));
        // chatProvider.addUserMessage(msg: msg);
        textEditingController.clear();
        focusNode.unfocus();
      });
      // await chatProvider.sendMessageAndGetAnswers(
      //     msg: msg, chosenModelId: modelsProvider.getCurrentModel);
      // chatList.addAll(await ApiService.sendMessage(
      //   message: textEditingController.text,
      //   modelId: modelsProvider.getCurrentModel,
      // ));
      setState(() {});
      // controller.scrollListToEND();
      // isTyping = false;
    } catch (error) {
      echoLog("error $error", error: error);
      Get.snackbar(error.toString(), "",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      setState(() {
        controller.scrollListToEND();
        isTyping = false;
      });
    }
  }

  /// 用户头像
  Widget userAvatar({String? img, double? size}) {
    return Padding(
      padding: EdgeInsets.all(10.r),
      child: CircleAvatar(
        radius: (size ?? 2) / 2,
        backgroundImage: AssetImage(img ?? "assets/user/user1.png"),
      ),
    );
  }
}
