import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../common/eventbus.dart';
import '../../services/address.dart';
import '../../services/dio_manager.dart';
import 'classroom_calendar_page.dart';
import 'classroom_model.dart';

class ClassroomController extends GetxController{

  ///滚动监听设置
  ScrollController scrollController = ScrollController();
  ///头部背景布局 true滚动一定的高度 false 滚动高度为0
  bool headerWhite = false;

  /// 默认选第一个
  ///
  int selectionTab = 1;

  var page = 1;

  String startDay = '';

  EasyRefreshController easyRefreshController = EasyRefreshController();

  List dataArr = [];

  DateTime initDatetime = DateTime.now();


  requestDataWithCourseList()async{
    var params = {
      'method':'course.list',
      'page':page,
      'subscribe':'0',
      'start_day':startDay,
      'is_teacher':'1',
    };
    var json = await DioManager().kkRequest(Address.hostAuth,bodyParams: params);
    ClassRoomModel model = ClassRoomModel.fromJson(json);
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
  onRefresh()async{
     page = 1 ;
    requestDataWithCourseList();
  }
  onLoad()async{
    page++;
    requestDataWithCourseList();
  }

  jumpToCalendar()async{
    var data = await Get.to(const ClassRoomCalendarPage());
    if(data!=null){
      initDatetime = DateTime.parse(data);
      dataArr.clear();
      startDay  = data;
      page = 1;
      requestDataWithCourseList();
    }
    update();
  }


  var eventBusFn;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // var nowDateTime = DateTime.now();
    // var timeFormat = DateFormat("yyyy-MM-dd");
    // var timeStr = timeFormat.format(nowDateTime);
    // startDay = timeStr;
    requestDataWithCourseList();

    eventBusFn = eventBus.on<EventFn>().listen((event) {
      //  event为 event.obj 即为 eventBus.dart 文件中定义的 EventFn 类中监听的数据

      if(event.obj == 'refresh'){
        // startDay  = startDay;
        // requestDataWithCourseList(startDay:startDay);
      }
      print('event.obj hh ===== ${event.obj}');
    });
  }

}