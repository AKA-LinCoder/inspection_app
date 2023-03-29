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
import 'package:inspection_app/common/themes/texts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/themes/colors.dart';

class ChatDetailView extends StatefulWidget {
  const ChatDetailView({Key? key}) : super(key: key);

  @override
  State<ChatDetailView> createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends State<ChatDetailView> {
  late String name;

  @override
  void initState() {
    textEditingController = TextEditingController();
    name = Get.arguments??"";
    super.initState();

  }

  final bool isTyping = true;
  late TextEditingController textEditingController ;

  FocusNode focusNode = FocusNode();




  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textEditingController.dispose();
    focusNode.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
          IconButton(onPressed: ()async{
            try{
              if(await canLaunchUrl(Uri(scheme: "tel",path: "13586420519"))){
                echoLog("能拨打电话");
              }else{
                echoLog("不能拨打电话");
              }
              ///拨打电话
             var res=  await launchUrl(Uri(scheme: "tel",path: "1398542445"));
             echoLog("拨打电话结果$res");
            }catch(e,stack){
              echoLog("",error: e,stackTrace: stack);
            }
          }, icon: const Icon(Icons.local_phone_rounded))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context,index){
                  return Row(
                    children: [
                      userAvatar(size: 40.w),
                       Container(

                       ),
                       Text("hello",style: Styles.headLineStyle4.copyWith(color: Colors.black),)
                    ],
                  );
                  return const Text("hello");
                })),
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
                      Expanded(
                        child: TextField(
                          controller: textEditingController,
                          style: TextStyle(
                              fontSize: 16.sp
                          ),
                          decoration:  InputDecoration.collapsed(hintText: "how can i help you",hintStyle: TextStyle(
                              fontSize: 16.sp,color: Colors.black
                          )),
                        ),
                      ),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.send,color: AppColors.primary,))
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

