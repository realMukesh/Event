/*
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inventery/dashboard/controller/cart_controller.dart';
import 'package:inventery/enventory/view/user_list_page.dart';
import '../../customerWidget/boldTextView.dart';
import '../../customerWidget/regularTextView.dart';
import 'package:get/get.dart';
import 'package:inventery/customerWidget/rounded_button.dart';
import 'package:inventery/dashboard/controller/home_controller.dart';
import 'package:inventery/theme/app_colors.dart';

class ConfirmDialogPage extends GetView<UserController> {
  ConfirmDialogPage({Key? key}) : super(key: key);
  final editController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.80),
      body: Container(
        margin: const EdgeInsets.only(top: 100),
        decoration: const BoxDecoration(
          color: bgcolor,
          borderRadius: BorderRadius.all(Radius.circular(50))
        ),
        height: context.height,
          padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 12),
          child:SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: (){
                          Get.back();
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: const [
                            Icon(Icons.circle,color: grayColorLight,size: 40,),
                            Icon(Icons.close),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 46,height: 5,
                        decoration: const BoxDecoration(
                          color: borderColor1,
                          borderRadius: BorderRadius.all(Radius.circular(50))
                        ),
                      ),
                    )
                  ],
                ),
                const BoldTextView(text: 'Transfer Device',textSize: 22,),
                const SizedBox(height: 6,),
                RegularTextView(text: 'Total ${controller.cartListOut.length} device added',textSize: 16,),
                const SizedBox(height: 50,),
                Row(
                  children: const [
                    BoldTextView(text: 'Add Photo'),
                    RegularTextView(text: " (Optional)")
                  ],
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  height: 100,
                  child: Row(
                    children: [
                      InkWell(onTap: (){
                        controller.showPicker(context);
                      },
                        child: SizedBox(width: 100,child: DottedBorder(
                          dashPattern: const [6, 6, 6, 6],
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12),
                          color: Colors.black,
                          padding: const EdgeInsets.all(6),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                            child: Container(
                              height: 80,
                              width: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.add,size: 50,),
                                  RegularTextView(text: 'Add Photo')
                                ],
                              ),
                            ),
                          ),
                        ),),
                      ),
                      Expanded(child: _addPhotoListWidget(context))
                    ],
                  ),
                ),
                const SizedBox(height: 30,),
                Row(
                  children: const [
                    BoldTextView(text: 'Comment'),
                    RegularTextView(text: " (Optional)")
                  ],
                ),
                const SizedBox(height: 20,),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      border: Border.all(color: grayColorLight)
                  ),
                  child: TextField(
                    controller: editController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration.collapsed(hintText: 'Text here...'),
                    maxLines: 6,
                    minLines: 1,
                    maxLength: 100,
                  ),
                ),
                const SizedBox(height: 20,),
                RoundedButton(text: 'Transfer Out', press: ()async {
                   var result=await controller.getUserList(context);
                   if(result['status']){
                     controller.comments=editController.text;
                     Get.toNamed(UserListPage.routeName);
                   }
                 // UiHelper.showAnimatedAlert(message: "",buttonText: "");
                })
              ],
            ),
          )
      ),
    );
  }
  _addPhotoListWidget(BuildContext context) {
    return GetX<UserController>(builder: (controller) {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.itemList.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Container(
                  height: 100,
                  margin: const EdgeInsets.all(6),
                  width: 100,
                  decoration:  BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: FileImage(File(controller.itemList[index].path)),
                      fit: BoxFit.cover,
                    ),
                  )),
              Positioned(
                right: 15,
                top: 10,
                child: InkWell(
                  onTap: (){
                    controller.itemList.removeAt(index);
                    controller.update();
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset('assets/icons/notification_circle.svg',color: const Color(0xffD55A5A),),
                      const Icon(Icons.close,color: white,size: 15,)
                    ],
                  ),
                ),)
            ],
          );
        },
      );
    });
  }

}
*/
