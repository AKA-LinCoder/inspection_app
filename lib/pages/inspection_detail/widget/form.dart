import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/entities/inspection.dart';
import '../../../common/widgets/picker.dart';

import '../../../main.dart';


/// FileName maintenance_online_cleaning_and_lubrication_form
///
/// @Author LinGuanYu
/// @Date 2023/3/1 18:11
///
/// @Description TODO 在线清洗润滑form

typedef OnDelete();

class InspectionTaskForm extends StatefulWidget {
  final Content content;
  var state = _InspectionTaskFormState();
  InspectionTaskForm(
      {Key? key,
        required this.content,})
      : super(key: key);

  @override
  _InspectionTaskFormState createState() {
    return this.state = _InspectionTaskFormState();
  }

  bool isValid() => this.state.validate();
}

class _InspectionTaskFormState
    extends State<InspectionTaskForm> {
  final form = GlobalKey<FormState>();

  ///记录耗材类型
  late TextEditingController _desc1Controller;


  //

  @override
  void initState() {
    super.initState();
    _desc1Controller = TextEditingController();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    _desc1Controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _desc1Controller.text = widget
          .content
          .isTrue ??
          '';
    });

    return Material(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.r),
      child: Form(
        key: form,
        child: Padding(
          padding:  EdgeInsets.only(bottom: 8.r,right: 8.r,left: 8.r),
          child: Table(
            border: TableBorder.all(), //
            children: [
              TableRow(
                children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(widget.content.inspectionInfo)),
                  ),
                  TableCell(
                    child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(widget.content.information)),
                  ),
                  TableCell(
                    child: GestureDetector(
                      onTap: ()async{
                        widget.content.isTrue = await showPicker(
                            ["正常","异常",],
                            widget.content.isTrue,
                            appKey.currentState!.overlay!.context) ??'';
                        setState(() {});
                      },
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        enabled: false,
                        controller: _desc1Controller,
                        onSaved: (val) =>  widget.content.isTrue = val??'',
                        onChanged: (val) =>  widget.content.isTrue = val,
                        // validator: (val) => val!.length > 0,
                        decoration: InputDecoration(
                            hintText: "",
                            disabledBorder: InputBorder.none,
                            suffixIcon: Icon(Icons.keyboard_arrow_down,color: Colors.deepPurpleAccent,size: 14.w,)
                        ),
                        style: TextStyle(

                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(widget.content.inspectionInfo),
              //     Text(widget.content.information),
              //     SizedBox(
              //       width: 70.w,
              //       child: GestureDetector(
              //         onTap: ()async{
              //           widget.content.isTrue = await showPicker(
              //               ["正常","异常",],
              //               widget.content.isTrue,
              //               appKey.currentState!.overlay!.context) ??'';
              //           setState(() {});
              //         },
              //         child: TextFormField(
              //           enabled: false,
              //           controller: _desc1Controller,
              //           onSaved: (val) =>  widget.content.isTrue = val??'',
              //           onChanged: (val) =>  widget.content.isTrue = val,
              //           // validator: (val) => val!.length > 0,
              //           decoration: InputDecoration(
              //               hintText: "耗材类型",
              //               disabledBorder: UnderlineInputBorder(
              //                   borderSide: BorderSide(
              //                       color: Colors.grey,
              //                       width: 1.w
              //                   )
              //               ),
              //               suffixIcon: Icon(Icons.keyboard_arrow_down,color: Colors.deepPurpleAccent,size: 14.w,)
              //           ),
              //           style: TextStyle(
              //
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  ///form validator
  bool validate() {
    var valid = true;
    if (valid) form.currentState?.save();
    return valid;
  }
}
