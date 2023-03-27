class SubscribeModel {
  int? code;
  String? message;
  Data? data;

  SubscribeModel({this.code, this.message, this.data});

  SubscribeModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<SubscribeList>? list;

  Data({this.list});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <SubscribeList>[];
      json['list'].forEach((v) {
        list!.add( SubscribeList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubscribeList {
  int? id;
  String? name;
  int? userId;
  int? subscribeStatus;
  String? gold;
  String? createdAt;
  int? signId;

  SubscribeList(
      {this.id,
        this.name,
        this.userId,
        this.subscribeStatus,
        this.gold,
        this.signId,
        this.createdAt});

  SubscribeList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userId = json['user_id'];
    subscribeStatus = json['subscribe_status'];
    gold = json['gold'];
    signId = json['sign_id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['subscribe_status'] = this.subscribeStatus;
    data['gold'] = this.gold;
    data['created_at'] = this.createdAt;
    return data;
  }
}
