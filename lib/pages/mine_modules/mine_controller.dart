import 'dart:async';
import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:yoga_app/pages/mine_modules/user_model.dart';

import '../../common/eventbus.dart';
import '../../router/app_pages.dart';
import '../../services/address.dart';
import '../../services/dio_manager.dart';
import '../../utils/persisten_storage.dart';

class MineController extends GetxController{

  List dataArr = [];

  UserModel? userModel;

  StreamSubscription? eventBusFn;
  /// 獲取個人資料
  void requestDataWithUserinfo()async{

    var params = {
      'method':'auth.profile',
    };

    var json = await DioManager().kkRequest(Address.hostAuth,bodyParams: params);


    userModel = UserModel.fromJson(json);

    await PersistentStorage().setStorage('name', userModel!.data!.name);
    await PersistentStorage().setStorage('id', userModel!.data!.id);

    update();
  }
  /// 退出登录
  void requestDataWithLoginOut()async{

    var json = await DioManager().kkRequest(Address.loginOut,isShowLoad: true);
    if(json['code'] == 200){
      await PersistentStorage().removeStorage('token');
      // Get.off(StudentLoginView());
      Get.offNamed(AppRoutes.login);
    }
    BotToast.showText(text: json['message']);
    update();
  }
  /// 刪除賬號
  requestDataWithDelete()async{
    var params = {
      'method': 'auth.delete',
    };
    var json = await DioManager().kkRequest(Address.hostAuth,isShowLoad: true,
        bodyParams: params);
    Get.offNamed(AppRoutes.login);
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    eventBusFn = eventBus.on<EventFn>().listen((event) {
      //  event为 event.obj 即为 eventBus.dart 文件中定义的 EventFn 类中监听的数据

      if(event.obj == 'headerRefresh'){
        requestDataWithUserinfo();
      }
      print('event.obj hh ===== ${event.obj}');
    });

    requestDataWithUserinfo();
  }

}