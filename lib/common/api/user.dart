


import '../entities/user.dart';
import '../utils/http.dart';
import '../values/system_code.dart';

/// 用户
class UserAPI {

  //
  // @description 登录接口
  // @author LinGy
  // @date 2023/4/23 10:27
  //
  static Future<LinResponse> login({
    UserLoginRequestEntity? params,
  }) async {

    LinResponse response = await HttpUtil().post(
      'staff/login',
      data: params?.toJson(),
    );
    return response;

  }

  //
  // @description 登出接口
  // @author LinGy
  // @date 2022/5/13 17:27
  //
  static Future<bool> logout() async {
    var response =  await HttpUtil().post(
        '/logout',data: {}
    );
    if(response.code==200){
      return true;
    }
    return false;
  }





}
