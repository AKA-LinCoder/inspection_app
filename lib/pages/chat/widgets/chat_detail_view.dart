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
    name = Get.arguments??"";
    super.initState();
    focusNode.addListener(() {
      echoLog("是否聚焦${focusNode.hasFocus}");
      controller.states.hasFocus.value = focusNode.hasFocus;
    });

  }

  bool isTyping = false;
  late TextEditingController textEditingController ;






  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textEditingController.dispose();
    focusNode.dispose();
  }


  @override
  Widget build(BuildContext context) {
    echoLog("是否聚焦${focusNode.hasFocus}");
    return  Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        title: Text(name),
        actions: [
          IconButton(onPressed: ()async{
            try{
              if(await canLaunchUrl(Uri(scheme: "tel",path: "13586420519"))){
                ///拨打电话
                 await launchUrl(Uri(scheme: "tel",path: "1398542445"));
              }else{
                ///iOS模拟器不能打电话
                echoLog("不能拨打电话");
              }
            }catch(e,stack){
              echoLog("",error: e,stackTrace: stack);
            }
          }, icon: const Icon(Icons.local_phone_rounded)),
          IconButton(onPressed: ()async{
          }, icon: const Icon(Icons.view_headline_outlined))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Obx(() => Flexible(child: ListView.builder(
                itemCount: controller.states.chatList.length,
                controller: controller.chatListScrollController,
                itemBuilder: (context,index){
                  return ChatWidget(msg: controller.states.chatList[index].msg, chatIndex: controller.states.chatList[index].chatIndex,shouldAnimate: true, me: index%2==0?true:false,allChats: controller.states.chatList.length,);
                }))),
            if(isTyping)...[
              SpinKitThreeBounce(color: AppColors.primary,size: 18.sp,)
            ],
            SizedBox(
              height: 50,
              child: Material(
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      IconButton(onPressed: (){}, icon: Obx(() => Icon(!controller.states.hasFocus.value?Icons.keyboard_alt_outlined:Icons.settings_voice_outlined,color: AppColors.primary,))),
                      Expanded(
                        child: TextField(
                          controller: textEditingController,
                          focusNode: focusNode,
                          onSubmitted: (msg){
                            sendMsg();
                          },
                          style: TextStyle(
                              fontSize: 16.sp
                          ),
                          decoration:  InputDecoration.collapsed(
                              // filled: true,
                              // fillColor: Colors.white,
                              hintText: "输入你想说的话",hintStyle: TextStyle(
                              fontSize: 16.sp,color: Colors.black,
                          )),
                        ),
                      ),
                      IconButton(onPressed: (){
                        sendMsg();
                      }, icon: const Icon(Icons.send,color: AppColors.primary,))
                    ],
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }


  sendMsg()async{
    if (isTyping) {
       Get.snackbar(
         "You cant send multiple messages at a time",
         "",backgroundColor: Colors.red,colorText: Colors.white
      );

      return;
    }
    if (textEditingController.text.isEmpty) {
      Get.snackbar(
        "Please type a message","",backgroundColor: Colors.red,colorText: Colors.white
      );
      return;
    }
    //增加聊天内容
    try {
      String msg = textEditingController.text;
      setState(() {
        isTyping = true;
        controller.states.chatList.add(ChatModel(msg: msg, chatIndex: controller.states.chatList.length));
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
    } catch (error) {
      echoLog("error $error",error: error);
      Get.snackbar(
          error.toString(),"",backgroundColor: Colors.red,colorText: Colors.white
      );
    } finally {
      setState(() {
        controller.scrollListToEND();
        isTyping = false;
      });
    }
  }

  /// 用户头像
  Widget userAvatar({String? img, double? size}){
    return Padding(
      padding: EdgeInsets.all(10.r),
      child: CircleAvatar(
        radius: (size??2)/2,
        backgroundImage: AssetImage(img??"assets/user/user1.png"),
      ),
    );
    return Padding(
      padding: EdgeInsets.all(10.r),
      child: (img == null || img == "")
          ? Image.asset(
        "assets/user/user1.png",
        height: size,
      )
          : CircleAvatar(
        radius: (size??2)/2,
        backgroundImage: NetworkImage(img),
      ),
    );
  }


}

