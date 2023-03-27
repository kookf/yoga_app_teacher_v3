import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import '../../services/address.dart';
import '../../services/dio_manager.dart';
import 'message_model.dart';

class MessagePageController extends GetxController{

  EasyRefreshController easyRefreshController = EasyRefreshController();


  List dataArr = [];

  int page = 1;

  onRefresh()async{
    page = 1 ;
    requestDataWithNoticeList(page);
  }
  onLoad()async{
    page++;
    print(page);
    requestDataWithNoticeList(page);
  }



  requestDataWithNoticeList(int page )async{
    var params = {
      'method':'notice.list',
      'page':page,
    };
    var json = await DioManager().kkRequest(Address.hostAuth,bodyParams:params);
    MessageModel model = MessageModel.fromJson(json);
    // dataArr.clear();
    if(page == 1){
      easyRefreshController.resetLoadState();
      dataArr.clear();
      dataArr.addAll(model.data!.list!);
    }else{
      if(model.data!.list!.isNotEmpty){
        dataArr.addAll(model.data!.list!);
      }else{
        easyRefreshController.finishLoad(noMore: true);
        // BotToast.showText(text: '暂无更多');
      }
    }
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    requestDataWithNoticeList(1);
  }

}