import 'package:flutter/material.dart';
import 'package:flutter_picker/picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/toast_utils.dart';

Future<String?> showPicker(List options,String? oldValue, BuildContext context) async {
  if(options.isNotEmpty){
    String? result = oldValue;
    int index = options.indexOf(oldValue);
    await Picker(
        height: 220.h,
        itemExtent: 38,
        cancelText: '取消',
        confirmText: '确认',
        adapter: PickerDataAdapter<String>(pickerData: options),
        //默认选中
        selecteds: [index],
        onConfirm: (Picker picker, List value) {
          result = options[value.first];
        }).showModal(context);

    return result;
  }else{
    Toast.show("没有值可以选择");
    return oldValue;
  }

}