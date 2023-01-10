import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoga_app/common/colors.dart';

import '../../components/gradient_button.dart';


class JoinClassView extends GetView{

  const JoinClassView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 50),
            alignment: Alignment.center,
            child:Text('加入課堂',style: TextStyle(color: AppColor.themeColor,fontSize: 31),),
          ),
          Container(
            // width: Get.width-100,
            margin: EdgeInsets.only(left: 30,right: 30),
            height: 40,
            child: GradientButton(
              child: Text('登記課堂'),
              borderRadius: BorderRadius.all(Radius.circular(20)) ,
            ),
          )
        ],
      ),
    );
  }

}