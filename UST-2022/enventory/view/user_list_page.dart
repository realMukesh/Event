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
import 'package:screenshot/screenshot.dart';
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
      return GetX<OnlineRedemtionController>(builder: (controller) {
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
                  var userData = controller.userList[index] as UserData;
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
                            title: "Email:", subtitle: userData.email ?? ""),
                        const SizedBox(
                          height: 12,
                        ),
                        _buildTitle(
                            title: "Unique Code:",
                            subtitle: userData.uniqueCode ?? ""),
                        const SizedBox(
                          height: 12,
                        ),
                        userData.printingStatus==0?Text(
                          userData.printingMessage ?? "",
                          style: TextStyle(color: Colors.red, fontSize: 12),
                          textAlign: TextAlign.center,
                        ):const SizedBox(),
                        const SizedBox(
                          height: 12,
                        ),
                        userData.printingStatus==1?InkWell(
                          onTap: () async {
                            await controller.updateAllotedStatus(
                                userData: userData, index: index);
                            setState(() {});
                          },
                          child: Container(
                            width: 120,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: const BoxDecoration(
                              color: button_color,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                            ),
                            child: Row(
                              children: [
                                const ImageIcon(
                                  AssetImage("assets/icons/print_icon.png"),
                                  color: button_color,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                RegularTextView(
                                  text: userData.isPrinted == 1
                                      ? "Re-Print"
                                      : "Print",
                                  color: white,
                                )
                              ],
                            ),
                          ),
                        ):const SizedBox()
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
      });
    });
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
            maxLine: 2,
            textSize: subtitle.toString().length>18?12:15,
            textAlign: TextAlign.start,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
