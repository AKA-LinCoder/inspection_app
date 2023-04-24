import 'package:echo_utils/echo_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_app/common/routes/router_name.dart';
import 'package:inspection_app/common/store/store.dart';
import 'package:inspection_app/common/themes/colors.dart';
import 'package:inspection_app/common/themes/texts.dart';

import '../../common/utils/permission_util.dart';
import 'index.dart';

/// FileName view
///
/// @Author LinGuanYu
/// @Date 2023/3/20 18:24
///
/// @Description TODO

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with WidgetsBindingObserver {
  final controller = Get.find<SignInController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ///WidgetsBindingObserver可以监听当前应用是否在前台显示
    WidgetsBinding.instance.addObserver(this);

    ///检查权限
    controller.checkPermissionFunction();
  }
  int sex = 1;

  @override
  void dispose() {
    //销毁观察者
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);

    ///检测app从后台到前台的状态，再检查权限
    if (state == AppLifecycleState.resumed &&
        PermissionUtil(context).isGoAppSetting) {
      ///检查权限
      controller.checkPermissionFunction();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                // color: AppColors.primary,
                width: double.infinity,
                height: 180.h,
                child: Image.asset("assets/login.png"),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Login".tr,
                style: Styles.headLineStyle,
              ),
              SizedBox(
                height: 30.h,
              ),
              TextField(
                controller: controller.accountController,
                decoration: InputDecoration(
                  ///默认边框
                  enabledBorder: UnderlineInputBorder(
                    /*边角*/
                    // borderRadius: BorderRadius.all(
                    //   Radius.circular(30), //边角为30
                    // ),
                    borderSide: BorderSide(
                      color: Colors.grey, //边线颜色为黄色
                      width: 1.w, //边线宽度为2
                    ),
                  ),
                  iconColor: Colors.grey,
                  prefixIcon: const Icon(
                    Icons.alternate_email_outlined,
                    color: Colors.grey,
                  ),

                  hintText: "email".tr,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              TextField(
                controller: controller.passController,
                obscureText: !controller.passwordVisible,
                decoration: InputDecoration(
                  ///默认边框
                  enabledBorder: UnderlineInputBorder(
                    /*边角*/
                    // borderRadius: BorderRadius.all(
                    //   Radius.circular(30), //边角为30
                    // ),
                    borderSide: BorderSide(
                      color: Colors.grey, //边线颜色为黄色
                      width: 1.w, //边线宽度为2
                    ),
                  ),
                  iconColor: Colors.grey,
                  hintText: "password".tr,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Colors.grey,
                  ),
                  suffixIcon: IconButton(
                      onPressed: () {
                        controller.passwordVisible =
                            !controller.passwordVisible;
                        setState(() {});
                      },
                      icon: Icon(
                        controller.passwordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.grey,
                      )),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${"forgetPassword".tr}?',
                    style: Styles.headLineStyle4
                        .copyWith(color: AppColors.primary),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              EchoButton(
                buttonName: "Login".tr,
                onPressed: () async{
                  if(controller.states.isAgree.value){
                    await UserStore.to.setProtocol(true);
                    await controller.toLogin();
                  }else{
                    EasyLoading.showError("请同意协议");
                    echoLog("请同意协议");
                  }
                },
                height: 40.h,
                buttonColor: AppColors.primary,
                buttonTextStyle:
                    Styles.headLineStyle3.copyWith(color: Colors.white),
              ),
              Expanded(child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${"toRegister".tr}?',
                    style: Styles.headLineStyle4.copyWith(color: Colors.grey),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "Register".tr,
                    style: Styles.headLineStyle4
                        .copyWith(color: AppColors.primary),
                  ),
                ],
              ),
              SizedBox(height: 5.h,),

              Row(
               children: [
                 Obx(() => IconButton(onPressed: (){
                   controller.states.isAgree.value = !controller.states.isAgree.value;
                 }, icon: controller.states.isAgree.value?const Icon(Icons.check_circle_outline,color: AppColors.primary,):const Icon(Icons.circle_outlined,color: Colors.grey,)),),
                 Expanded(
                   child: RichText(text: TextSpan(
                       text: "勾选即代表同意",
                       style: Styles.headLineStyle4,
                       children: [
                         TextSpan(
                             text: "《用户注册协议》",
                             style: Styles.headLineStyle4.copyWith(color: AppColors.primary)
                         ),
                         TextSpan(
                           text: "与",
                           style: Styles.headLineStyle4,
                         ),
                         TextSpan(
                             text: "《隐私协议》",
                             style: Styles.headLineStyle4.copyWith(color: AppColors.primary)
                         )
                       ]
                   )),
                 )
               ],
             ),
            ],
          ),
        ),
      ),
    );
  }
}
