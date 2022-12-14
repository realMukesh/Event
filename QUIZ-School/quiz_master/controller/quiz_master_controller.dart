import 'dart:async';

import 'package:firebase_chat/dashboard/controller/dashboard_controller.dart';
import 'package:firebase_chat/theme/ui_helper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_chat/quiz_master/model/question_model.dart';

import '../../api_repository/api_service.dart';
import '../model/question_list_model.dart';

class QuizMasterController extends GetxController {
  var questionList =<QuestionData>[].obs;
  var isPushEnable=false.obs;

  var isLoading=false.obs;
  final DashboardController _dashboardController = Get.find();
  var questionsModel=QuestionsModel("","",false).obs;
  var showBuzzer=false.obs;

  @override
  void onInit() {
    getQuestionList();
    super.onInit();
    onChildAdded();
    onChildRemoved();
  }

  Future<void> getQuestionList() async {
    isLoading(true);
    QuestionListModel? questionListModel = await apiService.getQuestionList();
    isLoading(false);
    if (questionListModel!.success!) {
      questionList.addAll(questionListModel.data??[]);
    } else {
      print(questionListModel.message.toString());
    }
  }

  Query getUserEvent() {
    return _dashboardController.rankRef;
  }

  /*update question with required parameter*/
  void updateQuestion({required status}){
    _dashboardController.messagesRef.update({
      "status": status,
    }).then((_) {
      UiHelper.showAnimatedAlert(message: "Question is live for all the user",buttonText: "OK");
    }).catchError((onError) {

    });
  }
  /*insert new  question on firebase*/
  void sendQuestionLive(QuestionsModel message,BuildContext context) {
    _dashboardController.messagesRef.push().set(message.toJson()).then((_) {
      isPushEnable(false);
      //UiHelper.showSnakbarMsg(context, "Question is live for all the user");
      //UiHelper.showAnimatedAlert(message: "Question is live for all the user",buttonText: "OK");
    }).catchError((onError) {

    });
  }
  clearQuestion(){
    isPushEnable(true);
    _dashboardController.messagesRef.remove();
    _dashboardController.rankRef.remove();
  }

  void onChildAdded(){
    Query quizData = _dashboardController.rankRef;
    var snapshot = quizData.onChildAdded.listen((event){
      if(event.snapshot.value!=null){
        showBuzzer(true);
      }else{
        showBuzzer(false);
      }
      print(" Question is remove successfully-: ${event.snapshot.value}");
    });
  }

  void onChildRemoved(){
    Query quizData = _dashboardController.messagesRef;
    var snapshot = quizData.onChildRemoved.listen((event){
      showBuzzer(false);
      print(" Question is remove successfully-: ${event.snapshot.value}");
    });
  }
  String questionCount(){
    var count = questionList.where((i) => _dashboardController.questionIds.contains(i.id)).toList().length;
    return count.toString();
  }
}