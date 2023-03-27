
import 'package:flutter/material.dart';
import 'package:inspection_app/common/themes/colors.dart';


List indexWord = ['#','A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
class ChatChooseIndex extends StatefulWidget {
  final void Function(int index) indexBarCallBack;
  double totalHeight;
  int chooseIndex = -1;
  double firstItemHeight;
  ChatChooseIndex({super.key, required this.indexBarCallBack, required this.totalHeight, required this.chooseIndex, required this.firstItemHeight});
  @override
  ChatChooseIndexState createState() => ChatChooseIndexState();
}

class ChatChooseIndexState extends State<ChatChooseIndex> {
  double _totalHeight = 0;
  double _indicatorY = 0.0;
  bool _indicatorHidden = true;
  String _indicatorText = 'A';
  double dragHeight = 0;
  double _firstItemHeight = 0;
  @override
  void initState() {
    super.initState();
    _totalHeight = widget.totalHeight;
    dragHeight = 25*_totalHeight/27;
    _firstItemHeight = widget.firstItemHeight;
  }
  @override
  Widget build(BuildContext context) {

    ///固定在距离右边15的距离
    return Positioned(
      right: 15,
      top: _firstItemHeight,
      height: _totalHeight,
      width: 110,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //指示器
          Container(
            padding: EdgeInsets.only(left: 0,top: _indicatorY),
            width: 110 - dragHeight/27,
            // color: Colors.red,
            child: _indicatorHidden?null:Stack(
              alignment: const Alignment(-0.2,0),
              children: [
                Stack(
                  children: [
                    Image.asset('assets/bg_address_index.png',
                      height: dragHeight/9,
                      width: 110 - dragHeight/27,),
                    Text(_indicatorText,style: const TextStyle(fontSize: 18,color: Colors.white),)
                  ],
                ),
                Text(_indicatorText,style: const TextStyle(fontSize: 18,color: Colors.white),)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: dragHeight/27,bottom: dragHeight/27),
            child: GestureDetector(
              onVerticalDragDown: (DragDownDetails details){
                final int index = getIndexItem(context, details.globalPosition);
                widget.indexBarCallBack(index);
                setState(() {
                  widget.chooseIndex = index;
                  _indicatorY =  index * dragHeight/27;
                  _indicatorText = indexWord[index];
                  _indicatorHidden = false;//是否隐藏指示器
                });
              },
              onVerticalDragCancel: () {
                setState(() {
                  _indicatorHidden = true; //是否隐藏指示器
                });
              },
              onVerticalDragEnd:(DragEndDetails details){
                setState(() {
                  _indicatorHidden = true;//是否隐藏指示器
                });
              },
              onVerticalDragUpdate: (DragUpdateDetails details){
                final int index = getIndexItem(context, details.globalPosition);
                widget.indexBarCallBack(index);
                setState(() {
                  widget.chooseIndex = index;
                  _indicatorY =  index * dragHeight/27;
                  _indicatorText = indexWord[index];
                  _indicatorHidden = false;//是否隐藏指示器
                });
              },
              child: SizedBox(
                width:dragHeight/27,
                // color: AppColor.black,
                child: _getListView(context)
              ),
            ),
          ),
        ],
      )
    );
  }
  Widget _getListView(BuildContext context) {
    return ListView.builder(itemBuilder: _getListItem,
      itemCount: indexWord.length,
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,);
  }

  Widget _getListItem(BuildContext context, int index) {
    return Container(
        // padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),

        height: dragHeight/27,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: widget.chooseIndex == index ? const Color(0xff007EFF) : Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(22)),
        ),
        child: FittedBox(
          child: Text(indexWord[index], style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: widget.chooseIndex == index ? AppColors.primary : Colors.blue
          ),),
        )
    );
  }

  int getIndexItem(BuildContext context,Offset globalPosition){
    //拿到当前盒子
    final RenderBox? box = context.findRenderObject() as RenderBox?;
    //拿到y值，当前位置到部件原点(部件左上角)的距离(x,y)
    var y = box?.globalToLocal(globalPosition).dy;
    //算出字符高度
    final itemHeight = dragHeight/27;
    int index = (y??0) ~/itemHeight.clamp(0, indexWord.length-1) - 1;//~取整,设置取整范围clamp
    if(index > 26) {
      index = 26;
    }
    if (index < 0) {
      index = 0;
    }
    return index;
  }

}