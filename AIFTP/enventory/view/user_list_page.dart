import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventery/customerWidget/boldTextView.dart';
import 'package:inventery/customerWidget/loading.dart';
import 'package:inventery/customerWidget/rounded_button.dart';
import 'package:inventery/customerWidget/toolbarTitle.dart';
import 'package:inventery/dashboard/controller/dashboard_controller.dart';
import 'package:inventery/enventory/model/scan_result_model.dart';
import 'package:inventery/theme/app_colors.dart';
import 'package:inventery/theme/strings.dart';
import 'package:lottie/lottie.dart';
import '../../customerWidget/regularTextView.dart';
import '../../dashboard/view/dashboard_page.dart';
import '../controller/onlineRedemtionController.dart';

class UserListPage extends GetView<OnlineRedemtionController> {
  UserListPage({Key? key}) : super(key: key);
  static const routeName = "/UserListPage";
  final DashboardController dashboardController = Get.find();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  var selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: black),
        title: const ToolbarTitle(title: 'User List'),
        shape:
            const Border(bottom: BorderSide(color: grayColorLight, width: 1)),
      ),
      body: Container(
          color: bgcolor,
          height: context.height,
          width: context.width,
          padding: const EdgeInsets.all(6),
          child: Stack(
            children: [
              buildListView(context),
              Obx(() => controller.isLoading.value
                  ? const Loading()
                  : const SizedBox())
            ],
          )),
    );
  }

  Widget buildListView(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return controller.userList.isNotEmpty
              ? ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 0,
                child: Container(
                  color: secondaryColor,
                ),
              );
            },
            itemCount: controller.userList.length,
            itemBuilder: (context, index) {
              var userData = controller.userList[index];
              return Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: home_color,
                    shape: BoxShape.rectangle,
                    border: Border.all(
                        color: selectedIndex.value == index
                            ? button_color
                            : Colors.transparent),
                    borderRadius:
                    const BorderRadius.all(Radius.circular(8))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    _buildTitle(
                        title: "Name:", subtitle: userData.name ?? ""),
                    const SizedBox(
                      height: 12,
                    ),
                    _buildTitle(
                        title: "Email:",
                        subtitle: userData.phone ?? ""),
                    const SizedBox(
                      height: 12,
                    ),
                    _buildTitle(
                        title: "Unique Code:",
                        subtitle: userData.uniqueCode ?? ""),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            controller.printQrCode(userData: userData);
                          },
                          child: Container(
                            width: 120,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: const BoxDecoration(
                              color: white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(25)),
                            ),
                            child: Row(
                              children: const [
                                ImageIcon(
                                  AssetImage(
                                      "assets/icons/print_icon.png"),
                                  color: button_color,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                RegularTextView(
                                  text: "Print",
                                  color: button_color,
                                )
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(
                          width: 30,
                        ),
                        InkWell(
                          onTap: () async {
                            if (userData.isPrinted == 0) {
                              await controller.updateAllotedStatus(
                                  userData: userData, index: index);
                              setState((){
                              });
                            }
                          },
                          child: Container(
                            width: 120,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: userData.isPrinted == 1
                                  ? Colors.green
                                  : white,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(25)),
                            ),
                            child: Row(
                              children: [
                                ImageIcon(
                                  AssetImage(
                                      "assets/icons/print_icon.png"),
                                  color: userData.isPrinted == 1
                                      ? Colors.white
                                      : button_color,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                RegularTextView(
                                  text: userData.isPrinted == 1
                                      ? "Allotted"
                                      : "Allot",
                                  color: userData.isPrinted == 1
                                      ? Colors.white
                                      : button_color,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          )
              : Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      'assets/logo.png',
                      width: 100,
                    ),
                  ),
                  const RegularTextView(
                      text: "User Data not found.",
                      textSize: 14,
                      color: title_color,
                      textAlign: TextAlign.center),
                  InkWell(
                      onTap: () {
                        _refreshIndicatorKey.currentState?.show();
                      },
                      child: const Icon(
                        Icons.refresh,
                        size: 40,
                      ))
                ],
              ));
        },
    );
  }

  _buildTitle({required title, required subtitle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RegularTextView(
          text: title,
          textSize: 15,
          textAlign: TextAlign.start,
          color: gray1,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: RegularTextView(
            text: subtitle,
            textSize: 15,
            textAlign: TextAlign.start,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  _openBottomDialog(BuildContext context, String message) {
    Get.bottomSheet(
      Container(
          decoration: const BoxDecoration(
              color: bgcolor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35), topRight: Radius.circular(35))),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          //controller.getTransferOutCart();
                          dashboardController.tabIndex = 1;
                          Get.offNamedUntil(
                              DashboardPage.routeName, (route) => false);
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: const [
                            Icon(
                              Icons.circle,
                              color: grayColorLight,
                              size: 40,
                            ),
                            Icon(Icons.close),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 46,
                        height: 5,
                        decoration: const BoxDecoration(
                            color: borderColor1,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Lottie.asset('assets/success.json', width: 100),
                const SizedBox(
                  height: 12,
                ),
                const BoldTextView(
                  text: MyStrings.request_sent_sucessfully,
                  textSize: 22,
                ),
                const SizedBox(
                  height: 6,
                ),
                RegularTextView(
                  text: message,
                  textSize: 16,
                  color: gray1,
                ),
                const SizedBox(
                  height: 6,
                ),
                //const BoldTextView(text: 'MacBook Pro.',textSize: 16,color: black,),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 100,
                  child: RoundedButton(
                      text: MyStrings.ok,
                      press: () {
                        // controller.getTransferOutCart();
                        dashboardController.tabIndex = 1;
                        Get.offNamedUntil(
                            DashboardPage.routeName, (route) => false);
                      }),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          )),
      barrierColor: Colors.black.withOpacity(0.80),
      isDismissible: false,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
          side: const BorderSide(width: 5, color: Colors.white)),
      enableDrag: true,
    );
  }
}
