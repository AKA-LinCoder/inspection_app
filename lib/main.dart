import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'common/languages/languages.dart';
import 'common/routes/routes.dart';
import 'common/store/store.dart';
import 'common/themes/themes.dart';
import 'global.dart';

final GlobalKey<NavigatorState> appKey = GlobalKey<NavigatorState>();

void main() async{
  await Global.init();
  runApp(const MyApp());
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
            // home:  MyHomePage(title: "title".tr),
            navigatorObservers: [AppPages.observer],
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
            navigatorKey: appKey,
          );
        },
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Icon(Icons.access_alarm,size: 100,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
