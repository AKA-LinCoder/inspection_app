import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_app/pages/chat/view.dart';

import '../../common/model/chat.dart';

/// FileName state
///
/// @Author LinGuanYu
/// @Date 2023/3/27 18:50
///
/// @Description TODO

class ChatState {

  RxList<TeacherChooseList> teacherList = <TeacherChooseList>[].obs;

  // 当前选择item的位置
  RxInt indexLocation = (-1).obs;
  RxList<ChatModel> chatList = <ChatModel>[].obs;

  RxBool textModel = true.obs;

  ///控制是否显示附件区域
  RxBool contentShow = false.obs;

  RxDouble keyboardHeight = (200.w).obs;

}
