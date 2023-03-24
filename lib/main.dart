import 'dart:async';

import 'package:echo_utils/echo_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_app/common/themes/texts.dart';
import 'package:inspection_app/pages/setting/controller.dart';

import 'common/languages/languages.dart';
import 'common/routes/routes.dart';
import 'common/store/store.dart';
import 'common/themes/themes.dart';
import 'global.dart';


final GlobalKey<NavigatorState> appKey = GlobalKey<NavigatorState>();

void main() async{
  await Global.init();
  runZonedGuarded(()async{
    WidgetsFlutterBinding.ensureInitialized();
    FlutterError.onError = (FlutterErrorDetails details) {
      // 异常上报 转发容易遗漏异常消息
      echoLog("捕获到意想不到的错误",error: details.exception,stackTrace: details.stack);
      Zone.current.handleUncaughtError(details.exception, details.stack??StackTrace.current);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      echoLog("全局异常",error: error,stackTrace: stack);
      return true;
    };
    //自定义报错页面
    ErrorWidget.builder = (errorDetail){
      debugPrint(errorDetail.toString());
      return Center(child: Text(errorDetail.toString(),style: Styles.headLineStyle3.copyWith(color: Colors.black54),),);
    };
    runApp(const MyApp());

  } , (error, stack) {
    echoLog("全局异常",error: error,stackTrace: stack);
  });

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      ///一键变灰功能
      colorFilter: const ColorFilter.mode(Colors.transparent, BlendMode.color),
      child: ScreenUtilInit(
        //设计尺寸
        designSize: const Size(360, 690),
        //防止不同设备打包出来字体不一样
        minTextAdapt: true,
        builder: (BuildContext context, Widget? child) {
          return  GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            translations: TranslationService(),
            fallbackLocale: TranslationService.fallbackLocale,
            locale: ConfigStore.to.locale,
            ///国际化语言环境
            localizationsDelegates: const [
              ///初始化默认的 Material 组件本地化
              GlobalMaterialLocalizations.delegate,
              ///初始化默认的 通用 Widget 组件本地化
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
              // ///自定义的语言配制文件代理 初始化
              // MyLocationsLanguageDelegates.delegate,
              ///支持使用 CupertinoAlertDialog 的代理
              // FallbackCupertinoLocalisationsDelegate.delegate,
            ],
            ///定义当前应用程序所支持的语言环境
            supportedLocales: ConfigStore.to.languages,
            theme: Themes.lightTheme,
            darkTheme: Themes.darkTheme,
            navigatorObservers: [AppPages.observer],
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
            navigatorKey: appKey,
            builder: (context,child){
              var controller = Get.put(SettingController());
              return GestureDetector(
                onTap: ()=>hideKeyboard(context),
                child: Obx(() => MediaQuery(
                  ///可以在这里全局控制字体大小
                  data: MediaQuery.of(context).copyWith(textScaleFactor: controller.states.fontSize.value),
                  child: child??Container(),
                )),
              );
            },
          );
        },
      ),
    );
  }
  //全局隐藏键盘
  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}


