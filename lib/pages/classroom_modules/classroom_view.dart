import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:yoga_app/pages/classroom_modules/subscribe_page.dart';
import '../../common/app_theme.dart';
import '../../common/colors.dart';
import '../../components/custom_footer.dart';
import 'classroom_controller.dart';
import 'classroom_model.dart';

class ClassroomView extends GetView{

  @override
  final ClassroomController controller = Get.put(ClassroomController());

  ClassroomView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      body: GetBuilder<ClassroomController>(builder: (_){
        return EasyRefresh.custom(
          header: MaterialHeader(),
          footer: MaterialFooter1(),
          controller: controller.easyRefreshController,
          onRefresh: ()=>controller.onRefresh(),
          onLoad: ()=>controller.onLoad(),
          // emptyWidget:controller.dataArr.isEmpty?const Center(child:Text('暫無課程')):null,
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                height:200,
                // color: Colors.yellowAccent,
                child: buildAppBarBackground(context),
              ),
            ),

            _buildStickBox(),

            SliverToBoxAdapter(
              child: Container(
                height: 60,
                color: AppColor.themeColor,
                padding: const EdgeInsets.only(left: 55,right: 55),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('課程名稱',style: TextStyle(fontSize: 20,color: AppColor.themeTextColor,fontWeight: FontWeight.w600),),
                    Text('狀態',style: TextStyle(fontSize: 20,color: AppColor.themeTextColor,fontWeight: FontWeight.w600),),
                  ],
                ),
              ),
            ),
            controller.dataArr.isEmpty?SliverToBoxAdapter(
              child: Container(
                height: 200,
                alignment: const Alignment(0, 0.1),
                child: const Text('暫無信息'),
              ),
            ): SliverList(
              delegate: _mySliverChildBuilderDelegate(),
            ),
          ],
        );
      }),
    );
  }

  Widget buildAppBarBackground(BuildContext context) {
    return Stack(
      children: [

        Center(
          child: Image.asset('images/ic_yuyuebg.png',width: Get.width,fit: BoxFit.cover,),
        ),
        Align(
          child:SizedBox(
            width: Get.width,
            // height: 200,
            // color: Colors.redAccent,
            // color: Colors.redAccent,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top,),
                Image.asset('images/login_log.png',width: 100,height: 100,),
              ],
            ),
          ),
        ),



        Container(
          margin: const EdgeInsets.only(top: 100),
          child: Center(
            child: Text('我的課堂',style: TextStyle(fontSize: 22,color: AppColor.themeTextColor,
                fontWeight: FontWeight.w700
            ),),
          ),
        ),

      ],
    );
  }

  _mySliverChildBuilderDelegate() {
    return SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            ///
            Classroomlist model = controller.dataArr[index];
        return GestureDetector(
          onTap: (){
            // Get.to(SubscribePage(model.name!,model.courseTimeId!,));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 25,right: 15,top: 10),
                child: Text('${model.day}',style: TextStyle(
                    fontSize: 18,fontWeight: FontWeight.w600,
                    color: AppColor.smallTextColor
                ),),
              ),
              ListView.builder(
                padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context,a){
                return Container(
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    width: Get.width,
                    child:Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 15,left: 15,),
                              child: Text('${model.course?[a].name}',style: appThemeData.textTheme.bodyText1!.copyWith(
                                  color: AppColor.themeTextColor,fontWeight: FontWeight.w700,fontSize: 22
                              ),),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10,left: 15,bottom: 15),
                              child: Text('開堂時間：${model.course?[a].startDay} ${model.course?[a].startTime}',
                                style: appThemeData.textTheme.bodyText1!.copyWith(
                                    color: AppColor.themeTextColor,fontWeight: FontWeight.w700,fontSize: 12
                                ),),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 0,left: 0,bottom: 0),
                              child:  Container(
                                padding:
                                const EdgeInsets.only(top: 0, left: 15,bottom: 15),
                                child: Text(
                                    '預約人數：${model.course?[a].subscribeUser}/${model.course?[a].totalUser}',
                                    style: appThemeData.textTheme.bodyText1!
                                        .copyWith(
                                        color: AppColor.themeTextColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700)),
                              ),
                            ),
                          ],
                        ),

                        Expanded(child: Container(
                          margin: const EdgeInsets.only(left: 50),
                          // color: Colors.red,
                          child: Center(
                            child: MaterialButton(onPressed: () {
                              Get.to(SubscribePage(model.course![a].name!,model.course![a].courseTimeId!,));
                            },color: AppColor.themeColor,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                              ),child: const Text('預約的學生',style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                );
              },itemCount: model.course?.length??0,)

            ],
          ),
        );
      },
      childCount: controller.dataArr.length,
    );
  }

  Widget _buildStickBox() {
    return SliverPersistentHeader(
      pinned: false,
      delegate: FixedPersistentHeaderDelegate(height: 55,controller: controller),
    );
  }

}
class FixedPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  ClassroomController controller;
  FixedPersistentHeaderDelegate({required this.height,required this.controller});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return GetBuilder<ClassroomController>(builder: (_){
      return Container(

        padding: EdgeInsets.only(left: 10,right: 3),
        height: height,
        // alignment: Alignment.center,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${controller.startDay.substring(5)} ~'
                ' ${controller.endDay.substring(5)}',
              style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,
                  color: AppColor.themeTextColor),),
            Container(
              margin: const EdgeInsets.only(
                left: 0,
              ),
              // width: Get.width - 100,
              child: Row(
                children: [
                  IconButton(onPressed: (){
                    controller.backWeek();
                    controller.update();
                  }, icon: Icon(Icons.arrow_back_ios,size: 15,
                    color: AppColor.themeTextColor,)),
                  GestureDetector(
                    onTap: (){
                      controller.getInitWeek();
                      controller.requestDataWithCourseList();
                      controller.update();

                    },
                    child: Text('This Week',style: TextStyle(
                        fontSize: 21,fontWeight: FontWeight.w600,
                        color: AppColor.themeTextColor
                    ),),
                  ),
                  IconButton(onPressed: (){
                    controller.nextWeek();
                    controller.update();

                  },
                      icon: Icon(Icons.arrow_forward_ios,size: 15,
                        color: AppColor.themeTextColor,)),

                ],
              ),

              // child: DatePicker(
              //   DateTime.now(),
              //   // initialSelectedDate:controller.initDatetime,
              //   height: 90,
              //   selectionColor: AppColor.registerBgColor,
              //   selectedTextColor: AppColor.themeTextColor,
              //   locale: "zh_HK",
              //   onDateChange: (date) {
              //     // New date selected
              //     var timeFormat = DateFormat("yyyy-MM-dd");
              //     var timeStr = timeFormat.format(date);
              //     controller.startDay = timeStr;
              //     controller.requestDataWithCourseList();
              //   },
              // ),
            ),
            const SizedBox(
              width: 15,
            ),
            GestureDetector(
              onTap: () async {
                controller.jumpToCalendar();
              },
              child: Image.asset(
                'images/ic_classroom_right.png',
                width: 45,
                height: 45,
              ),
            )
          ],
        ),
      );
    });
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant FixedPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.height != height;
  }
}