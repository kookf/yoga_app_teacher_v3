class SignRecordModel {
  int? code;
  String? message;
  Data? data;

  SignRecordModel({this.code, this.message, this.data});

  SignRecordModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<SignRecordList>? list;
  int? totalPage;

  Data({this.list, this.totalPage});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <SignRecordList>[];
      json['list'].forEach((v) {
        list!.add(SignRecordList.fromJson(v));
      });
    }
    totalPage = json['total_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    data['total_page'] = this.totalPage;
    return data;
  }
}

class SignRecordList {
  int? id;
  String? name;
  String? courseName;
  int? userId;
  int? subscribeStatus;
  int? signId;
  String? gold;
  String? createdAt;
  String? signTime;
  String? cancelTime;

  SignRecordList(
      {this.id,
        this.name,
        this.courseName,
        this.userId,
        this.subscribeStatus,
        this.signId,
        this.gold,
        this.signTime,
        this.cancelTime,
        this.createdAt});

  SignRecordList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    courseName = json['course_name'];
    userId = json['user_id'];
    subscribeStatus = json['subscribe_status'];
    signId = json['sign_id'];
    gold = json['gold'];
    createdAt = json['created_at'];
    signTime = json['sign_time'];
    cancelTime = json['cancel_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['course_name'] = this.courseName;
    data['user_id'] = this.userId;
    data['subscribe_status'] = this.subscribeStatus;
    data['sign_id'] = this.signId;
    data['gold'] = this.gold;
    data['created_at'] = this.createdAt;
    return data;
  }
}
