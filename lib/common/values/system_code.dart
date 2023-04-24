//统一数据返回格式
class LinResponse{
  int code;
  dynamic data;
  String message;
  LinResponse({required this.code,required this.data,required this.message});
}

class SystemCode{
  static const int ok = 200;
  static const int notFound = 404;
  static const int pwdError = 501;
  static const int error = 500;
  static const int crash = 999;
  static const int noData = 502;
}


