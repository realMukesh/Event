import 'dart:async';

import 'package:firebase_chat/customerWidget/boldTextView.dart';
import 'package:firebase_chat/customerWidget/regularTextView.dart';
import 'package:firebase_chat/customerWidget/rounded_button.dart';
import 'package:firebase_chat/customerWidget/rounded_outline_button.dart';
import 'package:firebase_chat/quiz_master/model/question_list_model.dart';
import 'package:firebase_chat/quiz_master/model/question_model.dart';
import 'package:firebase_chat/theme/app_colors.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../customerWidget/toolbarTitle.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../../theme/strings.dart';
import '../../theme/ui_helper.dart';
import '../../user_master/model/user_event_model.dart';
import '../controller/quiz_master_controller.dart';

class QuizMasterPage extends GetView<QuizMasterController> {
  final DashboardController dashboardController = Get.find();
  QuestionData questionData;
  int questionIndex;
  int timer;
  QuizMasterPage({Key? key,required this.questionData,required this.questionIndex,required this.timer}) : super(key: key);
  var passIndex=0.obs;

  @override
  Widget build(BuildContext context) {

    Future<bool> showExitPopup() async {
      return await showDialog( //show confirm dialogue
        //the return value will be from "Yes" or "No" options
        context: context,
        builder: (context) => AlertDialog(
          title: const BoldTextView(text: "Aditya Birla Quiz",textSize: 28,),
          content: const Text(MyStrings.backAlertMsg,style: TextStyle(color: black,fontSize: 14,fontFamily: 'Poppins'),),
          actions:[
            TextButton(
              child: const RegularTextView(text: "Back",),
              onPressed: () {
                Get.back(result: true);
              },
            ),
            TextButton(
              child: const RegularTextView(text: "Cancel",),
              onPressed: () {
                Get.back(result: false);
              },
            ),

          ],
        ),
      )??false; //if showDialouge had returned null, then return false
    }

    return WillPopScope(onWillPop: showExitPopup, child: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/splash.png",),fit: BoxFit.cover)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 70,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
          title: ToolbarTitle(title: 'Question ${controller.questionCount()}/${controller.questionList.length}'),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(12),
          child: GetX<QuizMasterController>(
            builder: (sController) => Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   /* Obx(()=>Center(child: RegularTextView(text: '${""} ${dashboardController.start} ${"Sec."}',
                        color:Colors.white,textSize: 20)),),*/
                    const SizedBox(height: 30,),
                    _buildMessage(context),
                    const SizedBox(height: 30,),
                    controller.showBuzzer.value?const BoldTextView(text: "Buzzer Pressed",color: Colors.white,):const SizedBox(),
                    const SizedBox(height: 30,),
                    _buildTeamRank(context),
                    const SizedBox(height: 100,)
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _buildButton(context),
                ),
                controller.isLoading.value?const SizedBox():SizedBox(),


              ],
            ),),
        ),
      ),
    ));
  }

  _buildMessage(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: home_color,
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Q.${questionData.question??""}", textAlign: TextAlign.start,
              softWrap: true,
              style: const TextStyle(
                  fontSize: 22, color: questionColor, fontFamily: 'Poppins',fontWeight: FontWeight.w500)),
          const SizedBox(height: 20,),
          Text("A.${questionData.answer??""}", textAlign: TextAlign.start,
              softWrap: true,
              style: const TextStyle(
                  fontSize: 22, color: white, fontFamily: 'Poppins',fontWeight: FontWeight.w500))
        ],
      ),
    );
  }

  _buildButton(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1,child: RoundedButton(text: controller.isPushEnable.value?"ASK":"Complete", color: white,
            press: () async {
              if(!controller.isPushEnable.value){
                controller.clearQuestion();
                Get.back();
              }else{
                var result=await UiHelper.showAlertDialog(title: "Live Campus Quiz",yes:MyStrings.yes,no:MyStrings.no,message: MyStrings.are_u_sure_want_live);
                if(result){
                  dashboardController.questionIds.add(questionData.id);
                  controller.update();
                  controller.sendQuestionLive(QuestionsModel(questionData.question, questionData.answer, true),context);
                  dashboardController.startTimer();
                }

              }

        }),),

        const SizedBox(width: 12,),
        Expanded(flex: 1,child: RoundedOutlineButton(
          textColor: controller.showBuzzer.value && passIndex.value==0? white:grayColorLight,color: controller.showBuzzer.value && passIndex.value==0? primaryColor:primaryColor ,
            text: "PASS", press: (){
            if(passIndex.value==0 && controller.showBuzzer.value){
              passIndex(1);
            }
        }),)
      ],
    );
  }

  _buildTeamRank(BuildContext context) {
    return Expanded(
      child: FirebaseAnimatedList(
        query: controller.getUserEvent(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, snapshot, animation, index) {
          final json = snapshot.value as Map<dynamic, dynamic>;
          final rankModel = UserEventModel.fromJson(json);
          return Obx(()=>Container(
            padding: const EdgeInsets.all(0.0),
            width: 100,
            margin: const EdgeInsets.all(3),
            decoration: BoxDecoration(
                color: index==passIndex.value?primaryColor:home_color ,
                border: Border.all(color: index==passIndex.value?white:Colors.transparent ,width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(10))
            ),
            child: Center(child: _buildTeamName(context,rankModel),),
          ));
        },
      ),
    );
  }

  _buildTeamName(BuildContext context, UserEventModel rankModel,){
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


