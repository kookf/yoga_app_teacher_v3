import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../services/address.dart';
import '../../services/dio_manager.dart';

class LoginController extends GetxController{

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  /// 登录请求
  Future requestDataWithLogin()async{

    var params = {
      'method':'auth.login',
      'email':emailTextEditingController.text,
      'password':passwordTextEditingController.text,
      'is_teacher':'1',
    };

    var json = await DioManager().kkRequest(Address.host,bodyParams: params);

    return json;

  }
}
