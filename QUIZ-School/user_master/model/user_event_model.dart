class UserEventModel {
  String? schoolName;
  String? teamName;
  DateTime? dateTime;
  String? userId;

  UserEventModel(this.teamName, this.schoolName, this.dateTime, this.userId);

  UserEventModel.fromJson(Map<dynamic, dynamic> json)
      : schoolName = json['school_name'] as String,
        teamName = json['team_name'] as String,
        dateTime = DateTime.parse(json['date_time'] as String),
        userId = json['user_id'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'school_name': schoolName,
        'team_name': teamName,
        'date_time': dateTime.toString(),
        'user_id': userId,
      };
}
