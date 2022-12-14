
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventery/api_repository/app_url.dart';
import '../../api_repository/api_service.dart';
import '../../common_controller/authentication_manager.dart';
import '../../customerWidget/regularTextView.dart';
import '../../theme/app_colors.dart';
import '../../theme/ui_helper.dart';
import '../model/common_model.dart';
import '../model/scan_result_model.dart';

class OnlineRedemtionController extends GetxController {
  late final AuthenticationManager _authManager;

  var userList = <UserData>[].obs;
  var isLoading = false.obs;
  var itemList = <XFile>[].obs;


  @override
  void onInit() {
    _authManager = Get.find();
  //  getInventoryList(null);
    super.onInit();
  }

  Future<bool> updateAllotedStatus({status,index}) async {
    var result=false;
    isLoading(true);
    CommonModel? transferListModel = await apiService.updateStatsus(status: status);
    if(transferListModel!.status!){
      userList[index].isPrinted=1;
      result= true;
      UiHelper.showAnimatedAlert(message: transferListModel!.message,buttonText: "OK");
    }else{
      result= false;
    }
    isLoading(false);
    return result;
  }

  final ImagePicker _picker = ImagePicker();
  void showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(
                        Icons.photo_library,
                        color: button_color,
                      ),
                      title: const RegularTextView(
                        text: "Photo",
                        textAlign: TextAlign.start,
                      ),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(bc).pop();
                      }),
                  ListTile(
                    leading:
                        const Icon(Icons.photo_camera, color: button_color),
                    title: const RegularTextView(
                        text: "Camera", textAlign: TextAlign.start),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(bc).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
  imgFromCamera() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 70,
    );
    itemList.add(pickedFile!);
  }
  imgFromGallery() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );
    itemList.add(pickedFile!);
  }
}
