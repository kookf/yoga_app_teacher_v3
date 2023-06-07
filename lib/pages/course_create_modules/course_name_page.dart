import 'package:flutter/material.dart';
import 'package:yoga_app/services/address.dart';
import 'package:yoga_app/services/dio_manager.dart';
import 'package:get/get.dart';
class CourseNamePage extends StatefulWidget {
  const CourseNamePage({Key? key}) : super(key: key);

  @override
  State<CourseNamePage> createState() => _CourseNamePageState();
}

class _CourseNamePageState extends State<CourseNamePage> {
  
  

  var dataArr = [];
  
  requestDataWithCourseName()async{
    var params = {
      'method':'course.name'
    };
    var json = await DioManager().kkRequest(Address.hostAuth,bodyParams: params);
    dataArr.addAll(json['data']['list']);
    print(dataArr);
    setState(() {

    });
  }
  
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestDataWithCourseName();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('課堂名稱'),
      ),

      body: ListView.builder(
        itemBuilder: _buildListItem,itemCount: dataArr.length,),
    );
  }
  Widget _buildListItem(BuildContext context, int index) {

    var json = dataArr[index];

    return ListTile(
      title: Text('${json['course_name']}'),trailing: const Icon(Icons.arrow_forward_ios,size: 15,),
      onTap: (){
        Get.back(result: {'course_id':json['course_id'],'course_name':json['course_name']});
      },
    );
  }
}