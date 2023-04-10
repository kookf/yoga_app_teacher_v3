import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yoga_app/pages/bottom_nav_moudules/guide_page.dart';
import 'package:yoga_app/router/app_pages.dart';
import 'package:yoga_app/router/app_routes.dart';
import 'package:yoga_app/utils/persisten_storage.dart';
import 'common/app_theme.dart';
import 'package:get/get.dart';

void main() {

  setCustomErrorPage();
  requestPermission();

  getToken();

  runApp(const MyApp());
}

bool? isLogin;


getToken()async{
  print('token ======= ${await PersistentStorage().getStorage('token')}');
  if(await PersistentStorage().getStorage('token')==null){
    isLogin = false;
    // Get.offAllNamed(AppRoutes.login,);
  }else{
    isLogin = true;
    // Get.offAllNamed(AppRoutes.login,);
  }
  print('islogin === ${isLogin}');
}



void setCustomErrorPage() {

  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    return Container(
      color: Colors.white,
      child: const CupertinoActivityIndicator(),
    );
  };
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // 1 设置localizationsDelegates
        localizationsDelegates: const [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        // 2 设置 supportedLocales 表示支持的国际化语言
        supportedLocales: const [
          Locale.fromSubtags(languageCode: 'en'),
          Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'), //
        ],
      debugShowCheckedModeBanner: false,
      title: 'MeMoYoga導師版',
      // theme:appThemeData,
      theme: appThemeData,
      builder: BotToastInit(),
      getPages: AppPages.routes,
      // initialRoute:isLogin==false?AppRoutes.login:AppRoutes.bottomMain,
      home: const GuidePage(),

      navigatorObservers: [BotToastNavigatorObserver()],
      // home:LoginView(),
    );
  }
}
//申请权限
requestPermission() async {
  //多个权限申请
  Map<Permission, PermissionStatus> statuses = await [
    Permission.camera,
    // Permission.location,
    Permission.storage,
    Permission.mediaLibrary,
    Permission.accessNotificationPolicy
    // Permission.microphone,
  ].request();
  debugPrint('权限状态$statuses');
  // if (!status.isGranted) {
  //   openAppSettings();
  // }
}


