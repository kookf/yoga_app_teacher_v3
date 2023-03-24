import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../../../common/colors.dart';
import '../../../components/custom_footer.dart';
import '../../../services/address.dart';
import '../../../services/dio_manager.dart';
import 'package:get/get.dart';

import '../classroom_modules/classroom_model.dart';

class MySalaryPage extends StatefulWidget {
  const MySalaryPage({Key? key}) : super(key: key);

  @override
  State<MySalaryPage> createState() => _MySalaryPageState();
}

class _MySalaryPageState extends State<MySalaryPage> {
  int selectIndex = 1;

  String startDay = '';

  EasyRefreshController easyRefreshController = EasyRefreshController();

  List dataArr = [];

  requestDataWithCourseList({String? startDay,int page = 1})async{
    var params = {
      'method':'course.list',
      'page':page,
      'subscribe':'1',
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
    setState(() {

    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestDataWithCourseList();
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
          child: Container(
            // height: 140,
            // alignment: Alignment.topCenter,
            // color: Colors.red,
            child: Image.asset('images/ic_bg.png',width: Get.width,fit: BoxFit.cover,),
          ),
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
                Image.asset('images/login_log.png',width: 130,height: 130,),
                const SizedBox(height: 3,),
                Text('我的工資',style: TextStyle(color: AppColor.themeTextColor,fontSize: 21,
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
          // Container(
          //   height: 60,
          //   color: Colors.white,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       GestureDetector(
          //         onTap: (){
          //           setState(() {
          //             selectIndex =1;
          //           });
          //         },
          //         child: Container(
          //           alignment: Alignment.center,
          //           height: 45,
          //           width: 80,
          //           decoration: BoxDecoration(
          //               color: selectIndex ==1? AppColor.themeColor:Colors.transparent,
          //               borderRadius: const BorderRadius.all(Radius.circular(10))
          //           ),
          //           child:Text('預約',style: TextStyle(fontSize: 22,color:selectIndex==1?Colors.white:AppColor.themeTextColor,fontWeight: FontWeight.w700),),
          //         ),
          //       ),
          //       GestureDetector(
          //         onTap: (){
          //           setState(() {
          //             selectIndex =2;
          //           });
          //         },
          //         child: Container(
          //           alignment: Alignment.center,
          //           height: 45,
          //           width: 80,
          //           decoration: BoxDecoration(
          //               color: selectIndex ==2? AppColor.themeColor:Colors.transparent,
          //               borderRadius: const BorderRadius.all(Radius.circular(10))
          //           ),
          //           child:Text('上課',style: TextStyle(fontSize: 22,color:selectIndex==2?Colors.white:AppColor.themeTextColor,fontWeight: FontWeight.w700),),
          //         ),
          //       ),
          //       GestureDetector(
          //         onTap: (){
          //           setState(() {
          //             selectIndex =3;
          //           });
          //         },
          //         child: Container(
          //           alignment: Alignment.center,
          //           height: 45,
          //           width: 80,
          //           decoration: BoxDecoration(
          //               color: selectIndex ==3? AppColor.themeColor:Colors.transparent,
          //               borderRadius: const BorderRadius.all(Radius.circular(10))
          //           ),
          //           child:Text('缺席',style: TextStyle(fontSize: 22,color:selectIndex==3?Colors.white:AppColor.themeTextColor,fontWeight: FontWeight.w700),),
          //         ),
          //       ),
          //       GestureDetector(
          //         onTap: (){
          //           setState(() {
          //             selectIndex =4;
          //           });
          //         },
          //         child: Container(
          //           alignment: Alignment.center,
          //           height: 45,
          //           width: 80,
          //           decoration: BoxDecoration(
          //               color: selectIndex ==4? AppColor.themeColor:Colors.transparent,
          //               borderRadius: const BorderRadius.all(Radius.circular(10))
          //           ),
          //           child:Text('取消',style: TextStyle(fontSize: 22,color:selectIndex==4?Colors.white:AppColor.themeTextColor,fontWeight: FontWeight.w700),),
          //         ),
          //       ),
          //       Image.asset('images/ic_classroom_right.png'),
          //
          //     ],
          //   ),
          // ),
          Container(
            height: 60,
            color: AppColor.themeColor,
            padding: const EdgeInsets.only(left: 55,right: 55),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('課程名稱',style: TextStyle(fontSize: 20,color: AppColor.themeTextColor,fontWeight: FontWeight.w600),),
                Text('工資',style: TextStyle(fontSize: 20,color: AppColor.themeTextColor,fontWeight: FontWeight.w600),),
              ],
            ),
          ),
          Expanded(child:   EasyRefresh.custom(
              emptyWidget:dataArr.isEmpty?const Center(child:Text('暫無信息')):null,
              header: MaterialHeader(),
              footer: MaterialFooter1(),
              controller: easyRefreshController,
              onRefresh: ()async{
                requestDataWithCourseList(page: 1);
              },
              onLoad: ()async{
                int page = 1;
                page++;
                requestDataWithCourseList(page: page);
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
        ClassRoomList model = dataArr[index];
        return Container(
          // margin: const EdgeInsets.only(left: 30,right: 30,top: 0,bottom: 15),
          height: 130,
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
                padding: const EdgeInsets.only(left: 15,right: 5),
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
                        Text('開始時間：${model.startDay} ${model.startTime}',style: TextStyle(fontWeight: FontWeight.w700,
                            fontSize: 16,color: AppColor.themeTextColor),),
                        SizedBox(
                          width: Get.width -150,
                          child: Text('地址：${model.address}',style: TextStyle(fontWeight: FontWeight.w700,
                              fontSize: 16,color: AppColor.themeTextColor),maxLines: 1,overflow: TextOverflow.ellipsis,),
                        ),

                      ],
                    ),

                    model.subscribeId==0?Container(
                      height: 45,
                      width: 90,
                      padding: const EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColor.themeTextColor,
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                      ),
                      child:  const Text('未預約',style: TextStyle(color: Colors.white,fontSize: 13),),
                    ):model.subscribeId!>=1&&model.subscribeStatus==0?Container(
                        height: 45,
                        width: 90,
                        padding: const EdgeInsets.all(5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColor.themeTextColor,
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                        ),
                        child:  Text('预约待审核',style: TextStyle(color: Colors.white,fontSize: 13),)):model.subscribeStatus==1&&
                        model.subscribeId!>=1?Container(
                        height: 45,
                        width: 90,
                        padding: const EdgeInsets.all(5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColor.themeTextColor,
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                        ),
                        child:  Text('已預約',style: TextStyle(color: Colors.white,fontSize: 13),)):SizedBox(),

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
