import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../router/app_pages.dart';
import '../../utils/persisten_storage.dart';


class GuidePage extends StatefulWidget {
  const GuidePage({Key? key}) : super(key: key);

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {

  Timer? _t;
  bool? isLogin;

  @override
  void initState() {
    // Get.offAll(LoginPage(),curve:Curves.linear,transition:Transition.zoom);
    getToken();
    super.initState();
    _t = Timer(const Duration(milliseconds: 1), () {
    if(isLogin == false){
      Get.offAllNamed(AppRoutes.login,);
    }else{
      Get.offAllNamed(AppRoutes.bottomMain);
    }
    });
  }

  getToken()async{
    if(await PersistentStorage().getStorage('token')==null){
      isLogin = false;
    }else{
      isLogin = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

      ),
    );
  }
}
