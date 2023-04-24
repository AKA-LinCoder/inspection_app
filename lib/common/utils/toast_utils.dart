import 'package:oktoast/oktoast.dart';

///Toast工具类
class Toast{
  static void show(String msg,{int duration = 2000}){
    showToast(
      msg,
      duration: Duration(milliseconds: duration),
      dismissOtherToast: true,
    );
  }

  static void showRight(String msg,{int duration = 2000}){
    showToast(
      msg,
      duration: Duration(milliseconds: duration),
    );
  }

  static void showBySelf(String msg,{int duration = 2000}){
    showToast(
      msg,
      duration: Duration.zero,
      // duration: Duration(milliseconds: duration),
      dismissOtherToast: true,
    );
  }



  static void cancelToast(){
    dismissAllToast();
  }


}
