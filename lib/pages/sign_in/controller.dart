import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:echo_utils/echo_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_app/common/api/user.dart';
import 'package:inspection_app/common/entities/user.dart';
import 'package:inspection_app/common/store/store.dart';
import 'package:inspection_app/common/utils/loading.dart';
import 'package:inspection_app/main.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../common/routes/router_name.dart';
import '../../common/utils/permission_util.dart';
import 'index.dart';

/// FileName controller
///
/// @Author LinGuanYu
/// @Date 2023/3/20 18:24
///
/// @Description TODO

class SignInController extends GetxController {
  final states = SignInState();

  SignInController();

  // 账号的控制器
  final TextEditingController accountController = TextEditingController();
  // 密码的控制器
  final TextEditingController passController = TextEditingController();

  // final MyRepository repository;
  // SignInController({@required this.repository}) : assert(repository != null);
  bool passwordVisible = false; //设置初始状态


  @override
  void onReady() {
    super.onReady();
    states.isAgree.value = UserStore.to.userProtocol;
    echoLog("用户协议${states.isAgree.value}");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      echoLog("在这里检查权限");
    });
  }


  toLogin()async{
    Loading.show("登录中");
    var params = UserLoginRequestEntity(userName: accountController.text, passWord: passController.text);
    var res = await UserAPI.login(params: params);
    Loading.dismiss();
    if(res.code==200){

      //存储用户权限
      UserLoginResponseEntity user = UserLoginResponseEntity.fromJson(res.data);
      await UserStore.to.setUserName(user.name);
      await UserStore.to.setToken(user.token);
      await UserStore.to.setStaffId(user.staffId);
      Get.offAllNamed(AppRoutes.Application);
    }else{

    }
  }


  void check()async{

  }

  @override
  void onInit() {
    // TODO: implement onInit


    super.onInit();

    try{
      throw "异常";
    }catch(error,stack){
      echoLog("自己补货的异常");

    }

  }


  ///@title checkPermissionFunction
  ///@description TODO  检查权限
  ///@updateTime 2023/3/20 18:42
  ///@author LinGuanYu
  void checkPermissionFunction({PermissionStatus? status})async{
    var context = appKey.currentState!.overlay!.context;
    // PermissionUtil(context).checkPermission( permission: Permission.camera,name: "相机");
    if(Platform.isAndroid){
      final info = await DeviceInfoPlugin().androidInfo;
      if(info.version.sdkInt<=32){
        PermissionUtil(context).checkPermission( permission: Permission.storage,name: "相册");
      }else{
        PermissionUtil(context).checkPermission( permission: Permission.photos,name: "相册");
      }
    }else if(Platform.isIOS){
      PermissionUtil(context).checkPermission( permission: Permission.photos,name: "相册");
    }else{

    }


  }

  @override
  void dispose() {
    accountController.dispose();
    passController.dispose();
    super.dispose();
  }

}