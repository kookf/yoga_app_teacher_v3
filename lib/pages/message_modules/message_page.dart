
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import '../../common/colors.dart';
import '../../components/custom_footer.dart';
import '../../utils/hexcolor.dart';
import 'message_controller.dart';
import 'message_model.dart';

class MessagePage extends GetView{

   MessagePage({super.key});

  @override
  final MessagePageController controller = Get.put(MessagePageController());


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: AppColor.themeColor,
      //   title: Text('系統訊息',style: TextStyle(color: AppColor.themeTextColor),),
      // ),
      body: GetBuilder<MessagePageController>(builder: (_){
        return Column(
          children: [
            Container(
                height: MediaQuery.of(context).padding.top+kToolbarHeight,
                width: Get.width,
                decoration: const BoxDecoration(
                  image:DecorationImage(image: AssetImage('images/appbar_bg.png',),
                    fit: BoxFit.fill,
                  ),
                ),
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.only(top: 25),
                  child: const Text('MeMO Yoga',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500),),
                )
            ),
            Expanded(child:  Container(
              color: AppColor.themeColor,
              child: EasyRefresh.custom(
                  emptyWidget:controller.dataArr.isEmpty?const Center(child:Text('暫無信息')):null,
                  header: MaterialHeader(),
                  footer: MaterialFooter1(),
                  onRefresh: ()=>controller.onRefresh(),
                  onLoad: ()=>controller.onLoad(),
                  controller: controller.easyRefreshController,
                  slivers: [

                    SliverList(delegate: _mySliverChildBuilderDelegate())
                  ]),
            ),),
          ],
        );
      })
    );
  }
  SliverChildBuilderDelegate _mySliverChildBuilderDelegate(){
    /**
     *
     * $notice_type  類型 1.注册 11.客户预约 12.客户取消预约 13.管理员取消预约
     * 14.预约成功通知 21 充值 22 钱包即将过期 23 共享钱包即将过期
     * 24 钱包已过期 25 共享钱包已过期
     * */
    return SliverChildBuilderDelegate((context, index) {

      String str = '';

      MessageList model = controller.dataArr[index];

      if(model.noticeType ==1){
        str = '注册';
      }if(model.noticeType ==11){
        str = '客户预约';
      }if(model.noticeType ==12){
        str = '客户取消预约';
      }if(model.noticeType ==13){
        str = '管理员取消预约';
      }if(model.noticeType ==14){
        str = '预约成功通知';
      }if(model.noticeType ==21){
        str = '充值';
      }if(model.noticeType ==22){
        str = '钱包即将过期';
      }if(model.noticeType ==23){
        str = '共享钱包即将过期';
      }if(model.noticeType ==24){
        str = '钱包已过期';
      }if(model.noticeType ==25){
        str = '共享钱包已过期';
      }

      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        // height: 50,
        margin: const EdgeInsets.only(left: 15,right: 15,top: 15),
        child: ExpansionTile(
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          iconColor: AppColor.themeColor,
          collapsedIconColor: Colors.grey,
          initiallyExpanded: true,
          title:Text(str,style: TextStyle(color: HexColor('#D15299'),
              fontSize: 19,fontWeight: FontWeight.w700),),
          children: [
            Container(
              margin: const EdgeInsets.only(left: 25,top: 5),
              child: Text('${model.msg}',style: TextStyle(color: HexColor('#D15299'),
                  fontSize: 19,fontWeight: FontWeight.w700),),
            ),
            SizedBox(height: 15,),

            model.coursesName==null?const SizedBox():Container(
              margin: const EdgeInsets.only(left: 25,top: 0),
              child: Text('課程:${model.coursesName}',style: TextStyle(color: AppColor.themeTextColor,
                  fontSize: 16,fontWeight: FontWeight.w700),),
            ),
            model.coursesName==null?const SizedBox():Container(
              margin: const EdgeInsets.only(left: 25,top: 5),
              child: Text('開始日期：${model.startDay}',style: TextStyle(color: AppColor.themeTextColor,
                  fontSize: 16,fontWeight: FontWeight.w700),),
            ),
            model.coursesName==null?const SizedBox():Container(
              margin: const EdgeInsets.only(left: 25,top: 5,bottom: 15),
              child: Text('導師：${model.teacherName}',style: TextStyle(color: AppColor.themeTextColor,
                  fontSize: 16,fontWeight: FontWeight.w700),),
            ),
            SizedBox(height: 5,),
          ],
        ),
      );
    },childCount: controller.dataArr.length);
  }


}