import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoga_app/pages/course_create_modules/course_create_page.dart';
import '../common/colors.dart';
import '../router/app_pages.dart';
class ReserveListPage extends StatefulWidget {

  const ReserveListPage({Key? key}) : super(key: key);

  @override
  State<ReserveListPage> createState() => _ReserveListPageState();
}

class _ReserveListPageState extends State<ReserveListPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Container(
            width: Get.width,
            // color: Colors.red,
            margin: const EdgeInsets.only(top: 25),
            // height: 300,
            child: Stack(
              children: [
                SizedBox(
                  width: Get.width,
                  child: Image.asset('images/ic_bg.png',fit: BoxFit.fill,),
                ),
                Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child:Center(
                    child: Image.asset('images/login_log.png',width: 150,height: 150,),
                  )
                ),
                Align(
                  child: Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top+150),
                    child: Text('預約課堂',style: TextStyle(fontSize: 25,
                        fontWeight: FontWeight.w700,color: AppColor.themeTextColor),),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){

              Get.toNamed(AppRoutes.classroom);
              // Get.to(ClassroomView());
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.black,
                        width: 0.3
                    )
                ),
                padding: const EdgeInsets.only(left: 55,right: 55),
                height: 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('我的課堂',style: TextStyle(fontWeight: FontWeight.w700,
                        fontSize: 23,color: AppColor.themeTextColor),),
                    const Icon(Icons.arrow_forward_ios,size: 30,color: Colors.grey,)
                  ],
                )
            ),
          ),
          GestureDetector(
            onTap: (){

            },
            child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                padding: const EdgeInsets.only(left: 55,right: 55),
                height: 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('學生上課記錄',style: TextStyle(fontWeight: FontWeight.w700,
                        fontSize: 23,color: AppColor.themeTextColor),),
                    const Icon(Icons.arrow_forward_ios,size: 30,color: Colors.grey,)
                  ],
                )
            ),
          ),
          GestureDetector(
            onTap: (){
              Get.to(const CourseCreatePage('course.create'));
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.black,
                        width: 0.3
                    )
                ),
                padding: const EdgeInsets.only(left: 55,right: 55),
                height: 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('新增課堂',style: TextStyle(fontWeight: FontWeight.w700,
                        fontSize: 23,color: AppColor.themeTextColor),),
                    const Icon(Icons.arrow_forward_ios,size: 30,color: Colors.grey,)
                  ],
                )
            ),
          ),
        ],
      ),
    );
  }
}
