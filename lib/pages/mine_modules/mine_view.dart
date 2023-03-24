import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoga_app/pages/mine_modules/class_record_module/class_record_page.dart';
import 'package:yoga_app/pages/mine_modules/setting_page.dart';
import '../../common/colors.dart';
import '../../services/address.dart';
import 'change_avatar_page.dart';
import 'change_password_page.dart';
import 'mine_controller.dart';

class MineView extends GetView{


  MineView({super.key});

  @override
  final MineController controller = Get.put(MineController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      body: GetBuilder<MineController>(builder: (_){
        return ListView(
          padding: const EdgeInsets.all(0),
          children: [
            SizedBox(
              width: Get.width,
              height: 400,
              child: Stack(
                children: [
                  SizedBox(
                    width: Get.width,
                    child: Image.asset('images/ic_mine_bg.png',fit: BoxFit.fill,),
                  ),
                  Align(alignment: const Alignment(0, -0.5),
                    child: Container(
                    width: 160,
                   height: 160,
                   clipBehavior: Clip.hardEdge,
                   decoration: const BoxDecoration(
                     borderRadius: BorderRadius.all(Radius.circular(80))
                   ),
                   child: CachedNetworkImage(
                     imageUrl: "${Address.homeHost}/storage/${controller.userModel?.data?.avatar}",
                     placeholder: (context, url) => const CircularProgressIndicator(),
                     errorWidget: (context, url, error) => const Icon(Icons.error),
                     fit: BoxFit.cover,
                     width: 160,
                     height: 160,
                   ),
                 ),),

                  Align(
                    child: Container(
                      margin: const EdgeInsets.only(top: 40),
                      child: Text('${controller.userModel?.data?.name}',style: TextStyle(fontSize: 25,
                          fontWeight: FontWeight.w700,color: AppColor.themeTextColor),),
                    ),
                  ),

                  Align(
                    child: Container(
                      margin: const EdgeInsets.only(top: 40+60),
                      child: Text('${controller.userModel?.data?.phone  }',style: TextStyle(fontSize: 25,
                          fontWeight: FontWeight.w700,color: AppColor.themeTextColor),),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child:GestureDetector(
                      onTap: (){
                        Get.to(const ClassRecordPage());
                      },
                      child:  Container(
                        margin: const EdgeInsets.only(left: 15,right: 15,top: 1),
                        height: 120,
                        decoration:  BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                          color: AppColor.themeColor,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,  //底色,阴影颜色
                              offset: Offset(1, 2), //阴影位置,从什么位置开始
                              blurRadius: 1,  // 阴影模糊层度
                              spreadRadius: 0,  //阴影模糊大小
                            )],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(flex: 1,child:Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('images/ic_shijian.png',width: 80,height: 80,),
                                const SizedBox(width: 15,),
                                Text('學生上課記錄',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700,color: AppColor.themeTextColor),),
                              ],
                            ),),

                            // Container(
                            //   height: 80,
                            //   width: 0.5,
                            //   color: AppColor.themeTextColor
                            // ),
                            //
                            // Expanded(flex: 1,child:  GestureDetector(
                            //   onTap: (){
                            //     Get.to(MySalaryPage());
                            //     // Get.to(const PersonalWalletPage());
                            //   },
                            //   child: Column(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: [
                            //       Image.asset('images/ic_qianbao.png',width: 50,height: 50,),
                            //       Text('我的工資',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700,color: AppColor.themeTextColor),),
                            //     ],
                            //   ),
                            // ),),
                            // Container(
                            //     height: 80,
                            //     width: 0.5,
                            //     color: AppColor.themeTextColor
                            // ),

                          ],
                        ),
                      ),
                    ),
                  )

                ],
              ),

            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: (){
              Get.to(ChangeAvatarPage('${Address.homeHost}/storage/${controller.userModel?.data?.avatar}'));
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
                      Text('更換頭像',style: TextStyle(fontWeight: FontWeight.w700,
                          fontSize: 23,color: AppColor.themeTextColor),),
                      const Icon(Icons.arrow_forward_ios,size: 30,color: Colors.grey,)
                    ],
                  )
              ),
            ),
            GestureDetector(
              onTap: (){
                Get.to(const ChangePasswordPage());
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
                    Text('密碼修改',style: TextStyle(fontWeight: FontWeight.w700,
                        fontSize: 23,color: AppColor.themeTextColor),),
                    const Icon(Icons.arrow_forward_ios,size: 30,color: Colors.grey,)
                  ],
                )
              ),
            ),
            GestureDetector(
              onTap: ()async{
               var result = await Get.to(const SettingPage());
               if(result == 'refresh'){
                 controller.requestDataWithUserinfo();
               }
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
                    Text('設定',style: TextStyle(fontWeight: FontWeight.w700,
                        fontSize: 23,color: AppColor.themeTextColor),),
                    const Icon(Icons.arrow_forward_ios,size: 30,color: Colors.grey,)
                  ],
                )
              ),
            ),
            GestureDetector(
              onTap: (){
                // Get.to(const SettingPage());
                controller.requestDataWithLoginOut();
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
                      Text('退出登录',style: TextStyle(fontWeight: FontWeight.w700,
                          fontSize: 23,color: AppColor.themeTextColor),),
                      const Icon(Icons.arrow_forward_ios,size: 30,color: Colors.grey,)
                    ],
                  )
              ),
            ),

          ],
        );
      }),
    );
  }
}