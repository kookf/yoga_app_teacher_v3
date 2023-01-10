import 'dart:convert';
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import '../router/app_pages.dart';
import '../utils/persisten_storage.dart';
import 'address.dart';
import 'dart:io';
import 'package:get/route_manager.dart';
class DioManager{


  static final DioManager _instance = DioManager._internal();

  factory DioManager() => _instance;

  DioManager._internal() {
    init();
  }

  late Dio dio;

  late BaseOptions baseOptions;

  init() {
    baseOptions = BaseOptions(
      baseUrl: Address.homeHost,
      connectTimeout: 5000,
    );
    dio = Dio(baseOptions);
  }

  Future kkRequest(
    String url, {
    bool isShowLoad = false,
    String method = 'post',
    Map<String, dynamic>? params,
    var bodyParams,
    String contentType = Headers.formUrlEncodedContentType,
    Map<String, dynamic>? header,
  }) async {
    if (await PersistentStorage().hasKey('urlStr')) {
      baseOptions.baseUrl = await PersistentStorage().getStorage('urlStr');
      print('baseOptions.baseUrl == ${baseOptions.baseUrl}');
    }
    if (isShowLoad == true) {
      BotToast.showLoading(clickClose: true);
    }

    Map<String, dynamic> baseHeader = {
      'access_token': await PersistentStorage().getStorage('acctoken'),
      'user_id': await PersistentStorage().getStorage('uid'),
      'company_id': await PersistentStorage().getStorage('companyId'),
      'team_id': await PersistentStorage().getStorage('team_id'),
    };

    print('baseHeader ================ ${baseHeader}');
    Options options =
        Options(method: method, contentType: contentType, headers: baseHeader);

    print(
        '请求地址 ==== ${baseOptions.baseUrl}${url} 请求参数===== ${params} 请求body =====${bodyParams}');

    try {
      var json = await dio.request(url,
          options: options, queryParameters: params, data: bodyParams);

      var s = jsonEncode(json.data);
      print('请求结果===== result.data ======= ${s}');

      if(json.data['errcode']==403){
        Get.offNamed(AppRoutes.login);
      }

      if (json.data['errmsg'] == 'no') {
        BotToast.closeAllLoading();
        BotToast.showText(text: '${json.data['message']}');
      }
      BotToast.closeAllLoading();
      return json.data;
    } on DioError catch (error) {
      print('请求结果===== ${error}');

      BotToast.closeAllLoading();

      BotToast.showText(text: error.message);
    }
  }
}
