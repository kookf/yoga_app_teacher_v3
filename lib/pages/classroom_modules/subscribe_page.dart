import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yoga_app/pages/classroom_modules/subscribe_model.dart';
import '../../common/colors.dart';
import '../../components/custom_footer.dart';
import '../../services/address.dart';
import '../../services/dio_manager.dart';

class SubscribePage extends StatefulWidget {

  final String title;

  final int courseTimeId;

  const SubscribePage(this.title,this.courseTimeId,{Key? key}) : super(key: key);

  @override
  State<SubscribePage> createState() => _SubscribePageState();

}

class _SubscribePageState extends State<SubscribePage> {

  int selectIndex = 1;

  String startDay = '';

  EasyRefreshController easyRefreshController = EasyRefreshController();

  List dataArr = [];

  int page = 1;

  requestDataWithSubscribeList({int page = 1})async{
    var params = {
      'method':'subscribe.list',
      'page':page,
      'course_time_id':widget.courseTimeId,
      'status':'',
      'sign':'',
      'sign_no':'',
    };
    var json = await DioManager().kkRequest(Address.hostAuth,bodyParams: params);
    SubscribeModel model = SubscribeModel.fromJson(json);
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
    setState(() {

    });
  }


  ///打卡
  requestDataWithSignCreate(var userId)async{

    var nowDateTime = DateTime.now();

    var timeFormat = DateFormat("yyyy-MM-dd HH:ss:mm");
    var timeStr = timeFormat.format(nowDateTime);

    var params = {
      'method':'sign.create',
      'course_time_id':widget.courseTimeId,
      'user_id':userId,
      'sign_in_at':timeStr,
    };
    var json = await DioManager().kkRequest(Address.hostAuth,bodyParams: params);
    if(json['code'] == 200){
      BotToast.showText(text: '打卡成功');
    }else{
      BotToast.showText(text: json['message']);
    }
    requestDataWithSubscribeList();

    setState(() {

    });
  }
  /// 取消打卡
  requestDataWithSignDelete(var userId)async{
    var params = {
      'method':'sign.delete',
      'course_time_id':widget.courseTimeId,
      'user_id':userId,
    };
    var json = await DioManager().kkRequest(Address.hostAuth,bodyParams: params);
    if(json['code'] == 200){
      BotToast.showText(text: '取消打卡成功');
    }else{
      BotToast.showText(text: json['message']);
    }
    requestDataWithSubscribeList();

    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestDataWithSubscribeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: _headerSliverBuilder,
        body: buildSliverBody(context),
      ),

    );
  }

  ///页面滚动头部处理
  List<Widget> _headerSliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget> [
      buildSliverAppBar(context)
    ];
  }
  ///导航部分渲染
  Widget buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      stretch: true,
      expandedHeight: 215,
      elevation: 0,
      // backgroundColor:AppColor.themeColor,
      snap: false,
      iconTheme: const IconThemeData(
          color: Colors.black
      ),
      flexibleSpace: FlexibleSpaceBar(
        title:  Text('', style: TextStyle(
          color: AppColor.themeTextColor,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),) ,
        centerTitle: true,
        background: buildAppBarBackground(context),
      ),
    );
  }

  Widget buildAppBarBackground(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Image.asset('images/ic_bg.png',width: Get.width,fit: BoxFit.cover,),
        ),
        // Image.asset('images/appbar_bg.png',fit: BoxFit.fitWidth,width: Get.width,),
        Align(

          child:Container(
            width: Get.width,
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top+25),
            // height: 200,
            // color: Colors.redAccent,
            // color: Colors.redAccent,
            child: Column(
              children: [
                Image.asset('images/login_log.png',width: 100,height: 100,),
                const SizedBox(height: 15,),
                Text(widget.title,style: TextStyle(color: AppColor.themeTextColor,fontSize: 21,
                    fontWeight: FontWeight.w700),)
              ],
            ),
          ),
        ),



        // Container(
        //   margin: EdgeInsets.only(top: 100),
        //   child: Center(
        //     child: Text('預約課堂',style: TextStyle(fontSize: 22,color: AppColor.themeTextColor,
        //         fontWeight: FontWeight.w700
        //     ),),
        //   ),
        // ),

      ],
    );
  }

  Widget buildSliverBody(BuildContext context){
    return Container(
      color: AppColor.bgColor,
      child: Column(
        children: [
          Container(
            height: 0.5,
            width: Get.width,
            color: Colors.black,
          ),
          Container(
            height: 60,
            color: AppColor.themeColor,
            padding: const EdgeInsets.only(left: 55,right: 55),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('學生',style: TextStyle(fontSize: 20,color: AppColor.themeTextColor,fontWeight: FontWeight.w600),),
                Text('狀態',style: TextStyle(fontSize: 20,color: AppColor.themeTextColor,fontWeight: FontWeight.w600),),
              ],
            ),
          ),
          Expanded(child: EasyRefresh.custom(
              emptyWidget:dataArr.isEmpty?const Center(child:Text('暫無信息')):null,
              header: MaterialHeader(),
              footer: MaterialFooter1(),
              controller: easyRefreshController,
              onRefresh: ()async{
                page = 1;
                requestDataWithSubscribeList(page: page);
                // requestDataWithCourseList(page: 1);
              },
              onLoad: ()async{
                page++;
                requestDataWithSubscribeList(page: page);
              },
              slivers: [
                SliverList(
                  delegate: _mySliverChildBuilderDelegate(),
                ),
              ])),
        ],
      ),
    );
  }

  SliverChildBuilderDelegate _mySliverChildBuilderDelegate() {
    return SliverChildBuilderDelegate(
          (BuildContext context, int index) {
        SubscribeList model = dataArr[index];

        return Container(
          // margin: const EdgeInsets.only(left: 30,right: 30,top: 0,bottom: 15),
          // height: 130,
          color: AppColor.bgColor,
          child: GestureDetector(
            onTap: (){

            },
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.black,
                        width: 0.3
                    )
                ),
                padding: const EdgeInsets.only(left: 10,right: 1),
                height: 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${model.name}',style: TextStyle(fontWeight: FontWeight.w700,
                            fontSize: 23,color: AppColor.themeTextColor),),
                        Text('預約日期：${model.createdAt}',style: TextStyle(fontWeight: FontWeight.w700,
                            fontSize: 16,color: AppColor.themeTextColor),),
                      ],
                    ),
                    model.signId==0?SizedBox(
                      width: 90,
                      // color: Colors.red,
                      child: Center(
                        child: MaterialButton(onPressed: () {
                          Get.defaultDialog(title: '提示',middleText: '是否要打卡',textCancel:'取消',textConfirm: '確定',onConfirm: (){
                            requestDataWithSignCreate(model.userId);
                            Get.back();
                          },onCancel: (){

                          });
                          },color: AppColor.themeColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20))
                          ),child: const Text('打卡',style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ):model.signId!>=1?SizedBox(
                     width: 100,
                     // color: Colors.red,
                     child: Center(
                       child: MaterialButton(onPressed: () {
                         Get.defaultDialog(title: '提示',middleText: '是否要取消打卡',textCancel:'取消',textConfirm: '確定',onConfirm: (){
                           requestDataWithSignDelete(model.userId);
                           Get.back();
                         },onCancel: (){

                         });
                       },color: AppColor.themeColor,
                         shape: const RoundedRectangleBorder(
                             borderRadius: BorderRadius.all(Radius.circular(20))
                         ),child: const Text('取消打卡',style: TextStyle(color: Colors.white),),
                       ),
                     ),
                   ):const SizedBox(),
                  ],
                )
            ),
          ),
        );
      },
      childCount: dataArr.length,
    );
  }

}
