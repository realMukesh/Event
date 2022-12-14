class LoginResponseModel {
  bool? success;
  String? message;
  ProfileData? results;

  LoginResponseModel({this.success, this.message, this.results});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    results =
    json['data'] != null ? new ProfileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.results != null) {
      data['data'] = this.results!.toJson();
    }
    return data;
  }
}

class ProfileData {
  dynamic? sId;
  dynamic? role;
  String? name;
  String? teamName;
  String? email;
  String? token;

  ProfileData(
      {
        this.sId,
        this.role,
        this.name,
        this.teamName,
        this.email,
        this.token,});

  ProfileData.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    role = json['role'];
    name = json['name'];
    teamName = json['team_name'];
    email = json['email'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['role'] = this.role;
    data['name'] = this.name;
    data['team_name'] = this.teamName;
    data['email'] = this.email;
    data['token'] = this.token;
    return data;
  }
}