import 'package:get/get.dart';

import '../../services/address.dart';
import '../../services/dio_manager.dart';
import 'home_index_model.dart';

class HomeController extends GetxController{


  /// home 數據
  HomeIndexModel? homeIndexModel;
  requestDataWithHomeIndex()async{
    var params = {
      'method':'home.index',
    };
    var json = await DioManager().kkRequest(Address.host,bodyParams:params);

    HomeIndexModel model = HomeIndexModel.fromJson(json);

    homeIndexModel = model;

    update();
  }


  @override
  void onInit() {
    super.onInit();
    requestDataWithHomeIndex();
  }


}