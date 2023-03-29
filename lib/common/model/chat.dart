/// FileName chat
///
/// @Author LinGuanYu
/// @Date 2023/3/29 14:29
///
/// @Description TODO 聊天model

class ChatModel {
  final String msg;
  final int chatIndex;

  ChatModel({required this.msg, required this.chatIndex});

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    msg: json["msg"],
    chatIndex: json["chatIndex"],
  );
}
