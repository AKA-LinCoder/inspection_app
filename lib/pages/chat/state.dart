import 'package:get/get.dart';
import 'package:inspection_app/pages/chat/view.dart';

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
}
