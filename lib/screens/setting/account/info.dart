import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/data/controllers/user_controller.dart';
import 'package:pos_app/screens/setting/account/edit.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:pos_app/widgets/circle_border_asset.dart';
import 'package:pos_app/widgets/circle_border_avatar.dart';

class AccountScreen extends GetView<UserController> {
  @override
  Widget build(BuildContext context) {
    UserController userController = Get.put(UserController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppUltils.buildAppBar(
          height: 40,
          title: 'label.store_info'.tr,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text('common.logo_store'.tr, style: TextStyle(fontSize: 18.0, color: Colors.black54)),
                      SizedBox(
                        height: 10,
                      ),
                      Stack(
                        children: [
                          Hero(
                            tag: 'avatar',
                            child: userController.userInfo!.logo != null
                                ? CircleBorderAvatar(
                                    height: 150,
                                    width: 150,
                                    imageUrl: userController.userInfo!.logo!,
                                  )
                                : CircleBorderAsset(
                                    imageUrl: 'assets/icons/pos.png',
                                    height: 150,
                                    width: 150,
                                    circular: 200,
                                  ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                userController.addImageModalBottomSheet(context);
                              },
                              child: Container(
                                height: 35,
                                width: 35,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Palette.primaryColor,
                                  borderRadius: BorderRadius.circular(200),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(200),
                                  child: Icon(
                                    FontAwesome.camera,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        userController.userInfo!.name ?? '',
                        style: Palette.textTitle1(),
                      ),
                      RowItemInfo(
                        label: 'Hotline'.tr,
                        content: userController.userInfo!.phone!,
                      ),
                      RowItemInfo(
                        label: 'Email'.tr,
                        content: userController.userInfo!.email ?? '',
                      ),
                      RowItemInfo(
                        label: 'common.address'.tr,
                        content: userController.userInfo!.address ?? '',
                      ),
                      // RowItemInfo(
                      //   label: 'Gi???i t??nh',
                      //   content: 'Nam',
                      // ),
                      // RowItemInfo(
                      //   label: 'Qu???c gia',
                      //   content: 'Vi???t nam',
                      // ),
                      SizedBox(
                        height: 30,
                      ),
                      FlatButton.icon(
                        onPressed: () async {
                          Get.to(EditStoreScreen());
                        },
                        icon: Icon(Icons.edit, color: Colors.white),
                        label: Text('common.edit'.tr, style: TextStyle(color: Colors.white)),
                        color: Palette.primaryColor,
                        minWidth: Get.width,
                        height: 50,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RowItemInfo extends StatelessWidget {
  const RowItemInfo({
    Key? key,
    this.content,
    this.label,
  }) : super(key: key);

  final String? label;
  final String? content;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 15,
        ),
        Text(
          label!,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          content ?? '',
          style: TextStyle(
            fontSize: 16,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        Divider(),
      ],
    );
  }
}
