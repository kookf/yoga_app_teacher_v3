import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slider_button/slider_button.dart';
import 'package:yoga_app/common/colors.dart';
import 'package:yoga_app/utils/hexcolor.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Center(
              child: SliderButton(
                backgroundColor: AppColor.themeColor,
                buttonColor: HexColor('#5B426A'),
                height: 60,
                width: 400,
            // buttonSize: 60,
            action: () {
              ///Do something here
              // Navigator.of(context).pop();
            },
            label: Text(
              "",
              style: TextStyle(
                  color: Color(0xff4a4a4a),
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
                icon: Container(
                  child: Text('簽到',style: TextStyle(fontSize: 20,color: Colors.white),),
                ),
            // icon: Image.asset('images/huakuai_btn.png',fit: BoxFit.cover,),
          )),
        ],
      ),
    );
  }
}
