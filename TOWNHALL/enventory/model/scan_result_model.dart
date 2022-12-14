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
  String? userType;
  dynamic? category;
  String? name;
  dynamic? email;
  String? phone;
  String? tableNumber;
  dynamic? countryCode;
  String? company;
  String? designation;
  String? uniqueCode;
  String? qrcodePath;
  String? eticketPath;
  int? status;
  int? isPrinted;
  String? printedAt;
  int? emailSend;
  int? remEmailSend;
  int? feedEmailSend;
  int? attendanceBallroom;
  int? attendanceLunch;
  String? createdAt;
  String? updatedAt;

  UserData(
      {this.id,
        this.userType,
        this.category,
        this.name,
        this.email,
        this.phone,
        this.tableNumber,
        this.countryCode,
        this.company,
        this.designation,
        this.uniqueCode,
        this.qrcodePath,
        this.eticketPath,
        this.status,
        this.isPrinted,
        this.printedAt,
        this.emailSend,
        this.remEmailSend,
        this.feedEmailSend,
        this.attendanceBallroom,
        this.attendanceLunch,
        this.createdAt,
        this.updatedAt});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    category = json['category'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    tableNumber = json['table_number'];
    countryCode = json['country_code'];
    company = json['company'];
    designation = json['designation'];
    uniqueCode = json['unique_code'];
    qrcodePath = json['qrcode_path'];
    eticketPath = json['eticket_path'];
    status = json['status'];
    isPrinted = json['is_printed'];
    printedAt = json['printed_at'];
    emailSend = json['email_send'];
    remEmailSend = json['rem_email_send'];
    feedEmailSend = json['feed_email_send'];
    attendanceBallroom = json['attendance_ballroom'];
    attendanceLunch = json['attendance_lunch'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_type'] = this.userType;
    data['category'] = this.category;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['table_number'] = this.tableNumber;
    data['country_code'] = this.countryCode;
    data['company'] = this.company;
    data['designation'] = this.designation;
    data['unique_code'] = this.uniqueCode;
    data['qrcode_path'] = this.qrcodePath;
    data['eticket_path'] = this.eticketPath;
    data['status'] = this.status;
    data['is_printed'] = this.isPrinted;
    data['printed_at'] = this.printedAt;
    data['email_send'] = this.emailSend;
    data['rem_email_send'] = this.remEmailSend;
    data['feed_email_send'] = this.feedEmailSend;
    data['attendance_ballroom'] = this.attendanceBallroom;
    data['attendance_lunch'] = this.attendanceLunch;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
