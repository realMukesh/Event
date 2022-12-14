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
  String? firstName;
  String? lastName;
  String? name;
  String? attendeeType;
  String? email;
  String? city;
  String? phone;
  String? countryCode;
  String? venue;
  String? category;
  String? uniqueCode;
  String? qrcodePath;
  String? eticketPath;
  dynamic? eticketPathNew;
  int? status;
  String? statusTime;
  int? whatsappNotification;
  int? isPrinted;
  int? printingStatus;
  String? printingMessage;
  dynamic? printedAt;

  UserData(
      {this.id,
      this.userType,
      this.firstName,
      this.lastName,
      this.name,
      this.attendeeType,
      this.email,
      this.city,
      this.phone,
      this.countryCode,
      this.venue,
      this.category,
      this.uniqueCode,
      this.qrcodePath,
      this.eticketPath,
      this.eticketPathNew,
      this.status,
      this.statusTime,
      this.whatsappNotification,
      this.isPrinted,
      this.printingStatus,
      this.printingMessage,
      this.printedAt});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    name = json['name'];
    attendeeType = json['attendee_type'];
    email = json['email'];
    city = json['city'];
    phone = json['phone'];
    countryCode = json['country_code'];
    venue = json['venue'];
    category = json['category'];
    uniqueCode = json['unique_code'];
    qrcodePath = json['qrcode_path'];
    eticketPath = json['eticket_path'];
    eticketPathNew = json['eticket_path_new'];
    status = json['status'];
    statusTime = json['status_time'];
    whatsappNotification = json['whatsapp_notification'];
    isPrinted = json['is_printed'];
    printingStatus = json['printing_status'];
    printingMessage = json['printing_message'];
    printedAt = json['printed_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_type'] = this.userType;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['name'] = this.name;
    data['attendee_type'] = this.attendeeType;
    data['email'] = this.email;
    data['city'] = this.city;
    data['phone'] = this.phone;
    data['country_code'] = this.countryCode;
    data['venue'] = this.venue;
    data['category'] = this.category;
    data['unique_code'] = this.uniqueCode;
    data['qrcode_path'] = this.qrcodePath;
    data['eticket_path'] = this.eticketPath;
    data['eticket_path_new'] = this.eticketPathNew;
    data['status'] = this.status;
    data['status_time'] = this.statusTime;
    data['whatsapp_notification'] = this.whatsappNotification;
    data['is_printed'] = this.isPrinted;
    data['printing_status'] = this.printingStatus;
    data['printing_message'] = this.printingMessage;
    data['printed_at'] = this.printedAt;
    return data;
  }
}
