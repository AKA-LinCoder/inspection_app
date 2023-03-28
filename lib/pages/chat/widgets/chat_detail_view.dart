/// FileName chat_detail_view
///
/// @Author LinGuanYu
/// @Date 2023/3/27 20:08
///
/// @Description TODO 详细的聊天页面
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatDetailView extends StatefulWidget {
  const ChatDetailView({Key? key}) : super(key: key);

  @override
  State<ChatDetailView> createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends State<ChatDetailView> {
  late String name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = Get.arguments??"";
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
          IconButton(onPressed: (){
            launchUrl(Uri.file("13980785487"));
          }, icon: const Icon(Icons.local_phone_rounded))
        ],
      ),
      body: const Text("详细俩天页面"),
    );
  }
}

class ChatDetailView extends StatefulWidget {
  const ChatDetailView({Key? key}) : super(key: key);

  @override
  State<ChatDetailView> createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends State<ChatDetailView> {
  final bool isTyping = true;
  late TextEditingController textEditingController ;

  FocusNode focusNode = FocusNode();



  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

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
      appBar: AppBar(
        title: const Text("ChatGPT"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(child: ListView.builder(
              itemCount: 6,
                itemBuilder: (context,index){
              return const Text("hello");
            })),
            if(isTyping)...[
                 SpinKitThreeBounce(color: AppColors.primary,size: 18.sp,)
            ],
            SizedBox(
              height: 50,
              child: Material(
                color: Colors.deepOrange,
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
                            fontSize: 16.sp
                          )),
                        ),
                      ),
                      IconButton(onPressed: (){}, icon: Icon(Icons.send,color: AppColors.primary,))
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
}
