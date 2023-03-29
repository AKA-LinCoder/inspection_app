// /// FileName chat_bottom
// ///
// /// @Author LinGuanYu
// /// @Date 2023/3/29 19:48
// ///
// /// @Description TODO 聊天底部输入框
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../common/themes/colors.dart';
//
// class ChatBottom extends StatefulWidget {
//   const ChatBottom({Key? key}) : super(key: key);
//
//   @override
//   State<ChatBottom> createState() => _ChatBottomState();
// }
//
// class _ChatBottomState extends State<ChatBottom> with WidgetsBindingObserver {
//   // 0 语音 1 键盘 2 表情
//   int _inputType = 0;
//   final TextEditingController _controller = TextEditingController();
//   final FocusNode _focusNode = FocusNode();
//
//   bool get _keyboardShow => widget.providerChatContent.contentShow;
//
//   final List<Map> _listOption = [
//     {'title': '相册', 'icon': 'assets/common/chat/ic_details_photo.webp'},
//     {'title': '拍照', 'icon': 'assets/common/chat/ic_details_camera.webp'},
//     {'title': '视频通话', 'icon': 'assets/common/chat/ic_details_video.webp'},
//     {'title': '位置', 'icon': 'assets/common/chat/ic_details_localtion.webp'},
//     {'title': '红包', 'icon': 'assets/common/chat/ic_details_red.webp'},
//     {'title': '转账', 'icon': 'assets/common/chat/ic_details_transfer.webp'},
//     {'title': '语音输入', 'icon': 'assets/common/chat/ic_chat_voice.webp'},
//     {'title': '我的收藏', 'icon': 'assets/common/chat/ic_details_favorite.webp'},
//   ];
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     _controller.addListener(() {
//       setState(() {});
//     });
//     _focusNode.addListener(() {
//       if (_focusNode.hasFocus) {
//         // widget.providerChatContent.updateContentShow(true);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print('ChatBottom------------------------build');
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 20.r),
//       decoration: BoxDecoration(
//         color: Colors.red,
//         border: Border(
//           top: BorderSide(width: 1.w, color: AppColors.primary),
//         ),
//       ),
//       // height: 110.cale,
//       child: Column(
//         children: [
//           ///第一层
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               AnimatedSwitcher(
//                 duration: const Duration(milliseconds: 20),
//                 transitionBuilder: (Widget child, Animation<double> animation) {
//                   return FadeTransition(
//                     opacity: animation,
//                     child: child,
//                   );
//                 },
//                 child: _inputType == 0
//                     ? AppWidget.inkWellEffectNone(
//                   key: const ValueKey("AppIcon.audio"),
//                   onTap: () {
//                     print('启动音频');
//                     _inputType = 1;
//                     widget.providerChatContent.updateContentShow(false);
//                   },
//                   child: Padding(
//                     padding:
//                     EdgeInsets.only(left: 20.cale, bottom: 15.cale),
//                     child: Icon(
//                       AppIcon.audio,
//                       size: 50.cale,
//                       color: Colors.black,
//                     ),
//                   ),
//                 )
//                     : AppWidget.inkWellEffectNone(
//                   key: const ValueKey("AppIcon.keyboard"),
//                   onTap: () {
//                     _inputType = 0;
//                     widget.providerChatContent.updateContentShow(true);
//                     _focusNode.requestFocus();
//                   },
//                   child: Padding(
//                     padding:
//                     EdgeInsets.only(left: 20.cale, bottom: 15.cale),
//                     child: Icon(
//                       AppIcon.keyboard,
//                       size: 50.cale,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: _inputType == 0
//                     ? Padding(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 20.cale,
//                   ),
//                   child: ChatInputBox(
//                     style: AppTextStyle.textStyle_30_000000,
//                     onEditingComplete: () {
//                       print("onEditingComplete");
//                     },
//                     onSubmitted: (str) {
//                       print("onSubmitted:$str");
//                     },
//                     controller: _controller,
//                     focusNode: _focusNode,
//                   ),
//                 )
//                     : AppWidget.inkWellEffectNone(
//                   onTap: () {},
//                   child: Container(
//                     margin: EdgeInsets.symmetric(horizontal: 20.cale),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(7.cale),
//                     ),
//                     height: 80.cale,
//                     child: Center(
//                       child: Text(
//                         '按住 说话',
//                         style: AppTextStyle.textStyle_30_000000,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               AppWidget.inkWellEffectNone(
//                 onTap: () {
//                   print('添加表情符号');
//                 },
//                 child: Padding(
//                   padding: EdgeInsets.only(bottom: 15.cale),
//                   child: Icon(
//                     AppIcon.faceHappy,
//                     size: 50.cale,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               AnimatedSwitcher(
//                 duration: const Duration(milliseconds: 50),
//                 transitionBuilder: (Widget child, Animation<double> animation) {
//                   return ScaleTransition(
//                     scale: animation,
//                     alignment: Alignment.centerRight,
//                     child: FadeTransition(
//                       opacity: animation,
//                       child: child,
//                     ),
//                   );
//                 },
//                 child: _inputType == 0 && _controller.value.text.isNotEmpty
//                     ? AppWidget.inkWellEffectNone(
//                   key: const ValueKey('发送'),
//                   onTap: () {
//                     print('发送');
//                     _controller.clear();
//                   },
//                   child: Container(
//                     margin: EdgeInsets.only(
//                         left: 20.cale, right: 24.cale, bottom: 10.cale),
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 24.cale,
//                       vertical: 10.cale,
//                     ),
//                     decoration: BoxDecoration(
//                       color: AppColor.color05C160,
//                       borderRadius: BorderRadius.circular(12.cale),
//                     ),
//                     child: Center(
//                         child: Text(
//                           '发送',
//                           style: AppTextStyle.textStyle_30_FFFFFF,
//                         )),
//                   ),
//                 )
//                     : AppWidget.inkWellEffectNone(
//                   key: const ValueKey('AppIcon.add'),
//                   onTap: () {
//                     print('添加附件 图片视频');
//                     setState(() {
//                       if (_focusNode.hasFocus) {
//                         _focusNode.unfocus();
//                       }
//                       widget.providerChatContent.updateContentShow(true);
//                       // print(
//                       //     '---------${DataInheritedWidget.of(context)?.dataEnvironment.keyboardHeight}');
//                       //InheritedKeyboard.of(context)?.updateKeyboard(true);
//                     });
//                   },
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                         left: 10.cale, right: 20.cale, bottom: 10.cale),
//                     child: Icon(
//                       AppIcon.add,
//                       size: 58.cale,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           if (_keyboardShow)
//             Container(
//               width: double.infinity,
//               margin: EdgeInsets.only(
//                 top: 20.cale,
//               ),
//               // padding: EdgeInsets.only(bottom: 200.cale),
//               decoration: BoxDecoration(
//                 border: Border(
//                   top: BorderSide(width: 1.cale, color: AppColor.colordddddd),
//                 ),
//               ),
//               height: widget.providerChatContent.keyboardHeight,
//               child: Wrap(
//                 runAlignment: WrapAlignment.center,
//                 alignment: WrapAlignment.center,
//                 //crossAxisAlignment: WrapCrossAlignment.center,
//                 spacing: 75.cale,
//                 runSpacing: 60.cale,
//                 children: _listOption
//                     .asMap()
//                     .map(
//                       (key, value) => MapEntry(
//                     key,
//                     SizedBox(
//                       width: 100.cale,
//                       height: 150.cale,
//                       child: Column(
//                         children: [
//                           Container(
//                             width: 100.cale,
//                             height: 100.cale,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(25.cale),
//                             ),
//                             child: Image.asset(
//                               value['icon'],
//                               width: 50.cale,
//                               height: 50.cale,
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(top: 16.cale),
//                             child: Text(
//                               value['title'],
//                               style: AppTextStyle.textStyle_20_656565,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 )
//                     .values
//                     .toList(),
//               ),
//             )
//         ],
//       ),
//     );
//   }
//
//   ///应用尺寸改变时回调，例如旋转 键盘
//   @override
//   void didChangeMetrics() {
//     // TODO: implement didChangeMetrics
//     super.didChangeMetrics();
//     if (mounted) {
//       // 键盘高度
//       final double viewInsetsBottom = EdgeInsets.fromWindowPadding(
//           WidgetsBinding.instance.window.viewInsets,
//           WidgetsBinding.instance.window.devicePixelRatio)
//           .bottom;
//       if (viewInsetsBottom > 0) {
//         widget.providerChatContent.updateKeyboardHeight(viewInsetsBottom);
//       }
//     }
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _focusNode.dispose();
//     _controller.dispose();
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
// }
