import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:yoga_app/pages/bottom_nav_moudules/guide_page.dart';
import 'package:yoga_app/router/app_routes.dart';
import 'common/app_theme.dart';
import 'package:get/get.dart';

void main() {

  setCustomErrorPage();

  runApp(const MyApp());
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
      title: 'yoga_teacher',
      // theme:appThemeData,
      theme: appThemeData,
      builder: BotToastInit(),
      getPages: AppPages.routes,
      home: const GuidePage(),
      navigatorObservers: [BotToastNavigatorObserver()],
      // home:LoginView(),
    );
  }
}

