
class QuestionsModel {
  String? question;
  String? answer;
  bool? status;

  QuestionsModel(this.question, this.answer, this.status);

  QuestionsModel.fromJson(Map<dynamic, dynamic> json)
      : question = json['question'] as String,
        answer = json['answer'] as String,
        status = json['status'] as bool;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'question': question,
        'answer': answer,
        'status': status,
      };
}
