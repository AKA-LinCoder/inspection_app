import 'package:get/get.dart';

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
  bool get isLogin => _isLogin.value;
  bool get hasToken => token.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    token = StorageService.to.getString(STORAGE_USER_TOKEN_KEY);

  }

  // 保存 token
  Future<void> setToken(String value) async {
    await StorageService.to.setString(STORAGE_USER_TOKEN_KEY, value);
    token = value;
  }




  // 注销
  // Future<void> onLogout() async {
  //   if (_isLogin.value) await UserAPI.logout();
  //   await StorageService.to.remove(STORAGE_USER_TOKEN_KEY);
  //   _isLogin.value = false;
  //   token = '';
  // }
}