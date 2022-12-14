class ScanResultModel {
  bool? status;
  String? message;
  List<UserData>? data;

  ScanResultModel({this.status, this.message, this.data});

  ScanResultModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UserData>[];
      json['data'].forEach((v) {
        data!.add(new UserData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserData {
  int? id;
  int? isPrinted;
  String? name;
  String? email;
  String? uniqueCode;


  UserData({this.id, this.name, this.email, this.uniqueCode});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isPrinted = json['is_printed'];
    name = json['name'];
    email = json['email'];
    uniqueCode = json['unique_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_printed'] = this.isPrinted;
    data['name'] = this.name;
    data['email'] = this.email;
    data['unique_code'] = this.uniqueCode;
    return data;
  }
}
