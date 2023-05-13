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
  String endDay = '';

  EasyRefreshController easyRefreshController = EasyRefreshController();

  List dataArr = [];

  DateTime initDatetime = DateTime.now();


  requestDataWithCourseList()async{
    var params = {
      'method':'course.list',
      'page':page,
      // 'subscribe':'0',
      'start_day':startDay,
      'end_day':endDay,
      'is_teacher':'1',
    };
    var json = await DioManager().kkRequest(Address.hostAuth,bodyParams: params);
    ClassRoomModel model = ClassRoomModel.fromJson(json);
    // dataArr.clear();
    if(page == 1){
      easyRefreshController.resetLoadState();
      dataArr.clear();
      dataArr.addAll(model.data!.classroomlist!);
    }else{
      if(model.data!.classroomlist!.isNotEmpty){
        dataArr.addAll(model.data!.classroomlist!);
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
  bool initMethod = false;

  jumpToCalendar()async{
    var data = await Get.to(const ClassRoomCalendarPage());
    if(data!=null){
      initDatetime = DateTime.parse(data);
      startDay = data;
      endDay = data;
      initMethod = true;
      dataArr.clear();
      page = 1;
      requestDataWithCourseList();
    }
    update();
  }
  /// 全部课程点
  tapClickAllClass()async{
    startDay = '';
    requestDataWithCourseList();
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
    getInitWeek();
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

  /// 初始化获取下一周周一到周日
  getInitWeek(){
    var timeFormat = DateFormat("yyyy-MM-dd");
    // var timeStr = timeFormat.format(date);
    print('DateTime.wednesday===${DateTime(DateTime.now().
    year,DateTime.now().month
        ,DateTime.now().day).weekday}');
    if(DateTime(DateTime.now().year,DateTime.now().month
        ,DateTime.now().day).weekday==7){
      var now = DateTime.now();
      var newStartNow = now.add(const Duration(days: -6));
      var newEndNow = newStartNow.add(const Duration(days: 6));
      startDay = timeFormat.format(newStartNow);
      endDay = timeFormat.format(newEndNow);
      print('s =${startDay} e = ${endDay}');
    }if(DateTime(DateTime.now().year,DateTime.now().month
        ,DateTime.now().day).weekday==6){
      var now = DateTime.now();
      var newStartNow = now.add(Duration(days: -5));
      var newEndNow = newStartNow.add(Duration(days: 6));
      startDay = timeFormat.format(newStartNow);
      endDay = timeFormat.format(newEndNow);
      print('s =${startDay} e = ${endDay}');
    }if(DateTime(DateTime.now().year,DateTime.now().month
        ,DateTime.now().day).weekday==5){
      var now = DateTime.now();
      var newStartNow = now.add(Duration(days: -4));
      var newEndNow = newStartNow.add(Duration(days: 6));
      startDay = timeFormat.format(newStartNow);
      endDay = timeFormat.format(newEndNow);
      print('s =${startDay} e = ${endDay}');
    }if(DateTime(DateTime.now().year,DateTime.now().month
        ,DateTime.now().day).weekday==4){
      var now = DateTime.now();
      var newStartNow = now.add(Duration(days: -3));
      var newEndNow = newStartNow.add(Duration(days: 6));
      startDay = timeFormat.format(newStartNow);
      endDay = timeFormat.format(newEndNow);
      print('s =${startDay} e = ${endDay}');
    }if(DateTime(DateTime.now().year,DateTime.now().month
        ,DateTime.now().day).weekday==3){
      var now = DateTime.now();
      var newStartNow = now.add(Duration(days: -2));
      var newEndNow = newStartNow.add(Duration(days: 6));
      startDay = timeFormat.format(newStartNow);
      endDay = timeFormat.format(newEndNow);
      print('s =${startDay} e = ${endDay}');
      print(now.add(Duration(days: 5)));
    }if(DateTime(DateTime.now().year,DateTime.now().month
        ,DateTime.now().day).weekday==2){
      var now = DateTime.now();
      var newStartNow = now.add(Duration(days: -1));
      var newEndNow = newStartNow.add(Duration(days: 6));
      startDay = timeFormat.format(newStartNow);
      endDay = timeFormat.format(newEndNow);
      print('s =${startDay} e = ${endDay}');
    }if(DateTime(DateTime.now().year,DateTime.now().month
        ,DateTime.now().day).weekday==1){
      var now = DateTime.now();
      var newStartNow = now.add(Duration(days: 0));
      var newEndNow = newStartNow.add(Duration(days: 6));
      startDay = timeFormat.format(newStartNow);
      endDay = timeFormat.format(newEndNow);
      print('s =${startDay} e = ${endDay}');
    }
  }
  ///点击下一周

  nextWeek(){
    if(initMethod){
      getInitWeek();
      initMethod = false;
    }
    page = 1;
    var timeFormat = DateFormat("yyyy-MM-dd");
    DateTime startDateTime = DateTime.parse(startDay);
    DateTime endDateTime = DateTime.parse(endDay);
    var s = startDateTime.add(Duration(days: 7));
    var e = endDateTime.add(Duration(days: 7));
    startDay = timeFormat.format(s);
    endDay = timeFormat.format(e);
    requestDataWithCourseList();
  }
  ///点击上一周
  backWeek(){
    if(initMethod){
      getInitWeek();
      initMethod = false;
    }
    page = 1;

    var timeFormat = DateFormat("yyyy-MM-dd");
    DateTime startDateTime = DateTime.parse(startDay);
    DateTime endDateTime = DateTime.parse(endDay);
    var s = startDateTime.add(Duration(days: -7));
    var e = endDateTime.add(Duration(days: -7));
    startDay = timeFormat.format(s);
    endDay = timeFormat.format(e);
    requestDataWithCourseList();
  }

}