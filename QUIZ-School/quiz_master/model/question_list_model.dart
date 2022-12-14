class QuestionListModel {
  bool? success;
  String? message;
  List<QuestionData>? data;

  QuestionListModel({this.success, this.message, this.data});

  QuestionListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <QuestionData>[];
      json['data'].forEach((v) {
        data!.add(new QuestionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuestionData {
  int? id;
  String? question;
  String? answer;
  bool isAsked=false;

  QuestionData({this.id, this.question, this.answer});

  QuestionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['answer'] = this.answer;
    return data;
  }
}
