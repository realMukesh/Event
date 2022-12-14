import 'package:firebase_chat/customerWidget/boldTextView.dart';
import 'package:firebase_chat/customerWidget/regularTextView.dart';
import 'package:firebase_chat/login/view/mainPage.dart';
import 'package:firebase_chat/theme/app_colors.dart';
import 'package:firebase_chat/theme/strings.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'controller/loginController.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({Key? key}) : super(key: key);
  static const routeName = "/welcome_page";
  final GlobalKey<FormState> formKey = GlobalKey();
  var isContinueClick = false.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/outer_bg.png"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: appBarColor,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: _buildContinue(),
        ),
      ),
    );
  }


  Widget _buildContinue() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/bg_inner.png'),
                    fit: BoxFit.cover))),

        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Image.asset(
                        "assets/logo.png",
                        height: 50,
                      ),
                    ))),
            _buildStep(
                "STEP 1", "Fill us in! Type out your credentials on the iPad."),
            SizedBox(height: 20,),
            _buildStep("STEP 2", "Brace yourself! Collect your token."),
            SizedBox(height: 20,),
            _buildStep("STEP 3", "Get creative and pick your style."),
            SizedBox(height: 20,),
            _buildStep("STEP 4",
                "You’re almost done! Go ahead and get your design on."),
            Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                    onTap: () {
                      Get.toNamed(MainPage.routeName);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Image.asset(
                        "assets/continue.png",
                        height: 50,
                      ),
                    ))),
          ],
        ),

      ],
    );
  }

  Widget _buildAgree() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/inner_bg.png'),
                    fit: BoxFit.cover))),
        Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
                onTap: () {
                  Get.toNamed(MainPage.routeName);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Image.asset("assets/agree_img.png", height: 40),
                ))),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 100, horizontal: 12),
          child: SingleChildScrollView(
            child: Text(
              MyStrings.paragraph,
              style: TextStyle(
                color: white,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Align(
            alignment: Alignment.topCenter,
            child: InkWell(
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Text(
                    "WAIVER FORM",
                    style: const TextStyle(fontFamily: "Brewmaster",fontSize: 30,fontStyle: FontStyle.normal,fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                )))
      ],
    );
  }

  Widget _buildStep(title, subTitle) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontFamily: "Brewmaster",fontSize: 30,fontStyle: FontStyle.normal,fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      subtitle: RegularTextView(
        text: subTitle,
        color: Colors.white,
        textAlign: TextAlign.center,
      ),
    );
  }
}
