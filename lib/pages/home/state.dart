import 'package:get/get.dart';

import '../../common/entities/inspection.dart';

/// FileName state
///
/// @Author LinGuanYu
/// @Date 2023/3/30 20:25
///
/// @Description TODO

class HomeState {


  RxBool isAgree = false.obs;

  RxList<InspectionTask> unFinishedTaskList = <InspectionTask>[].obs;

  RxList<InspectionTask> finishedTaskList = <InspectionTask>[].obs;

  RxList<Equipment> equipmentList = <Equipment>[].obs;

}
