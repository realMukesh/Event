class RegisterResponseModel {
  bool? status;
  String? message;
  Data? data;
  String? qrCode;

  RegisterResponseModel({this.status, this.message, this.data, this.qrCode});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    qrCode = json['qr_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['qr_code'] = this.qrCode;
    return data;
  }
}

class Data {
  String? userType;
  String? category;
  String? name;
  String? designation;
  String? email;
  String? phone;
  String? company;
  String? uniqueCode;
  String? qrcodePath;
  String? eticketPath;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? isPrinted;
  String? printedAt;

  Data(
      {this.userType,
        this.category,
        this.name,
        this.designation,
        this.email,
        this.phone,
        this.company,
        this.uniqueCode,
        this.qrcodePath,
        this.eticketPath,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.isPrinted,
        this.printedAt});

  Data.fromJson(Map<String, dynamic> json) {
    userType = json['user_type'];
    category = json['category'];
    name = json['name'];
    designation = json['designation'];
    email = json['email'];
    phone = json['phone'];
    company = json['company'];
    uniqueCode = json['unique_code'];
    qrcodePath = json['qrcode_path'];
    eticketPath = json['eticket_path'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isPrinted = json['is_printed'];
    printedAt = json['printed_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_type'] = this.userType;
    data['category'] = this.category;
    data['name'] = this.name;
    data['designation'] = this.designation;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['company'] = this.company;
    data['unique_code'] = this.uniqueCode;
    data['qrcode_path'] = this.qrcodePath;
    data['eticket_path'] = this.eticketPath;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_printed'] = this.isPrinted;
    data['printed_at'] = this.printedAt;
    return data;
  }
}
