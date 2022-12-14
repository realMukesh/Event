import 'package:firebase_chat/common_controller/authentication_manager.dart';
import 'package:firebase_chat/dashboard/controller/dashboard_controller.dart';
import 'package:firebase_chat/theme/ui_helper.dart';
import 'package:firebase_chat/user_master/model/user_event_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:firebase_chat/quiz_master/model/question_model.dart';

class UserController extends GetxController{
  var productList =<QuestionsModel>[].obs;

  var isLoading=false.obs;
  final DashboardController _dashboardController = Get.find();

  DashboardController get dashboardController => _dashboardController;

  final AuthenticationManager _authenticationManager = Get.find();

  AuthenticationManager get authenticationManager => _authenticationManager;

  var isQuestionFound=false.obs;
  var showBuzzer=false.obs;
  //var isListNotEmpty=false.obs;
  var isBuzzerPressed=false.obs;

  @override
  void onInit() {
    onChildAdded();
    onBuzzerPress();
    onValue();
    super.onInit();
  }

  Query getMessageQuery() {
    return _dashboardController.messagesRef;
  }
  Query getUserEvent() {
    return _dashboardController.rankRef;
  }

  void onChildAdded(){
    Query quizData = _dashboardController.messagesRef;
    quizData.onChildAdded.listen((event){
      if(event.snapshot.value!=null){
        isBuzzerPressed(false);
        //isQuestionFound(true);
      }
    });
  }
  void onValue(){
    Query quizData = _dashboardController.messagesRef;
    quizData.onValue.listen((event){
      if(event.snapshot.value!=null){
        isQuestionFound(true);
      }else{
        isQuestionFound(false);
      }
    });
  }

  void onBuzzerPress(){
    Query quizData = _dashboardController.rankRef;
    quizData.onValue.listen((event){
      if(event.snapshot.value!=null){
        showBuzzer(true);
        final json = event.snapshot.value as Map<dynamic, dynamic>;
        for (var entry in json.entries) {
          if(entry.value["user_id"]==authenticationManager.getUserId()){
            isBuzzerPressed(true);
          }
        }
      }else{
        showBuzzer(false);
      }
    });
  }
  /*insert new  rank on firebase*/
  void sendRankStatus({required UserEventModel rankModel}) {
    _dashboardController.rankRef.push().set(rankModel.toJson()).then((_) {
      isBuzzerPressed(true);
      //isQuestionFound(false);
    }).catchError((onError) {
      print(onError);
    });
  }





}