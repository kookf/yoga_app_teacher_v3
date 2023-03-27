class ClassRoomModel {
  int? code;
  String? message;
  Data? data;

  ClassRoomModel({this.code, this.message, this.data});

  ClassRoomModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<ClassRoomList>? list;
  int? totalPage;

  Data({this.list, this.totalPage});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <ClassRoomList>[];
      json['list'].forEach((v) {
        list!.add(ClassRoomList.fromJson(v));
      });
    }
    totalPage = json['total_page'];
  }

}

class ClassRoomList {
  int? courseTimeId;
  int? courseId;
  String? name;
  String? teacherName;
  int? totalUser;
  String? address;
  String? startDay;
  String? startTime;
  String? endTime;
  int? subscribeId;
  int? subscribeStatus;
  int? subscribeUser;
  int? signIn;

  ClassRoomList(
      {this.courseTimeId,
        this.courseId,
        this.name,
        this.teacherName,
        this.totalUser,
        this.address,
        this.startDay,
        this.startTime,
        this.endTime,
        this.subscribeId,
        this.subscribeStatus,
        this.signIn,
        this.subscribeUser});

  ClassRoomList.fromJson(Map<String, dynamic> json) {
    courseTimeId = json['course_time_id'];
    courseId = json['course_id'];
    name = json['name'];
    teacherName = json['teacher_name'];
    totalUser = json['total_user'];
    address = json['address'];
    startDay = json['start_day'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    subscribeId = json['subscribe_id'];
    subscribeStatus = json['subscribe_status'];
    subscribeUser = json['subscribe_user'];
    signIn = json['sign_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['course_time_id'] = courseTimeId;
    data['course_id'] = courseId;
    data['name'] = name;
    data['teacher_name'] = teacherName;
    data['total_user'] = totalUser;
    data['address'] = address;
    data['start_day'] = startDay;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['subscribe_id'] = subscribeId;
    data['subscribe_status'] = subscribeStatus;
    data['subscribe_user'] = subscribeUser;
    return data;
  }
}
