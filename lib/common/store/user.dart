import 'package:get/get.dart';

import '../api/user.dart';
import '../routes/router_name.dart';
import '../services/services.dart';
import '../values/values.dart';

/// FileName user
///
/// @Author LinGuanYu
/// @Date 2023/3/20 14:38
///
/// @Description TODO

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  // 是否登录
  final _isLogin = false.obs;
  // 令牌 token
  String token = '';
  int staffId = 0;
  bool get isLogin => _isLogin.value;
  bool get hasToken => token.isNotEmpty;
  String userName = '';

  bool userProtocol = false;

  @override
  void onInit() {
    super.onInit();
    token = StorageService.to.getString(STORAGE_USER_TOKEN_KEY);
    userProtocol = StorageService.to.getBool(STORAGE_USER_PROTOCOL_KEY);
    userName = StorageService.to.getString(STORAGE_USER_NAME_KEY);
    staffId = StorageService.to.getInt(STORAGE_STAFFID_KEY);
    //初始化时,如果token不为null或者不为“”,就代表已经登录过
    if(token!=""){
      _isLogin.value = true;
    }

  }

  // 保存 用户同意了隐私权益
  Future<void> setProtocol(bool value) async {
    await StorageService.to.setBool(STORAGE_USER_PROTOCOL_KEY, value);
    userProtocol = value;
  }

  Future<void> setStaffId(int value) async {
    await StorageService.to.setInt(STORAGE_STAFFID_KEY, value);
    staffId = value;
  }

  // 保存 token
  Future<void> setToken(String value) async {
    await StorageService.to.setString(STORAGE_USER_TOKEN_KEY, value);
    token = value;
  }
  // 保存 用户名
  Future<void> setUserName(String value) async {
    await StorageService.to.setString(STORAGE_USER_NAME_KEY, value);
    userName = value;
  }




  // 注销
  Future<bool> onLogout() async {

    if (_isLogin.value){
      var res =  await UserAPI.logout();
      if(res==true){
        await StorageService.to.remove(STORAGE_USER_TOKEN_KEY);
        _isLogin.value = false;
        token = '';
      }else{


      }
      return res;
    }
    return false;

  }
  Future<bool> onLogoutWithOutToken() async {

    if (_isLogin.value){
      await StorageService.to.remove(STORAGE_USER_TOKEN_KEY);
      _isLogin.value = false;
      token = '';
      Get.offAndToNamed(AppRoutes.SIGN_IN);
      return true;
    }
    return false;

  }
}