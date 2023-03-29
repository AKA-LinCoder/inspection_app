import 'package:flutter/material.dart';

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

class ChatBottomModel {
  final String title;
  final Icon icon;

  ChatBottomModel({required this.title, required this.icon});

  factory ChatBottomModel.fromJson(Map<String, dynamic> json) => ChatBottomModel(
    title: json["title"],
    icon: json["icon"],
  );
}