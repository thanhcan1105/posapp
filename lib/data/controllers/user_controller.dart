import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_app/data/store/master_storage.dart';
import 'package:pos_app/models/user_model.dart';

class UserController extends GetxController {
  var imagePickerPath = ''.obs;
  final picker = ImagePicker();
  File? selectedImage;
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();

  UserModel? userInfo;

  Timer? _debounce;
  RxBool isSearchActive = false.obs;
  RxBool isLoading = true.obs;

  GetStorage box = GetStorage();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userInfo = new UserModel(
      address: MasterConfig().storeInfo!.address,
      name: MasterConfig().storeInfo!.name,
      phone: '19000000' + MasterConfig().storeInfo!.hotline!,
      email: 'vinatech@gmail.com',
      logo: MasterConfig().storeInfo!.bannerImage,
    );
  }

  addImageModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                leading: Image.asset(
                  'assets/icons/camera.png',
                  height: 30,
                ),
                title: new Text('common.shoot'.tr),
                onTap: () {
                  //Get.to(AddPostScreen());
                  getImage(from: ImageSource.camera);
                },
              ),
              new ListTile(
                leading: Image.asset(
                  'assets/icons/picture.png',
                  height: 30,
                ),
                title: new Text('common.select_from_gallery'.tr),
                onTap: () {
                  getImage(from: ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImage({ImageSource? from}) async {
    final pickedFile = await ImagePicker().pickImage(source: from!, imageQuality: 100);
    if (pickedFile != null) {
      imagePickerPath.value = (pickedFile.path);
      selectedImage = File(pickedFile.path);
      Get.back();
    } else {
      print('No image selected.');
    }
  }
}
