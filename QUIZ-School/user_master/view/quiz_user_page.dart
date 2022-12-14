//import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_chat/customerWidget/boldTextView.dart';
import 'package:firebase_chat/user_master/model/user_event_model.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../customerWidget/regularTextView.dart';
import '../../quiz_master/model/question_model.dart';
import '../../theme/app_colors.dart';
import '../controller/user_controller.dart';

class QuizUserPage extends GetView<UserController> {
  QuizUserPage({Key? key}) : super(key: key);

  @override
  final controller = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(12),
      child: GetX<UserController>(
        builder: (sController) => Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /* Obx(()=>Center(child: RegularTextView(text: '${""} ${controller.dashboardController.start} ${"Sec."}',
                        color:Colors.white,textSize: 20)),),*/
                controller.isQuestionFound.value?_getMessageList():const BoldTextView(text: "Welcome Team",color: Colors.white,textSize: 17,),
                const SizedBox(height: 30,),
                _buildButton(),
                const SizedBox(height: 30,),
                Align(
                  alignment: Alignment.topLeft,
                  child: controller.showBuzzer.value?const BoldTextView(text: "Buzzer Pressed By",color: Colors.white,textAlign: TextAlign.start,):const SizedBox(),
                ),
                const SizedBox(height: 10,),
                _buildTeamRank(context),
                const SizedBox(height: 30,),
              ],
            ),
            const SizedBox(height: 100,),

          ],
        ),
      ),
    );
  }
  _buildMessage(QuestionsModel message) {
    return Container(
      decoration: const BoxDecoration(
          color: home_color,borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      padding: const EdgeInsets.all(30),
      child: Text(
        "1. ${message.question??""}",style: const TextStyle(fontSize: 18,color: questionColor,fontFamily: 'Poppins',fontWeight: FontWeight.bold),softWrap: true,textAlign: TextAlign.start
      ),
    );
  }

  _buildButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          elevation: 20,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100)),
          child: Container(
            height: 156,
            width: 156,
            decoration:  BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: white,width: 12)
            ),
            child: MaterialButton(
                animationDuration: const Duration(seconds: 1),
                color: controller.isQuestionFound.value && !controller.isBuzzerPressed.value?Colors.red:grayColorLight,
                hoverColor: focusColor,
                splashColor: focusColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: () {
                  if(!controller.isQuestionFound.value ||  controller.isBuzzerPressed.value){
                    return;
                  }
                  //in case of play sound.
                  //AudioPlayer().play(AssetSource('buzzer-answer.mp3'));
                  controller.sendRankStatus(
                      rankModel: UserEventModel(controller.authenticationManager.getTeamName(),
                          controller.authenticationManager.getSchoolName(),
                          DateTime.now(), controller.authenticationManager.getUserId()));
                },
                child: const BoldTextView(text: "PRESS",color: white,textSize: 18,)),
          ),
        ),
        const SizedBox(height: 20,),
        const BoldTextView(text: "Press buzzer to answer the question!",color: white,)
      ],
    );
  }

  Widget _getMessageList() {
    return FirebaseAnimatedList(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      query: controller.getMessageQuery(),
      itemBuilder: (context, snapshot, animation, index) {
        final json = snapshot.value as Map<dynamic, dynamic>;
        final message = QuestionsModel.fromJson(json);
        return _buildMessage(message);
      },
    );
  }

  Widget isQuestionListEmpty() {
    return Center(child: FirebaseAnimatedList(
      query: controller.getMessageQuery(),
      itemBuilder: (context, snapshot, animation, index) {
        final json = snapshot.value as Map<dynamic, dynamic>;
        final message = QuestionsModel.fromJson(json);
        return _buildMessage(message);
      },
    ));
  }

  _buildTeamRank(BuildContext context) {
    var passIndex=0;
    return Expanded(
      child: FirebaseAnimatedList(
        query: controller.getUserEvent(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, snapshot, animation, index) {
          final json = snapshot.value as Map<dynamic, dynamic>;
          final rankModel = UserEventModel.fromJson(json);
          if(rankModel.userId==controller.authenticationManager.getUserId()){
           //controller.showBuzzer.value=false;
          }
          return Container(
            padding: const EdgeInsets.all(0.0),
            width: 100,
            margin: const EdgeInsets.all(3),
            decoration: BoxDecoration(
                color: index==passIndex?primaryColor:home_color ,
                border: Border.all(color: index==passIndex?white:Colors.transparent ,width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(10))
            ),
            child: Center(child: _buildTeamName(context,rankModel),),
          );
        },
      ),
    );
  }

  _buildTeamName(BuildContext context, UserEventModel rankModel){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(0),
      child: ListTile(
        title: RegularTextView(text: rankModel.teamName??"",color: questionColor,),
        subtitle: BoldTextView(text: rankModel.schoolName??"",color: white,textAlign: TextAlign.start,),
      ),
    );
  }
}
