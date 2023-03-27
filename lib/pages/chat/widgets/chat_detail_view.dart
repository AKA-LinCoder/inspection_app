/// FileName chat_detail_view
///
/// @Author LinGuanYu
/// @Date 2023/3/27 20:08
///
/// @Description TODO 详细的聊天页面
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          IconButton(onPressed: (){}, icon: const Icon(Icons.local_phone_rounded))
        ],
      ),
      body: const Text("详细俩天页面"),
    );
  }
}
