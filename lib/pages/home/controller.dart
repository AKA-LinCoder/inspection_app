import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:inspection_app/common/api/inspection.dart';
import 'package:inspection_app/common/entities/inspection.dart';
import 'package:inspection_app/common/store/store.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/utils/toast_utils.dart';
import 'index.dart';

/// FileName controller
///
/// @Author LinGuanYu
/// @Date 2023/3/30 20:25
///
/// @Description TODO

class HomeController extends GetxController with StateMixin{
  // final state = HomeState();

  HomeController();



  /// UI 组件
  final RefreshController refreshController = RefreshController (
    // initialRefresh: true,
  );

  final RefreshController refreshController2 = RefreshController (
    // initialRefresh: true,
  );


  /// 响应式成员变量
  final states = HomeState();

  /// 成员变量

  String schemeId = UserStore.to.staffId.toString();


  @override
  void onReady() {
    // TODO: implement onReady
    getUnFinishedTaskList();
    getFinishedTaskList();
    super.onReady();
  }

  void onRefresh() {
    getUnFinishedTaskList(isRefresh: true).then((_) {
      refreshController.refreshCompleted(resetFooterState: true);
    }).catchError((_) {
      refreshController.refreshFailed();
    });
  }

  void onRefresh2() {
    getFinishedTaskList(isRefresh: true).then((_) {
      refreshController2.refreshCompleted(resetFooterState: true);
    }).catchError((_) {
      refreshController2.refreshFailed();
    });
  }




  // 拉取数据
  Future<void> getUnFinishedTaskList({bool isRefresh = true}) async {

    if (isRefresh == true) {
      change(null,status: RxStatus.loading());
      states.unFinishedTaskList.clear();
    } else {
    }

    var result = await InspectionAPI.selectTaskNotFinished(
        params : schemeId
    );

    if(result.runtimeType == String){
      var error = result as String;
      change(null,status: RxStatus.error(error));
    }else{
      List<dynamic> m = result.data;
      var res = m.map((e) => InspectionTask.fromJson(e)).toList();
      if(res != null){
        if(res!.isEmpty){

          if (isRefresh == true) {
            Toast.show('暂无待完成任务');
            change(null,status: RxStatus.empty());
          } else {
            Toast.show('没有更多了');
            // change(null,status: RxStatus.success());
          }

        }else{
          states.unFinishedTaskList.addAll(res!);
          if (isRefresh == true) {
            change(null,status: RxStatus.success());
          } else {
          }

        }
      }else{
        change(null,status: RxStatus.error('数据返回异常为null'));
      }

    }

  }


  //获取设备列表
  getEquipmentList()async{
    var result = await InspectionAPI.equipmentSelectAll(
    );
    if(result.runtimeType == String){
      var error = result as String;
      EasyLoading.showError(error);
    }else{
      List<dynamic> m = result.data;
      var res = m.map((e) => Equipment.fromJson(e)).toList();
      states.equipmentList.addAll(res);
    }
  }



  Future<void> getFinishedTaskList({bool isRefresh = true}) async {

    if (isRefresh == true) {
      change(null,status: RxStatus.loading());
      states.finishedTaskList.clear();
    } else {
    }

    var result = await InspectionAPI.selectTaskFinished(
        params : schemeId
    );

    if(result.runtimeType == String){
      var error = result as String;
      change(null,status: RxStatus.error(error));
    }else{
      List<dynamic> m = result.data;
      var res = m.map((e) => InspectionTask.fromJson(e)).toList();
      if(res != null){
        if(res!.isEmpty){

          if (isRefresh == true) {
            Toast.show('暂无待完成任务');
            change(null,status: RxStatus.empty());
          } else {
            Toast.show('没有更多了');
            // change(null,status: RxStatus.success());
          }

        }else{
          states.finishedTaskList.addAll(res!);
          if (isRefresh == true) {
            change(null,status: RxStatus.success());
          } else {
          }

        }
      }else{
        change(null,status: RxStatus.error('数据返回异常为null'));
      }

    }

  }



}