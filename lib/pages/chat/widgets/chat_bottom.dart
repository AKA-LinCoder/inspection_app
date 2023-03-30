/// FileName chat_bottom
///
/// @Author LinGuanYu
/// @Date 2023/3/29 19:48
///
/// @Description TODO 聊天底部输入框
import 'package:echo_utils/echo_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/model/chat.dart';
import '../../../common/themes/colors.dart';
class ChatBottom extends StatefulWidget {
  final int pageCount;
  final List<ChatBottomModel> items;
  int pageIndex;
  double height;
  ChatBottom({Key? key, required this.pageCount, required this.items, required this.pageIndex,required this.height}) : super(key: key);

  @override
  State<ChatBottom> createState() => _ChatBottomState();
}

class _ChatBottomState extends State<ChatBottom> {
  @override
  Widget build(BuildContext context) {
    echoLog("要显示的高${widget.height}");
    return Container(
        width: double.infinity,
        // margin: EdgeInsets.only(top: 10),
        height: widget.height,
        color: Colors.grey[200],
        child: Column(
          children: [
            Divider(color: Colors.black54,height: 1.w,),
            ///主要内容展示区域
            Expanded(child: getPageBody()),
            ///底部的指示器
            Container(
              height: 15.w,
              alignment: Alignment.center,
              child: ListView.builder(
                  shrinkWrap: true,
                  physics:  const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: (widget.items.length % widget.pageCount) > 0
                      ? (widget.items.length ~/ widget.pageCount) + 1
                      : (widget.items.length ~/ widget.pageCount),
                  itemBuilder: (context,index){
                    return Container(
                      alignment: const Alignment(0,.5),
                      height: 15.w,
                      width: 15.w,
                      child: CircleAvatar(
                        radius: 5,
                        backgroundColor: widget.pageIndex==index?AppColors.primary:Colors.grey,
                        child: Container(
                          alignment: const Alignment(0,.5),
                          height: 5.w,
                          width: 5.w,
                        ),

                      ),
                    );
                  }),
            )
          ],
        )
    );
    return  getPageBody();
  }

  ///@title getPageBody
  ///@description TODO  主要的内容展示区域
  ///@return: Widget
  ///@updateTime 2023/3/30 18:16
  ///@author LinGuanYu
  Widget getPageBody() {
    return PageView.builder(
      itemCount: (widget.items.length % widget.pageCount) > 0
          ? (widget.items.length ~/ widget.pageCount) + 1
          : (widget.items.length ~/ widget.pageCount),
      onPageChanged: (index) {
        widget.pageIndex = index;
        setState(() {});
      },
      itemBuilder: (BuildContext context, int index) {
        return ScrollConfiguration(
            behavior: const ScrollBehavior(),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: (index < (widget.items.length ~/ widget.pageCount))
                  ? widget.pageCount
                  : (widget.items.length % widget.pageCount),
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.pageCount~/2,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, position) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.grey[200],
                  child: Column(
                    children: [
                      // Image.asset(
                      //   widget.items[index * 4 + position].toString(),
                      //   width: 40,
                      //   height: 40,
                      // ),
                      SizedBox(height: 5.h,),
                      Container(
                        width: 40.w,
                        height: 40.w,

                        decoration: BoxDecoration(
                            color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8.r))
                        ),
                        child: widget.items[index * widget.pageCount + position].icon,
                      ),
                      SizedBox(height: 5.h,),
                      Text(
                        widget.items[index * widget.pageCount + position].title.toString(),
                        style: const TextStyle(fontSize: 12,color: Colors.black54),
                      ),
                    ],
                  ),
                );
              },
            ));
      },
    );}
  
  
}
