import 'dart:io';

import 'package:echo_utils/echo_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inspection_app/common/themes/texts.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../main.dart';

/// FileName permission_util
///
/// @Author LinGuanYu
/// @Date 2023/3/20 18:49
///
/// @Description TODO 权限申请相关
class PermissionUtil {
  final BuildContext _context;

  PermissionUtil(this._context);

  ///是否去设置中心
  bool isGoAppSetting = false;


  void checkPermission({required Permission permission,required String name, PermissionStatus? status}) async {
    echoLog("这是传进来的$status");
    status ??= await permission.status;
    echoLog("这是检查结果$status");
    if(status==PermissionStatus.granted){
      ///权限通过
    }else if(status == PermissionStatus.denied){
      ///被拒绝了
      showPermissionDialog('此应用需要$name权限，用于上传图片到服务器，请授权', "确定",permission,permanentlyDenied: false,name: name);
    }else if(status == PermissionStatus.permanentlyDenied){
      ///被永久拒绝了
      showPermissionDialog('您永久拒绝了$name权限，但是该应用需要$name权限，是否授权', "打开设置",permission,permanentlyDenied: true,name: name);
    }
  }


  void showPermissionDialog(
      String msg, String rightMsg, Permission permission,{bool permanentlyDenied = false,required String name}) {
    var context = appKey.currentState!.overlay!.context;
    isGoAppSetting = permanentlyDenied;
    //使用苹果的dialog
    showCupertinoDialog(
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text("温馨提示"),
            content: Text(msg),
            actions: [
              //左边按钮
              CupertinoDialogAction(
                child: const Text("关闭应用"),
                onPressed: (){
                  //关闭引用
                  closeApp();
                },
              ),
              //右边
              CupertinoDialogAction(
                child: Text(rightMsg),
                onPressed: () {
                  print("点击事件");
                  //关闭弹框
                  Navigator.pop(context);
                  if(permanentlyDenied){
                    //去设置中心
                    openAppSettings();
                  }else{
                    //申请权限
                    requestPermission(context,permission,name);
                  }


                },
              ),
            ],
          );
        },
        context: context);
  }

  void requestPermission(BuildContext context,Permission permission,String name) async {
    //请求权限
    PermissionStatus status = await permission.request();
    echoLog("这是请求权限后的结果$status");
    //校验
    checkPermission(permission: permission,name: name,status: status);

  }


  //关闭应用？？
  Future closeApp()async{
    //不知道为啥没用
    // await SystemChannels.platform.invokeMethod("SystemNavigator.pop");
    exit(0);
  }

}