class RegisterResponseModel {
  bool? status;
  String? message;
  Data? data;

  RegisterResponseModel({this.status, this.message, this.data});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? userType;
  String? name;
  String? phone;
  String? company;
  String? designation;
  String? tableNumber;
  String? uniqueCode;
  String? qrcodePath;
  String? eticketPath;
  String? createdAt;
  String? updatedAt;
  int? status;
  int? isPrinted;
  String? printedAt;

  Data(
      {this.userType,
        this.name,
        this.phone,
        this.company,
        this.designation,
        this.tableNumber,
        this.uniqueCode,
        this.qrcodePath,
        this.eticketPath,
        this.createdAt,
        this.updatedAt,
        this.status,
        this.isPrinted,
        this.printedAt});

  Data.fromJson(Map<String, dynamic> json) {
    userType = json['user_type'];
    name = json['name'];
    phone = json['phone'];
    company = json['company'];
    designation = json['designation'];
    tableNumber = json['table_number'];
    uniqueCode = json['unique_code'];
    qrcodePath = json['qrcode_path'];
    eticketPath = json['eticket_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    isPrinted = json['is_printed'];
    printedAt = json['printed_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_type'] = this.userType;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['company'] = this.company;
    data['designation'] = this.designation;
    data['table_number'] = this.tableNumber;
    data['unique_code'] = this.uniqueCode;
    data['qrcode_path'] = this.qrcodePath;
    data['eticket_path'] = this.eticketPath;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['is_printed'] = this.isPrinted;
    data['printed_at'] = this.printedAt;
    return data;
  }
}
