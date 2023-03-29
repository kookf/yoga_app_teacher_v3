import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loading_btn/loading_btn.dart';
import 'package:yoga_app/common/app_theme.dart';
import 'package:yoga_app/common/colors.dart';
import 'package:yoga_app/router/app_pages.dart';
import '../../utils/persisten_storage.dart';
import 'teacher_login_controller.dart';

class LoginView extends GetView{

   LoginView({super.key});

   @override

   final LoginController controller = Get.put(LoginController());

   @override
   Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // appBar: AppBar(
      //   // title: Text('d'),
      //   // leading: IconButton(onPressed: (){}, icon: Icon(Icons.add)),
      // ),
      body: GetBuilder<LoginController>(builder: (_){
        return ListView(
          padding: const EdgeInsets.all(0),
          children: [
           const SizedBox(height: 0,),
            Stack(
              children: [
                Image.asset('images/login_bg.png',width: Get.width,
                fit: BoxFit.cover,
                ),
                Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.only(left: 15,top:MediaQuery.of(context).padding.top+20),
                  child: Text('Hello!',style: TextStyle(fontSize: 31,color: AppColor.themeColor),),
                ),
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top+40),
                  // color: Colors.redAccent,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Image.asset('images/login_log.png',width: 260,),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        alignment: Alignment.center,
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                          color: AppColor.btnBgColors,
                          borderRadius: const BorderRadius.all(Radius.circular(5))
                        ),
                        child: const Text('老師版',style: TextStyle(color: Colors.white),)
                      )
                    ],
                  )
                ),

              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // color: Colors.redAccent,
                  width: Get.width,
                  alignment: const Alignment(-0.75, -1),
                  padding: const EdgeInsets.only(top: 30),
                    child: Text('登入',style: appThemeData.textTheme.bodyText1!.copyWith(fontSize: 25,color: AppColor.themeColor),),
                ),
                Center(
                  child:  Container(
                    margin: const EdgeInsets.only(top: 5),
                    padding: const EdgeInsets.only(left: 15),
                    width: Get.width-50,
                    //边框设置
                    decoration:  BoxDecoration(
                      color: Colors.white,
                      //设置四周圆角 角度
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                      //设置四周边框
                      border: Border.all(width: 1, color: AppColor.textFieldBorderColor),
                    ),
                    child: TextField(
                      controller: controller.emailTextEditingController,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(50) //限制长度
                      ],
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '郵件'
                      ),
                    ),
                  ),
                ),
                Center(
                  child:  Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.only(left: 15),
                    width: Get.width-50,
                    //边框设置
                    decoration:  BoxDecoration(
                      color: Colors.white,
                      //设置四周圆角 角度
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                      //设置四周边框
                      border:  Border.all(width: 1, color: AppColor.textFieldBorderColor),
                    ),
                    child:  TextField(
                      obscureText: true,
                      controller: controller.passwordTextEditingController,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(30) //限制长度
                      ],
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: '密碼'
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child:LoadingBtn(
                    height: 50,
                    borderRadius: 8,
                    animate: true,
                    color: AppColor.themeColor,
                    width: MediaQuery.of(context).size.width * 0.45,
                    loader: Container(
                      padding: const EdgeInsets.all(10),
                      width: 40,
                      height: 40,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    child: const Text("登入"),
                    onTap: (startLoading, stopLoading, btnState) async {
                      if (btnState == ButtonState.idle) {
                        if(controller.emailTextEditingController.text.isEmpty){
                          BotToast.showText(text: '郵件 不能留空');
                          return;
                        }
                        if(controller.passwordTextEditingController.text.isEmpty){
                          BotToast.showText(text: '密碼 不能留空');
                          return;
                        }
                        startLoading();

                        controller.requestDataWithLogin().then((value)async => {
                          if(value['code']==200){
                            await PersistentStorage().setStorage('token', value['data']['token']),
                            // Get.offAll(const Tabs()),
                            Get.offAllNamed(AppRoutes.bottomMain),
                            stopLoading(),
                            BotToast.showText(text: '登錄成功')
                          }else{
                            BotToast.showText(text: '${value['message']}'),
                            stopLoading(),
                          }
                        });

                        // await Future.delayed(const Duration(seconds: 2));

                        // Get.offAll(const Tabs());
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Text('未有賬戶',style: TextStyle(color: AppColor.themeColor),)
                ),
                Center(
                  child: GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoutes.teacherRegister);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        color: AppColor.registerBgColor,
                      ),
                      width: Get.width-150,
                      height: 35,
                      alignment: Alignment.center,
                      child: const Text('創建新賬戶',style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ],
        );
      }),
    );
  }

}