import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:yoga_app/common/colors.dart';
import 'package:yoga_app/services/address.dart';
import 'package:yoga_app/services/dio_manager.dart';
import 'package:get/get.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:cart_stepper/cart_stepper.dart';
import '../../common/eventbus.dart';
import '../classroom_modules/classroom_calendar_page.dart';
import '../classroom_modules/classroom_model.dart';
import 'course_name_page.dart';

class CourseCreatePage extends StatefulWidget {

  final ClassRoomList? model;

  final String type;

  const CourseCreatePage(this.type,{this.model,Key? key}) : super(key: key);

  @override
  State<CourseCreatePage> createState() => _CourseCreatePageState();
}

class _CourseCreatePageState extends State<CourseCreatePage> {

  String courseName = '請選擇一個課堂';
  int? courseId;

  String startDay = '請選擇開始日期';
  String startTime = '請選擇開始時間';
  String endTime = '請選擇落堂時間';

  TextEditingController goldTextEditingController = TextEditingController();
  TextEditingController addressTextEditingController = TextEditingController();

  var totalUser = 2;

  requestDataWithCreate()async{
    Map<String, Object?> params;
    if(widget.type =='course.create'){
      params = {
        'method':widget.type,
        'course_id':courseId,
        'start_day':startDay,
        'start_time':startTime,
        'end_time':endTime,
        'gold':goldTextEditingController.text,
        'total_user':totalUser,
        'address':addressTextEditingController.text,
      };
    }else{
      params = {
        'method':widget.type,
         'id':widget.model!.courseTimeId,
        'course_id':courseId,
        'start_day':startDay,
        'start_time':startTime,
        'end_time':endTime,
        'gold':goldTextEditingController.text,
        'total_user':totalUser,
        'address':addressTextEditingController.text,
      };
    }

    var json = await DioManager().kkRequest(Address.hostAuth,params:params);
    if(json['code'] == 200){
      if(widget.type == 'course.update'){
        BotToast.showText(text: '修改課堂成功');
      }else{
        BotToast.showText(text: '新增課堂成功');
      }
    }else{
      BotToast.showText(text: json['message']);
    }

    eventBus.fire(EventFn('refresh'));

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startDay = widget.model?.startDay??'請選擇開始日期';
    startTime = widget.model?.startTime??'請選擇開始時間';
    endTime = widget.model?.endTime??'請選擇落堂時間';
    addressTextEditingController.text = widget.model?.address??'';
    totalUser = widget.model?.totalUser??2;
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('',),
      ),
      body: ListView(
        children: [
        widget.type=='course.create'?Center(
            child: Text('新增課堂',style: TextStyle(color: AppColor.themeTextColor,fontSize: 25,fontWeight: FontWeight.w700),),
          ):Center(
          child: Text('編輯課堂',style: TextStyle(color: AppColor.themeTextColor,fontSize: 25,fontWeight: FontWeight.w700),),
        ),

          const SizedBox(height: 15,),
          GestureDetector(
           onTap: ()async{
           var data = await Get.to(const CourseNamePage());
           if(data!= null){
             print(data);
             courseName = data['course_name'];
             courseId = data['course_id'];
             setState(() {

             });
           }
           },
           child:  Center(
             child: Container(
               height:40,
               margin: const EdgeInsets.only(top: 5),
               padding: const EdgeInsets.only(left: 5,right: 5),
               width: Get.width-50,
               //边框设置
               decoration:  BoxDecoration(
                 color: Colors.white,
                 //设置四周圆角 角度
                 borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                 //设置四周边框
                 border:  Border.all(width: 1, color: AppColor.textFieldBorderColor),
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text(courseName),
                   Icon(Icons.arrow_forward_ios,size: 15,color:AppColor.themeColor,),
                 ],
               ),
             ),
           ),
         ),

          const SizedBox(height: 15,),
          GestureDetector(
            onTap: ()async{
              var data = await Get.to(const ClassRoomCalendarPage());
              if(data!= null){
                startDay = data;
                setState(() {

                });
              }
            },
            child:  Center(
              child: Container(
                height:40,
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.only(left: 5,right: 5),
                width: Get.width-50,
                //边框设置
                decoration:  BoxDecoration(
                  color: Colors.white,
                  //设置四周圆角 角度
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  //设置四周边框
                  border:  Border.all(width: 1, color: AppColor.textFieldBorderColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(startDay),
                    Icon(Icons.arrow_forward_ios,size: 15,color:AppColor.themeColor,),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 15,),
          GestureDetector(
            onTap: ()async{
              DatePicker.showTimePicker(context,onConfirm: (value){
                var timeFormat = DateFormat("HH:mm:ss");
                var timeStr = timeFormat.format(value);

                startTime = timeStr;
                setState(() {

                });
              });

            },
            child:  Center(
              child: Container(
                height:40,
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.only(left: 5,right: 5),
                width: Get.width-50,
                //边框设置
                decoration:  BoxDecoration(
                  color: Colors.white,
                  //设置四周圆角 角度
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  //设置四周边框
                  border:  Border.all(width: 1, color: AppColor.textFieldBorderColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(startTime),
                    Icon(Icons.arrow_forward_ios,size: 15,color:AppColor.themeColor,),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 15,),
          GestureDetector(
            onTap: ()async{
              DatePicker.showTimePicker(context,onConfirm: (value){
                var timeFormat = DateFormat("HH:mm:ss");
                var timeStr = timeFormat.format(value);

                endTime = timeStr;
                setState(() {

                });
              });

            },
            child:  Center(
              child: Container(
                height:40,
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.only(left: 5,right: 5),
                width: Get.width-50,
                //边框设置
                decoration:  BoxDecoration(
                  color: Colors.white,
                  //设置四周圆角 角度
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  //设置四周边框
                  border:  Border.all(width: 1, color: AppColor.textFieldBorderColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(endTime),
                    Icon(Icons.arrow_forward_ios,size: 15,color:AppColor.themeColor,),
                  ],
                ),
              ),
            ),
          ),


          const SizedBox(height: 15,),
          GestureDetector(
            onTap: ()async{
            },
            child:  Center(
              child: Container(
                height:40,
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.only(left: 5,right: 5),
                width: Get.width-50,
                //边框设置
                decoration:  BoxDecoration(
                  color: Colors.white,
                  //设置四周圆角 角度
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  //设置四周边框
                  border:  Border.all(width: 1, color: AppColor.textFieldBorderColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('請輸入代幣:'),
                    Container(
                      color: Colors.white,
                      width: Get.width/2-25,
                      child: TextField(
                        controller: goldTextEditingController,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(5) //限制长度
                        ],
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '請輸入代筆',isCollapsed: true,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),


          const SizedBox(height: 15,),
          GestureDetector(
            onTap: ()async{
            },
            child:  Center(
              child: Container(
                height:40,
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.only(left: 5,right: 5),
                width: Get.width-50,
                //边框设置
                decoration:  BoxDecoration(
                  color: Colors.white,
                  //设置四周圆角 角度
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  //设置四周边框
                  border:  Border.all(width: 1, color: AppColor.textFieldBorderColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('請輸入課堂地址:'),
                    Container(
                      color: Colors.white,
                      width: Get.width/2-25,
                      child: TextField(
                        controller: addressTextEditingController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                          hintText: '請輸入課堂地址',isCollapsed: true
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 15,),
          Container(
            margin: const EdgeInsets.only(left: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('課堂人數:'),
                CartStepperInt(
                  value: totalUser,
                  style: CartStepperStyle(
                      activeBackgroundColor: AppColor.themeColor
                  ),
                  size: 30,
                  didChangeCount: (count) {
                    if (count < 2) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                        content: const Text('總人數不能小於 2 '),
                        backgroundColor: AppColor.themeTextColor,
                      ));
                      return;
                    }
                    setState(() {
                      totalUser = count;
                    });
                  },
                )
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 15,left: 15,right: 15),
            width: Get.width - 50,
            height: 45,
            decoration: BoxDecoration(
                color: AppColor.themeColor,
                borderRadius: const BorderRadius.all(Radius.circular(20))
            ),
            child: MaterialButton(onPressed: () {
              if(courseId ==null ||startDay=='請選擇開始日期'||startTime=='請選擇開始時間'||endTime=='請選擇落堂時間'||
              goldTextEditingController.text.isEmpty||addressTextEditingController.text.isEmpty){
                BotToast.showText(text: '請輸入完整的信息');
                return;
              }

              print(courseId);

              requestDataWithCreate();
            },
              child: const Text('確定',style: TextStyle(color: Colors.white),),
            ),
          ),

          Container(
            width: Get.width,
            // height: 200,
            alignment: Alignment.bottomCenter,
            child: Image.asset('images/yuyuebg.png'),
          )
        ],
      ),
    );
  }
}
