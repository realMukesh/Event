import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventery/customerWidget/loading.dart';
import 'package:inventery/customerWidget/toolbarTitle.dart';
import 'package:inventery/enventory/model/scan_result_model.dart';
import 'package:inventery/theme/app_colors.dart';
import '../../customerWidget/regularTextView.dart';
import '../controller/userZappingController.dart';
import '../controller/zapping_controller.dart';

class ZappingUserListPage extends GetView<ZappingUserController> {
  ZappingUserListPage({Key? key}) : super(key: key);
  static const routeName = "/ZappingUserListPage";
  final ZappingController zappingController = Get.find();

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
      builder: (BuildContext context, StateSetter setState) => GetX<ZappingUserController>(builder: (controller) {
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
                      color: grayColorLight),
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
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
                      title: "Phone:", subtitle: userData.phone ?? ""),
                  const SizedBox(
                    height: 12,
                  ),
                  _buildTitle(
                      title: "Unique Code:",
                      subtitle: userData.uniqueCode ?? ""),
                  const SizedBox(
                    height: 12,
                  ),
                  InkWell(
                    onTap: () async {
                      await controller.entryZappingApi(
                          code: userData.uniqueCode,
                          location: zappingController.selectedLocation,index: index);
                      setState((){
                      });
                    },
                    child: Container(
                      width: 120,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: userData.isPrinted == 0
                            ? Colors.green
                            : Colors.red,
                        borderRadius:
                        const BorderRadius.all(Radius.circular(25)),
                      ),
                      child: Row(
                        children: [
                          ImageIcon(
                            const AssetImage("assets/icons/print_icon.png"),
                            color: userData.isPrinted == 0
                                ? Colors.white
                                : Colors.white,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          RegularTextView(
                            text: userData.isPrinted == 1
                                ? "Allotted"
                                : "Allot",
                            color: userData.isPrinted == 0
                                ? Colors.white
                                : Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
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
      }),
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
}
