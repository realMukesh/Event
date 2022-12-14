class LoginResponseModel {
  bool? status;
  String? message;
  User? user;
  List<String>? location;

  LoginResponseModel({this.status, this.message, this.user, this.location});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    location = json['location'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['location'] = this.location;
    return data;
  }
}

class User {
  int? id;
  int? roleId;
  String? username;
  String? category;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.roleId,
        this.username,
        this.category,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    username = json['username'];
    category = json['category'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role_id'] = this.roleId;
    data['username'] = this.username;
    data['category'] = this.category;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
