


import 'dart:io';

import 'package:dio/dio.dart';
import 'package:echo_utils/echo_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inspection_app/main.dart';
import 'package:photo_manager/photo_manager.dart';

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
  // @description 查找所有的设备
  // @author LinGy
  // @date 2023/5/20 123:55
  //
  static Future<LinResponse> equipmentSelectAll() async {

    LinResponse response = await HttpUtil().get(
      'equipment/selectAll',
    );
    return response;

  }

  //
  // @description 添加一条记录
  // @author LinGy
  // @date 2023/4/23 10:55
  //
  static Future<LinResponse> addRecord({
    required Map params,
  }) async {

    LinResponse response = await HttpUtil().post(
      'Record/addRecord',
      data: params,
    );
    return response;

  }

  static Future<List<String>> updateFiles(
      {required List<AssetEntity> assets}) async {
    BuildContext context = appKey.currentState!.overlay!.context;
    ///上传公共图片
    var url = "/imageOss/uploadImage";
    List<String> path = [];
    for (int i = 0; i < assets.length; i++) {
      File? file;
      file = await assets[i].file;
      // File? imageCompressAndGetFile;
      if (file == null) {
        break;
      }
      if (assets[i].type == AssetType.video) {
        // 处理视频
        url = "/imageOss/video";
      } else if (assets[i].type == AssetType.image) {
        // 处理图片
        url = "/imageOss/uploadImage";
      }


      ///根据路径获取文件
      Map<String, dynamic> map = {};
      map['file'] = await MultipartFile.fromFile(file.path);
      // map['valveId'] = valveId;

      FormData formData = FormData.fromMap(map);

      final result = await HttpUtil().dioUpload(url, data: formData);
      if(result.code==200){
        final dataPath = result.data;
        if (dataPath == null) {
          EasyLoading.showError('图片地址为空');
        } else {
          // ImageModel imageModel = ImageModel.fromJson(dataPath);
          path.add(dataPath);
        }
      }else{

      }
      // if (result.runtimeType == DioError) {
      //   DioError error = result;
      //   EasyLoading.showError(error.message??'');
      // } else {
      //   try {
      //     if (result["code"] == 200) {
      //       final dataPath = result['data'];
      //       if (dataPath == null) {
      //         EasyLoading.showError('图片地址为空');
      //       } else {
      //         // ImageModel imageModel = ImageModel.fromJson(dataPath);
      //         path.add("");
      //       }
      //     } else {
      //       EasyLoading.showError(result["message"]);
      //       break;
      //     }
      //   } catch (e, stack) {
      //     EasyLoading.showError(e.toString());
      //     break;
      //   }
      // }
    }

    return path;

    ///上传完成没有错误的情况下，关闭动画

    //TODO 上传图片获取返回后得到的图片地址，将图片地址和阀门绑定
  }



}
