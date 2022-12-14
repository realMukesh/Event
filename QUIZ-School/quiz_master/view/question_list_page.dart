
import 'package:firebase_chat/quiz_master/view/quiz_mater_page.dart';
import 'package:firebase_chat/theme/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_chat/customerWidget/loading.dart';
import 'package:firebase_chat/dashboard/controller/dashboard_controller.dart';
import 'package:firebase_chat/theme/app_colors.dart';
import '../../customerWidget/regularTextView.dart';
import '../controller/quiz_master_controller.dart';
class QuestionListPage extends GetView<QuizMasterController> {
  QuestionListPage({Key? key}) : super(key: key);
  final DashboardController dashboardController = Get.find();

  @override
  final controller = Get.put(QuizMasterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(6),
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(child: buildListView(context)),
                  const SizedBox(height: 20,)
                ],
              ),
              Obx(()=>controller.isLoading.value?const Loading():const SizedBox())
            ],
          )),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          dashboardController.questionIds.clear();
        },
        child: const Icon(Icons.lock_reset_rounded),
      ),*/
    );
  }
  Widget buildListView(BuildContext context) {
    return GetX<QuizMasterController>(builder: (controller) {
      return controller.questionList.isNotEmpty
          ? ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 0,
            child: Container(
              color: secondaryColor,
            ),
          );
        },
        itemCount: controller.questionList.length,
        itemBuilder: (context, index) {
          var questionData=controller.questionList[index];
          var questionIndex=index+1;
          return InkWell(
            onTap: (){
             // controller.isPushEnable(true);
              if(dashboardController.questionIds.contains(questionData.id)){
                UiHelper.showSnakbarMsg(context, "Sorry, You already asked the this question.");
                return;
              }
              controller.clearQuestion();
              Get.to(QuizMasterPage(questionData:questionData,questionIndex: index,timer: 30,));
              controller.update();
            },
            child: Obx(()=>Container(
              margin: const EdgeInsets.all(6),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white,width: 1),
                    color: dashboardController.questionIds.contains(questionData.id)?disable_color:primaryColor,borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                padding: const EdgeInsets.all(20),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title:Text(
                      "$questionIndex. ${questionData.question??""}",style: TextStyle(fontSize: 18,color: Colors.white,fontFamily: 'Poppins',),softWrap: true,
                  ),
                  trailing: dashboardController.questionIds.contains(questionData.id)?const Icon(Icons.check_circle,color: Colors.white,):const SizedBox(),
                ),

              ),
            )),
          );
        },
      )
          : const Center(
          child: RegularTextView(
              text: "Loading...",
              textSize: 22,
              color: white,
              textAlign: TextAlign.center));
    });
  }
}


