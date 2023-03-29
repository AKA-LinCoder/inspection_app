/// FileName chat_widget
///
/// @Author LinGuanYu
/// @Date 2023/3/29 14:33
///
/// @Description TODO
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:echo_utils/echo_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inspection_app/common/themes/colors.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget(
      {super.key,
      required this.msg,
      required this.chatIndex,
      required this.me,
      required this.allChats,
      this.shouldAnimate = false});

  final String msg;
  final int chatIndex;
  final bool shouldAnimate;
  final bool me;
  final int allChats;

  ///聊天框最大宽度
  final double maxWidth = 200;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: !me
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///对方的消息
                    Image.asset(
                      me ? "assets/user/user1.png" : "assets/user/user3.png",
                      height: 30,
                      width: 30,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    LimitedBox(
                      maxWidth: maxWidth,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        padding: EdgeInsets.all(5.r),
                        child: Text(
                          msg,
                          style: TextStyle(
                              fontSize: 16.sp, color: Colors.black),
                        ),
                        // child: allChats!=chatIndex+1
                        //     ? Text(
                        //         msg,
                        //         style: TextStyle(
                        //             fontSize: 16.sp, color: Colors.black),
                        //       )
                        //     : shouldAnimate
                        //         ? DefaultTextStyle(
                        //             style: TextStyle(
                        //                 color: Colors.black,
                        //                 fontWeight: FontWeight.normal,
                        //                 fontSize: 16.sp),
                        //             child: AnimatedTextKit(
                        //                 isRepeatingAnimation: false,
                        //                 repeatForever: false,
                        //                 displayFullTextOnTap: true,
                        //                 totalRepeatCount: 1,
                        //                 animatedTexts: [
                        //                   TyperAnimatedText(
                        //                     msg.trim(),
                        //                   ),
                        //                 ]),
                        //           )
                        //         : Text(
                        //             msg.trim(),
                        //             style: const TextStyle(
                        //                 color: Colors.white,
                        //                 fontWeight: FontWeight.w700,
                        //                 fontSize: 16),
                        //           ),
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   mainAxisSize: MainAxisSize.min,
                    //   children:  [
                    //     Icon(
                    //       Icons.thumb_up_alt,
                    //       color: Colors.white,
                    //       size: 20.w,
                    //     ),
                    //     SizedBox(
                    //       width: 5.w,
                    //     ),
                    //     Icon(
                    //       Icons.thumb_down_alt,
                    //       color: Colors.white,
                    //       size: 20.w,
                    //     )
                    //   ],
                    // ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///我发的消息
                    LimitedBox(
                      maxWidth: maxWidth,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        padding: EdgeInsets.all(5.r),
                        child: Text(
                          msg.trim(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Image.asset(
                      me ? "assets/user/user1.png" : "assets/user/user3.png",
                      height: 30,
                      width: 30,
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
