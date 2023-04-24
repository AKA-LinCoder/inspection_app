


import '../entities/user.dart';
import '../utils/http.dart';
import '../values/system_code.dart';

/// 巡检
class InspectionAPI {

  //
  // @description 获取已经完成的任务接口
  // @author LinGy
  // @date 2023/4/23 10:55
  //
  static Future<LinResponse> selectTaskFinished({
    required String params,
  }) async {

    LinResponse response = await HttpUtil().get(
      'InspectionTask/selectTaskFinished/$params',
    );
    return response;

  }

  //
  // @description 获取未完成的任务接口
  // @author LinGy
  // @date 2023/4/23 10:55
  //
  static Future<LinResponse> selectTaskNotFinished({
    required String params,
  }) async {

    LinResponse response = await HttpUtil().get(
      'InspectionTask/selectTaskNotFinish/$params',
    );
    return response;

  }

  //
  // @description 添加一条记录
  // @author LinGy
  // @date 2023/4/23 10:55
  //
  static Future<LinResponse> addRecord({
    required String params,
  }) async {

    LinResponse response = await HttpUtil().post(
      'Record/addRecord',
      data: {
        "staffId":params
      },
    );
    return response;

  }



}
