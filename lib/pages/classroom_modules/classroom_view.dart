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
      appBar: AppBar(),
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
              child: SizedBox(
                // color: Colors.red,
                height:200,
                // color: Colors.yellowAccent,
                child: buildAppBarBackground(context),
              ),
            ),

            _buildStickBox(),
            SliverToBoxAdapter(
              child: Container(
                height: 45,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Text('全部地點',style: TextStyle(color: AppColor.themeTextColor,fontWeight: FontWeight.w600),),
                    // Container(
                    //   height: 25,
                    //   width: 0.5,
                    //   color: Colors.black,
                    // ),
                    Text('全部課程',style: TextStyle(color: AppColor.themeTextColor,fontWeight: FontWeight.w600),),
                    // Container(
                    //   height: 25,
                    //   width: 0.5,
                    //   color: Colors.black,
                    // ),
                    // GestureDetector(
                    //   onTap: ()async{
                    //     controller.jumpToTeacherList();
                    //   },
                    //   child:Text(controller.teacherName,style: TextStyle(color: AppColor.themeTextColor,fontWeight: FontWeight.w600),),
                    // )

                  ],
                ),
              ),
            ),// tag1
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
        Align(
          alignment: const Alignment(0, -0.9),
          child:SizedBox(
            width: Get.width,
            // height: 200,
            // color: Colors.redAccent,
            // color: Colors.redAccent,
            child: Column(
              children: [
                Image.asset('images/login_log.png',width: 100,height: 100,),
              ],
            ),
          ),
        ),

        Center(
          child: Image.asset('images/ic_yuyuebg.png',width: Get.width,fit: BoxFit.cover,),
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
        ClassRoomList model = controller.dataArr[index];
        return GestureDetector(
          onTap: (){
            // Get.to(SignClassPage());
            // Get.to(CourseCreatePage('course.update',model: model,));
            Get.to(SubscribePage(model.name!,model.courseTimeId!,));
          },
          child: Column(
            children: [
              Container(
                color: AppColor.bgColor,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
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
                            child: Text('${model.name}',style: appThemeData.textTheme.bodyText1!.copyWith(
                                color: AppColor.themeTextColor,fontWeight: FontWeight.w700,fontSize: 22
                            ),),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10,left: 15,bottom: 15),
                            child: Text('開堂時間：${model.startDay} ${model.startTime}',style: appThemeData.textTheme.bodyText1!.copyWith(
                                color: AppColor.themeTextColor,fontWeight: FontWeight.w700
                            ),),
                          ),

                        ],
                      ),
                      Expanded(child: Container(
                        margin: const EdgeInsets.only(left: 50),
                        // color: Colors.red,
                        child: Center(
                          child: MaterialButton(onPressed: () {
                            Get.to(SubscribePage(model.name!,model.courseTimeId!,));

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
              ),

              Container(
                width: Get.width,
                height: 0.5,
                color: Colors.black87,
              )
            ],
          ),
        );
      },
      childCount: controller.dataArr.length,
    );
  }

  Widget _buildStickBox() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: FixedPersistentHeaderDelegate(height: 100,controller: controller),
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
    return Container(
      height: height,
      // alignment: Alignment.center,
      color: Colors.white,
      child:Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 15,),
            width: Get.width-100,
            child: DatePicker(
              DateTime.now(),
              // initialSelectedDate:controller.initDatetime,
              height: 90,
              selectionColor: AppColor.registerBgColor,
              selectedTextColor:AppColor.themeTextColor,
              locale: "zh_HK",
              onDateChange: (date) {
                // New date selected
                var timeFormat = DateFormat("yyyy-MM-dd");
                var timeStr = timeFormat.format(date);
                controller.startDay = timeStr;
                controller.requestDataWithCourseList();
              },
            ),
          ),
          const SizedBox(width: 15,),
          GestureDetector(
            onTap: ()async{
              controller.jumpToCalendar();
            },
            child:Image.asset('images/ic_classroom_right.png',width: 45,height: 45,),
          )
        ],
      ),
    );
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