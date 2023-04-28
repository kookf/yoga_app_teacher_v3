import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:yoga_app/pages/mine_modules/class_record_module/class_record_model.dart';
import '../../../common/colors.dart';
import '../../../components/custom_footer.dart';
import '../../../services/address.dart';
import '../../../services/dio_manager.dart';
import 'package:get/get.dart';
import '../../classroom_modules/classroom_calendar_page.dart';
class ClassRecordPage extends StatefulWidget {
  const ClassRecordPage({Key? key}) : super(key: key);

  @override
  State<ClassRecordPage> createState() => _ClassRecordPageState();
}

class _ClassRecordPageState extends State<ClassRecordPage> {

  int selectIndex = 1;


  EasyRefreshController easyRefreshController = EasyRefreshController();

  List dataArr = [];

  int page = 1;

  /// 获取学生上课记录列表
  /*
  *
  * 预约 status=0,1  预约 0,1 取消 2,3
    上课 sign = 1,  0缺席
  * */

  var status = '0,1';
  var sign = '';
  String startDay = '';


  requestDataWithSignList()async{

    var params = {
      'method':'subscribe.list',
      'page':page,
      'course_time_id':'',
      'status':status,
      'sign':sign,
      'start_day':startDay
    };

    var json = await DioManager().kkRequest(Address.hostAuth,bodyParams: params);
    SignRecordModel model = SignRecordModel.fromJson(json);
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
    requestDataWithSignList();
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
      // actions: [
        // TextButton(onPressed: (){
        //    status = '';
        //    sign = '';
        //    requestDataWithSignList();
        // }, child:Text('顯示全部',style: TextStyle(color: AppColor.themeColor),))
      // ],
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
                const SizedBox(height: 3,),
                Text('學生上課記錄',style: TextStyle(color: AppColor.themeTextColor,fontSize: 21,
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
            color: Colors.white,
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    status = '0,1';
                    sign = '';
                    requestDataWithSignList();
                    setState(() {
                      selectIndex =1;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: 70,
                    decoration: BoxDecoration(
                        color: selectIndex ==1? AppColor.themeColor:Colors.transparent,
                        borderRadius: const BorderRadius.all(Radius.circular(10))
                    ),
                    child:Text('預約',style: TextStyle(fontSize: 22,
                        color:selectIndex==1?Colors.white:AppColor.themeTextColor,
                        fontWeight: FontWeight.w700),),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    status = '';
                    sign = '1';

                    requestDataWithSignList();
                    setState(() {
                      selectIndex =2;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: 70,
                    decoration: BoxDecoration(
                        color: selectIndex ==2? AppColor.themeColor:Colors.transparent,
                        borderRadius: const BorderRadius.all(Radius.circular(10))
                    ),
                    child:Text('上課',style: TextStyle(fontSize: 22,color:selectIndex==2?
                    Colors.white:AppColor.themeTextColor,fontWeight: FontWeight.w700),),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    status = '';
                    sign = '0';
                    requestDataWithSignList();
                    setState(() {
                      selectIndex =3;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: 70,
                    decoration: BoxDecoration(
                        color: selectIndex ==3? AppColor.themeColor:Colors.transparent,
                        borderRadius: const BorderRadius.all(Radius.circular(10))
                    ),
                    child:Text('缺席',style: TextStyle(fontSize: 22,color:selectIndex==3?
                    Colors.white:AppColor.themeTextColor,fontWeight: FontWeight.w700),),
                  ),
                ),
                GestureDetector(
                  onTap: (){

                    status = '2,3';
                    sign = '';
                    requestDataWithSignList();
                    setState(() {
                      selectIndex =4;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: 70,
                    decoration: BoxDecoration(
                        color: selectIndex ==4? AppColor.themeColor:Colors.transparent,
                        borderRadius: const BorderRadius.all(Radius.circular(10))
                    ),
                    child:Text('取消',style: TextStyle(fontSize: 22,color:selectIndex==4?
                    Colors.white:AppColor.themeTextColor,fontWeight: FontWeight.w700),),
                  ),
                ),
                GestureDetector(
                  onTap: ()async{
                    var data = await Get.to(const ClassRoomCalendarPage());
                    if(data!= null){
                      startDay = data;
                      requestDataWithSignList();
                    }
                  },
                  child:Image.asset('images/ic_classroom_right.png',width: 35,height: 35,),
                )
              ],
            ),
          ),
          Container(
            height: 60,
            color: AppColor.themeColor,
            padding: const EdgeInsets.only(left: 55,right: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('課程名稱',style: TextStyle(fontSize: 20,
                    color: AppColor.themeTextColor,fontWeight: FontWeight.w600),),
                Text('狀態',style: TextStyle(fontSize: 20,
                    color: AppColor.themeTextColor,fontWeight: FontWeight.w600),),
              ],
            ),
          ),
          Expanded(child:   EasyRefresh.custom(
              emptyWidget:dataArr.isEmpty?const Center(child:Text('暫無信息')):null,
              header: MaterialHeader(),
              footer: MaterialFooter1(),
              controller: easyRefreshController,
              onRefresh: ()async{
                page = 1;
                requestDataWithSignList();
              },
              onLoad: ()async{
                page++;
                requestDataWithSignList();
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
            SignRecordList model = dataArr[index];
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
                padding: const EdgeInsets.only(left: 15,right: 5),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${model.courseName}',style: TextStyle(fontWeight: FontWeight.w700,
                            fontSize: 18,color: AppColor.themeTextColor),),
                        Text('${model.name}',style: TextStyle(fontWeight: FontWeight.w700,
                            fontSize: 18,color: AppColor.themeTextColor),),
                        const SizedBox(height: 5,),
                        selectIndex ==1||selectIndex==3?Text('預約時間:${model.createdAt}',
                         style: TextStyle(fontWeight: FontWeight.w700,
                            fontSize: 18,color: AppColor.themeTextColor),):selectIndex==2?
                       Text('簽到時間:${model.signTime}',style: TextStyle(fontWeight: FontWeight.w700,
                           fontSize: 18,color: AppColor.themeTextColor),):
                        Text('取消時間:${model.cancelTime}',style: TextStyle(fontWeight: FontWeight.w700,
                            fontSize: 18,color: AppColor.themeTextColor),),

                        // Text('開始時間：${model.startDay} ${model.startTime}',style: TextStyle(fontWeight: FontWeight.w700,
                        //     fontSize: 16,color: AppColor.themeTextColor),),
                        // SizedBox(
                        //   width: Get.width -150,
                        //   child: Text('地址：${model.address}',style: TextStyle(fontWeight: FontWeight.w700,
                        //       fontSize: 16,color: AppColor.themeTextColor),maxLines: 1,overflow: TextOverflow.ellipsis,),
                        // ),

                      ],
                    ),
                    Container(
                      color: Colors.white,
                      child: Center(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColor.themeColor,
                            borderRadius: const BorderRadius.all(Radius.circular(25))
                          ),
                          height: 35,
                          width: 80,
                          child:  Text(selectIndex==1?'已預約':selectIndex==2?'已上課'
                              :selectIndex==3?'缺席':'已取消',style: const TextStyle(color: Colors.white),),
                        ),
                      ),
                    )
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
