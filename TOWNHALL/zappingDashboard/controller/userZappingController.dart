
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventery/api_repository/app_url.dart';
import '../../api_repository/api_service.dart';
import '../../common_controller/authentication_manager.dart';
import '../../customerWidget/regularTextView.dart';
import '../../enventory/model/common_model.dart';
import '../../enventory/model/scan_result_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/ui_helper.dart';
import '../view/confim_dialog_page.dart';


class ZappingUserController extends GetxController {
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



  Future<void> entryZappingApi({code,location,index}) async {
    isLoading(true);
    CommonModel? transferListModel = await apiService.entryZapping(code: code,location: _authManager.getLocation());
    if(transferListModel!.status!){
      Get.to(ConfirmDialogPage(isSuccess: true,message: transferListModel.message.toString()));
    }else{
      Get.to(ConfirmDialogPage(isSuccess: true,message: transferListModel.message!!));
    }
    isLoading(false);
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
